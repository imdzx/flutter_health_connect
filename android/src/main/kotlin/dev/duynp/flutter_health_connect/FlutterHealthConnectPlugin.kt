package dev.duynp.flutter_health_connect

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

  override fun onMethodCall(call: MethodCall, result: Result) {
//    activity //Do something
//    applicationContext //Do something
    val permissionsManager = PermissionsManager(applicationContext!!, activity)
    val permissionsCallHandler =
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
          val types = (args["types"] as? ArrayList<*>)?.filterIsInstance<String>()
          val readOnly = call.argument<Boolean>("readOnly")!!
          permissionsCallHandler.hasAllPermissions(result, types, readOnly)
        }
      }
      "requestPermissions" -> {
        val args = call.arguments as HashMap<*, *>
        val types = (args["types"] as? ArrayList<*>)?.filterIsInstance<String>()
        val readOnly = call.argument<Boolean>("readOnly")!!
        permissionsCallHandler.requestAllPermissions(result, types, readOnly)
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

}
