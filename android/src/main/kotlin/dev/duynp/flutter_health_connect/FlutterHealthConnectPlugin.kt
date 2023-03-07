package dev.duynp.flutter_health_connect

import android.app.Activity
import android.content.Intent
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.PermissionController

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.*
import java.time.LocalDate
import java.time.ZoneId
import java.time.ZonedDateTime
import java.time.temporal.ChronoUnit
import java.util.ArrayList
import java.util.HashMap

/** FlutterHealthConnectPlugin */
class FlutterHealthConnectPlugin : ContextAwarePlugin() {
    override val pluginName: String = "flutter_health_connect"
    private lateinit var permissionsCallHandler: PermissionsCallHandler
    private var currentTypes: List<String>? = null
    private var readOnly: Boolean = false
    private var permissionResult: Result? = null

    override fun onMethodCall(call: MethodCall, result: Result) {
//    activity //Do something
//    applicationContext //Do something
        val permissionsManager = PermissionsManager(applicationContext!!, act)
        permissionsCallHandler =
                PermissionsCallHandler(applicationContext!!, permissionsManager)
        PermissionController.createRequestPermissionResultContract()
        when (call.method) {
            "isApiSupported" -> {
                permissionsCallHandler.isApiSupported(result)
            }

            "isAvailable" -> {
                permissionsCallHandler.checkAvailability(result)
            }

            "installHealthConnect" -> {
                permissionsCallHandler.installHealthConnect(result)
            }

            "hasPermissions" -> {
                scope.launch {
                    val args = call.arguments as HashMap<*, *>
                    currentTypes = (args["types"] as? ArrayList<*>)?.filterIsInstance<String>()
                    readOnly = call.argument<Boolean>("readOnly") ?: false
                    val permissions = FuncHelper.mapToHealthPermissions(currentTypes, readOnly)
                    val status = permissionsCallHandler.hasAllPermissions(permissions)
                    result.success(status)
                }
            }

            "requestPermissions" -> {
                permissionResult = result
                val args = call.arguments as HashMap<*, *>
                currentTypes = (args["types"] as? ArrayList<*>)?.filterIsInstance<String>()
                readOnly = call.argument<Boolean>("readOnly") ?: false
                permissionsCallHandler.requestAllPermissions(currentTypes, readOnly)
            }

            "getRecord" -> {
                scope.launch {
                    val type = call.argument<String>("type")!!
                    val startTime = call.argument<String>("startTime")!!
                    val endTime = call.argument<String>("endTime")!!
                    result.success(permissionsCallHandler.getRecord(type, startTime, endTime))
                }
            }

            "openHealthConnectSettings" -> {
                permissionsCallHandler.openHealthConnectSettings(result)
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
                        //Verify granted permission
                        val permissions = FuncHelper.mapToHealthPermissions(currentTypes, readOnly)
                        val status = permissionsCallHandler.hasAllPermissions(permissions)
                        result.success(status)
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
