package dev.duynp.flutter_health_connect

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.PermissionController
import androidx.health.connect.client.impl.converters.records.toProto
import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.*
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.time.TimeRangeFilter
import androidx.health.platform.client.proto.Empty
import java.time.ZonedDateTime
import java.time.temporal.ChronoUnit

class PermissionsManager(
    private val context: Context,
    private val activity: Activity?,
) {

    private val client by lazy { HealthConnectClient.getOrCreate(context) }

    fun isApiSupported(): Boolean {
        return HealthConnectClient.isApiSupported()
    }

    fun checkAvailability(): Boolean {
        return HealthConnectClient.isProviderAvailable(context)
    }

    fun installHealthConnect() {
        val intent = Intent(Intent.ACTION_VIEW).apply {
            data = Uri.parse(playStoreUri)
            setPackage("com.android.vending")
        }
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

        runCatching { context.startActivity(intent) }
    }


    fun openHealthConnectSettings(): Boolean {
        if (activity == null) {
            return false
        }

        activity.run {
            val intent = Intent()
            intent.action = "androidx.health.ACTION_HEALTH_CONNECT_SETTINGS"
            startActivity(intent)
        }

        return true
    }

    fun requestAllPermissions(types: List<String>?, readOnly: Boolean) {
        val allPermissions =
            emptySet<HealthPermission>().plus(FuncHelper.mapToHealthPermissions(types, readOnly))
        val contract = PermissionController.createRequestPermissionResultContract()
        val intent = contract.createIntent(activity!!, allPermissions)
        activity.startActivityForResult(intent, HEALTH_CONNECT_RESULT_CODE)
    }

    suspend fun hasAllPermissions(permissions: MutableSet<HealthPermission>): Boolean {
        val granted = client.permissionController.getGrantedPermissions(permissions)
        return granted.containsAll(permissions)
    }

    suspend fun getRecord(type: String, startDate: ZonedDateTime, endDate: ZonedDateTime): Any {

        val startTime =
            startDate.truncatedTo(ChronoUnit.DAYS).withZoneSameInstant(DateTimeHelper.utc)
                .toInstant()
        val endTime =
            endDate.truncatedTo(ChronoUnit.DAYS).withZoneSameInstant(DateTimeHelper.utc).toInstant()
        return getHealthData(type, TimeRangeFilter.between(startTime, endTime))
    }

    private suspend fun getHealthData(type: String, timeRangeFilter: TimeRangeFilter): Any {
        when (type) {
            ActiveCaloriesBurned -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = ActiveCaloriesBurnedRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "energy" to dataPoint.energy.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            BasalBodyTemperature -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = BasalBodyTemperatureRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "temperature" to dataPoint.temperature.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            BasalMetabolicRate -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = BasalMetabolicRateRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "basalMetabolicRate" to dataPoint.basalMetabolicRate.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            BloodGlucose -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = BloodGlucoseRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "level" to dataPoint.level.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            BloodPressure -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = BloodPressureRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "systolic" to dataPoint.systolic.toString(),
                        "diastolic" to dataPoint.diastolic.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            BodyFat -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = BodyFatRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "percentage" to dataPoint.percentage.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            BodyTemperature -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = BodyTemperatureRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "temperature" to dataPoint.temperature.toString(),
                        "measurementLocation" to dataPoint.measurementLocation.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            BoneMass -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = BoneMassRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "mass" to dataPoint.mass.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            CervicalMucus -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = CervicalMucusRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "appearance" to dataPoint.appearance.toString(),
                        "sensation" to dataPoint.sensation.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            CyclingPedalingCadence -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = CyclingPedalingCadenceRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "samples" to dataPoint.samples.mapIndexed { _, sample ->
                            hashMapOf(
                                "time" to sample.time.toString(),
                                "revolutionsPerMinute" to sample.revolutionsPerMinute.toString(),
                            )
                        },
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            Distance -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = DistanceRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "distance" to dataPoint.distance.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            ElevationGained -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = ElevationGainedRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "elevation" to dataPoint.elevation.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            ExerciseEvent -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = ExerciseEventRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "eventType" to dataPoint.eventType.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            ExerciseLap -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = ExerciseLapRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "length" to dataPoint.length.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            ExerciseRepetitions -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = ExerciseRepetitionsRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "count" to dataPoint.count.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            ExerciseSession -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = ExerciseSessionRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "exerciseType" to dataPoint.exerciseType.toString(),
                        "title" to dataPoint.title.toString(),
                        "notes" to dataPoint.notes.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            FloorsClimbed -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = FloorsClimbedRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "floors" to dataPoint.floors.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            HeartRate -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = HeartRateRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "samples" to dataPoint.samples.mapIndexed { _, sample ->
                            hashMapOf(
                                "time" to sample.time.toString(),
                                "beatsPerMinute" to sample.beatsPerMinute.toString(),
                            )
                        },
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            Height -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = HeightRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "height" to dataPoint.height.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            HipCircumference -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = HipCircumferenceRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "circumference" to dataPoint.circumference.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            Hydration -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = HydrationRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "volume" to dataPoint.volume.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            LeanBodyMass -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = LeanBodyMassRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "mass" to dataPoint.mass.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            MenstruationFlow -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = MenstruationFlowRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "flow" to dataPoint.flow.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            Nutrition -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = NutritionRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "biotin" to dataPoint.biotin.toString(),
                        "caffeine" to dataPoint.caffeine.toString(),
                        "calcium" to dataPoint.calcium.toString(),
                        "energy" to dataPoint.energy.toString(),
                        "energyFromFat" to dataPoint.energyFromFat.toString(),
                        "chloride" to dataPoint.chloride.toString(),
                        "cholesterol" to dataPoint.cholesterol.toString(),
                        "chromium" to dataPoint.chromium.toString(),
                        "copper" to dataPoint.copper.toString(),
                        "dietaryFiber" to dataPoint.dietaryFiber.toString(),
                        "folate" to dataPoint.folate.toString(),
                        "folicAcid" to dataPoint.folicAcid.toString(),
                        "iodine" to dataPoint.iodine.toString(),
                        "iron" to dataPoint.iron.toString(),
                        "magnesium" to dataPoint.magnesium.toString(),
                        "manganese" to dataPoint.manganese.toString(),
                        "molybdenum" to dataPoint.molybdenum.toString(),
                        "monounsaturatedFat" to dataPoint.monounsaturatedFat.toString(),
                        "niacin" to dataPoint.niacin.toString(),
                        "pantothenicAcid" to dataPoint.pantothenicAcid.toString(),
                        "phosphorus" to dataPoint.phosphorus.toString(),
                        "polyunsaturatedFat" to dataPoint.polyunsaturatedFat.toString(),
                        "potassium" to dataPoint.potassium.toString(),
                        "protein" to dataPoint.protein.toString(),
                        "riboflavin" to dataPoint.riboflavin.toString(),
                        "saturatedFat" to dataPoint.saturatedFat.toString(),
                        "selenium" to dataPoint.selenium.toString(),
                        "sodium" to dataPoint.sodium.toString(),
                        "sugar" to dataPoint.sugar.toString(),
                        "thiamin" to dataPoint.thiamin.toString(),
                        "totalCarbohydrate" to dataPoint.totalCarbohydrate.toString(),
                        "totalFat" to dataPoint.totalFat.toString(),
                        "transFat" to dataPoint.transFat.toString(),
                        "unsaturatedFat" to dataPoint.unsaturatedFat.toString(),
                        "vitaminA" to dataPoint.vitaminA.toString(),
                        "vitaminB12" to dataPoint.vitaminB12.toString(),
                        "vitaminB6" to dataPoint.vitaminB6.toString(),
                        "vitaminC" to dataPoint.vitaminC.toString(),
                        "vitaminD" to dataPoint.vitaminD.toString(),
                        "vitaminE" to dataPoint.vitaminE.toString(),
                        "vitaminK" to dataPoint.vitaminK.toString(),
                        "zinc" to dataPoint.zinc.toString(),
                        "name" to dataPoint.name.toString(),
                        "mealType" to dataPoint.mealType.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            OvulationTest -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = OvulationTestRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "result" to dataPoint.result.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            OxygenSaturation -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = OxygenSaturationRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "percentage" to dataPoint.percentage.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            Power -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = PowerRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "samples" to dataPoint.samples.mapIndexed { _, sample ->
                            hashMapOf(
                                "time" to sample.time.toString(),
                                "power" to sample.power.toString(),
                            )
                        },
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            RespiratoryRate -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = RespiratoryRateRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "rate" to dataPoint.rate.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            RestingHeartRate -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = RestingHeartRateRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "beatsPerMinute" to dataPoint.beatsPerMinute.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            SexualActivity -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = SexualActivityRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "protectionUsed" to dataPoint.protectionUsed.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            SleepSession -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = SleepSessionRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "title" to dataPoint.title.toString(),
                        "notes" to dataPoint.notes.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        ),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            SleepStage -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = SleepStageRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "stage" to dataPoint.stage.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            Speed -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = SpeedRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "samples" to dataPoint.samples.mapIndexed { _, sample ->
                            hashMapOf(
                                "time" to sample.time.toString(),
                                "speed" to sample.speed.toString(),
                            )
                        },
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            StepsCadence -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = StepsCadenceRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "samples" to dataPoint.samples.mapIndexed { _, sample ->
                            hashMapOf(
                                "time" to sample.time.toString(),
                                "rate" to sample.rate.toString(),
                            )
                        },
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            Steps -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = StepsRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "count" to dataPoint.count.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            SwimmingStrokes -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = SwimmingStrokesRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "type" to dataPoint.type.toString(),
                        "count" to dataPoint.count.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            TotalCaloriesBurned -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = TotalCaloriesBurnedRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "energy" to dataPoint.energy.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            Vo2Max -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = Vo2MaxRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "vo2MillilitersPerMinuteKilogram" to dataPoint.vo2MillilitersPerMinuteKilogram.toString(),
                        "measurementMethod" to dataPoint.measurementMethod.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            WaistCircumference -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = WaistCircumferenceRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "circumference" to dataPoint.circumference.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            Weight -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = WeightRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "time" to dataPoint.time.toString(),
                        "zoneOffset" to dataPoint.zoneOffset?.toString(),
                        "weight" to dataPoint.weight.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
            WheelchairPushes -> {
                val records = client.readRecords(
                    ReadRecordsRequest(
                        recordType = WheelchairPushesRecord::class,
                        timeRangeFilter = timeRangeFilter
                    )
                ).records
                val healthData = records.mapIndexed { _, dataPoint ->
                    return@mapIndexed hashMapOf(
                        "startZoneOffset" to dataPoint.startZoneOffset?.toString(),
                        "endZoneOffset" to dataPoint.endZoneOffset?.toString(),
                        "startTime" to dataPoint.startTime.toString(),
                        "endTime" to dataPoint.endTime.toString(),
                        "count" to dataPoint.count.toString(),
                        "metaData" to hashMapOf(
                            "id" to dataPoint.metadata.id,
                            "dataOrigin" to dataPoint.metadata.dataOrigin.packageName,
                            "lastModifiedTime" to dataPoint.metadata.lastModifiedTime.toString(),
                            "clientRecordId" to dataPoint.metadata.clientRecordId,
                            "clientRecordVersion" to dataPoint.metadata.clientRecordVersion.toString(),
                            "deviceManufacturer" to dataPoint.metadata.device?.manufacturer,
                            "deviceModel" to dataPoint.metadata.device?.model,
                        )
                    )
                }
                return healthData
            }
        }

        //Default
        val records = client.readRecords(
            ReadRecordsRequest(
                recordType = StepsRecord::class,
                timeRangeFilter = timeRangeFilter
            )
        ).records
        val healthData = records.mapIndexed { _, dataPoint ->
            return@mapIndexed hashMapOf(
                "count" to dataPoint.count.toString(),
            )
        }
        return healthData
    }

//    private suspend fun insertHealthData(type: String, timeRangeFilter: TimeRangeFilter): Any {}

}