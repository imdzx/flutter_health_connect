package dev.duynp.flutter_health_connect

import android.content.Context
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodChannel
import java.time.LocalDate
import java.time.ZoneId

class PermissionsCallHandler(
    private val context: Context,
    private val manager: PermissionsManager
) {

    fun isApiSupported(result: MethodChannel.Result) {
        val availabilityStatus = manager.isApiSupported()
        result.success(availabilityStatus)
    }

    fun checkAvailability(result: MethodChannel.Result) {
        val availabilityStatus = manager.checkAvailability()
        result.success(availabilityStatus)
    }

    fun installHealthConnect(result: MethodChannel.Result) {
        manager.installHealthConnect()
    }

    suspend fun hasAllPermissions(result: MethodChannel.Result, types: List<String>?) = suspend(result) {
        val hasPermissions = manager.hasAllPermissions(types)
        result.success(hasPermissions)
    }

    fun requestAllPermissions(result: MethodChannel.Result, types: List<String>?) = execute(result) {
        val success = manager.requestAllPermissions(types)
        result.success(success)
    }

    fun openHealthConnectSettings(result: MethodChannel.Result) {
        val status = manager.openHealthConnectSettings()
        result.success(status)
    }

    suspend fun getRecord(result: MethodChannel.Result, type: String, startDate: String, endDate: String) = suspend(result) {
        val start = LocalDate.parse(startDate).atStartOfDay(ZoneId.systemDefault())
        val end = LocalDate.parse(endDate).atStartOfDay(ZoneId.systemDefault())
        val healthData = manager.getRecord(type, start, end)
        result.success(healthData)
    }

    suspend fun suspend(result: MethodChannel.Result, block: suspend () -> Unit) {
        try {
            block()
        } catch (e: Exception) {
            println("$e")
        }
    }

    fun execute(result: MethodChannel.Result, block: () -> Unit) {
        try {
            block()
        } catch (e: Exception) {
            println("$e")
        }
    }

}