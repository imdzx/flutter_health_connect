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
    private lateinit var result: Result

    override fun onMethodCall(call: MethodCall, result: Result) {
//    activity //Do something
//    applicationContext //Do something
        this.result = result
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
                    readOnly = call.argument<Boolean>("readOnly")!!
                    val permissions = FuncHelper.mapToHealthPermissions(currentTypes, readOnly)
                    val status = permissionsCallHandler.hasAllPermissions(result, permissions)
                    result.success(status)
                }
            }

            "requestPermissions" -> {
                val args = call.arguments as HashMap<*, *>
                currentTypes = (args["types"] as? ArrayList<*>)?.filterIsInstance<String>()
                readOnly = call.argument<Boolean>("readOnly")!!
                permissionsCallHandler.requestAllPermissions(result, currentTypes, readOnly)
            }

            "getRecord" -> {
                scope.launch {
                    val type = call.argument<String>("type")!!
                    val startTime = call.argument<String>("startTime")!!
                    val endTime = call.argument<String>("endTime")!!
                    permissionsCallHandler.getRecord(result, type, startTime, endTime)
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
            if (resultCode == Activity.RESULT_OK) {
                if (data != null) {
                    scope.launch {
                        //Verify granted permission
                        val permissions = FuncHelper.mapToHealthPermissions(currentTypes, readOnly)
                        val status = permissionsCallHandler.hasAllPermissions(result, permissions)
                        result.success(status)
                    }
                    return true
                }
            }
        }
        return false
    }

}
