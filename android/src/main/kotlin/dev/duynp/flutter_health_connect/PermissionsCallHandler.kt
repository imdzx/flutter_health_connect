package dev.duynp.flutter_health_connect

import android.content.Context
import androidx.health.connect.client.permission.HealthPermission
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

    suspend fun hasAllPermissions(permissions: MutableSet<String>): Boolean {
        return manager.hasAllPermissions(permissions)
    }

    fun requestAllPermissions(types: List<String>?, readOnly: Boolean) {
        manager.requestAllPermissions(types, readOnly)
    }

    fun openHealthConnectSettings(result: MethodChannel.Result) {
        val status = manager.openHealthConnectSettings()
        result.success(status)
    }

    suspend fun getRecord( type: String, startDate: String, endDate: String): Any {
        val start = LocalDate.parse(startDate).atStartOfDay(ZoneId.systemDefault())
        val end = LocalDate.parse(endDate).atStartOfDay(ZoneId.systemDefault())
        return manager.getRecord(type, start, end)

    }




}