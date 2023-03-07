package dev.duynp.flutter_health_connect

import android.app.Activity
import android.content.Intent
import android.net.Uri
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.PermissionController
import androidx.health.connect.client.changes.UpsertionChange
import androidx.health.connect.client.request.ChangesTokenRequest
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.fasterxml.jackson.databind.ObjectMapper

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.*
import java.time.*
import java.time.temporal.ChronoUnit
import java.util.ArrayList
import java.util.HashMap
import java.util.concurrent.TimeUnit

/** FlutterHealthConnectPlugin */
class FlutterHealthConnectPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    var replyMapper: ObjectMapper = ObjectMapper()
    private lateinit var channel: MethodChannel
    private var permissionResult: Result? = null
    private lateinit var client: HealthConnectClient
    private var currentActivity: Activity? = null
    lateinit var scope: CoroutineScope

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        scope = CoroutineScope(SupervisorJob() + Dispatchers.Main)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_health_connect")
        channel.setMethodCallHandler(this)
        client = HealthConnectClient.getOrCreate(flutterPluginBinding.applicationContext)
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        scope.cancel()
        currentActivity = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        currentActivity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        currentActivity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        currentActivity = null;
    }

    override fun onDetachedFromActivity() {
        currentActivity = null;
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val activityContext = currentActivity
        if (activityContext == null) {
            result.error("NO_ACTIVITY", "No activity available", null)
            return
        }
        val args = call.arguments as HashMap<*, *>
        val requestedTypes = (args["types"] as? ArrayList<*>)?.filterIsInstance<String>()
        when (call.method) {

            "isApiSupported" -> {
                result.success(HealthConnectClient.isApiSupported())
            }

            "isAvailable" -> {
                result.success(HealthConnectClient.isProviderAvailable(activityContext))
            }

            "installHealthConnect" -> {
                val intent = Intent(Intent.ACTION_VIEW).apply {
                    data = Uri.parse(playStoreUri)
                    setPackage("com.android.vending")
                }
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                runCatching { activityContext.startActivity(intent) }
            }

            "hasPermissions" -> {
                scope.launch {
                    val isReadOnly = call.argument<Boolean>("readOnly") ?: false
                    val granted = client.permissionController.getGrantedPermissions()
                    val status =
                        granted.containsAll(mapTypesToPermissions(requestedTypes, isReadOnly))
                    result.success(status)
                }
            }

            "requestPermissions" -> {
                permissionResult = result
                val isReadOnly = call.argument<Boolean>("readOnly") ?: false
                val allPermissions = mapTypesToPermissions(
                    requestedTypes,
                    isReadOnly
                )

                val contract = PermissionController.createRequestPermissionResultContract()
                val intent = contract.createIntent(activityContext, allPermissions)
                activityContext.startActivityForResult(intent, HEALTH_CONNECT_RESULT_CODE)
            }
            "getChanges" -> {
                val token = call.argument<String>("token") ?: ""
                scope.launch {
                    try {
                        val changes = client.getChanges(token)
                        val reply = replyMapper.convertValue(
                            changes,
                            hashMapOf<String, Any>()::class.java
                        )
                        val typedChanges = changes.changes.mapIndexed { _, change ->
                            if (change is UpsertionChange) {
                                hashMapOf(
                                    change::class.simpleName to
                                            hashMapOf(
                                                change.record::class.simpleName to
                                                        replyMapper.convertValue(
                                                            change,
                                                            hashMapOf<String, Any>()::class.java
                                                        )
                                            )
                                )
                            } else {
                                hashMapOf(
                                    change::class.simpleName to
                                            replyMapper.convertValue(
                                                change,
                                                hashMapOf<String, Any>()::class.java
                                            )
                                )
                            }
                        }
                        reply["changes"] = typedChanges
                        result.success(reply)
                    } catch (e: Throwable) {
                        result.error("GET_CHANGES_FAIL", e.localizedMessage, e)
                    }
                }

            }
            "getChangesToken" -> {
                val recordTypes = requestedTypes?.mapNotNull {
                    HealthConnectRecordTypeMap[it]
                }?.toSet() ?: emptySet()
                scope.launch {
                    try {
                        result.success(
                            client.getChangesToken(
                                ChangesTokenRequest(
                                    recordTypes,
                                    setOf()
                                )
                            )
                        )
                    } catch (e: Throwable) {
                        result.error("GET_CHANGES_TOKEN_FAIL", e.localizedMessage, e)
                    }
                }
            }
            "getRecord" -> {
                scope.launch {
                    val type = call.argument<String>("type") ?: ""
                    val startTime = call.argument<String>("startTime")
                    val endTime = call.argument<String>("endTime")
                    try {
                        val start =
                            startTime?.let { LocalDateTime.parse(it) } ?: LocalDateTime.now()
                                .minus(1, ChronoUnit.DAYS)
                        val end = endTime?.let { LocalDateTime.parse(it) } ?: LocalDateTime.now()
                        HealthConnectRecordTypeMap[type]?.let { classType ->
                            // TODO handle pagination token ???
                            val reply = client.readRecords(
                                ReadRecordsRequest(
                                    recordType = classType,
                                    timeRangeFilter = TimeRangeFilter.between(start, end),
                                    pageSize = MAX_LENGTH,
                                )
                            )
                            result.success(reply.records.mapIndexed { index, record ->
                                replyMapper.convertValue(
                                    record,
                                    hashMapOf<String, Any>()::class.java
                                )
                            })
                        } ?: throw Throwable("Unsupported type $type")
                    } catch (e: Throwable) {
                        result.error("GET_RECORD_FAIL", e.localizedMessage, e)
                    }
                }
            }
            "openHealthConnectSettings" -> {
                val intent = Intent()
                intent.action = "androidx.health.ACTION_HEALTH_CONNECT_SETTINGS"
                activityContext.startActivity(intent)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == HEALTH_CONNECT_RESULT_CODE) {
            val result = permissionResult
            permissionResult = null
            if (resultCode == Activity.RESULT_OK) {
                if (data != null && result != null) {
                    scope.launch {
                        result.success(true)
                    }
                    return true
                }
            }
            scope.launch {
                result?.success(false)
            }
        }
        return false
    }
}
