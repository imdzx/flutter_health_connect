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

    private var ActiveCaloriesBurned = "ActiveCaloriesBurned"
    private var BasalBodyTemperature = "BasalBodyTemperature"
    private var BasalMetabolicRate = "BasalMetabolicRate"
    private var BloodGlucose = "BloodGlucose"
    private var BloodPressure = "BloodPressure"
    private var BodyFat = "BodyFat"
    private var BodyTemperature = "BodyTemperature"
    private var BoneMass = "BoneMass"
    private var CervicalMucus = "CervicalMucus"
    private var CyclingPedalingCadence = "CyclingPedalingCadence"
    private var Distance = "Distance"
    private var ElevationGained = "ElevationGained"
    private var ExerciseEvent = "ExerciseEvent"
    private var ExerciseLap = "ExerciseLap"
    private var ExerciseRepetitions = "ExerciseRepetitions"
    private var ExerciseSession = "ExerciseSession"
    private var FloorsClimbed = "FloorsClimbed"
    private var HeartRate = "HeartRate"
    private var Height = "Height"
    private var HipCircumference = "HipCircumference"
    private var Hydration = "Hydration"
    private var LeanBodyMass = "LeanBodyMass"
    private var MenstruationFlow = "MenstruationFlow"
    private var Nutrition = "Nutrition"
    private var OvulationTest = "OvulationTest"
    private var OxygenSaturation = "OxygenSaturation"
    private var Power = "Power"
    private var RespiratoryRate = "RespiratoryRate"
    private var RestingHeartRate = "RestingHeartRate"
    private var SexualActivity = "SexualActivity"
    private var SleepSession = "SleepSession"
    private var SleepStage = "SleepStage"
    private var Speed = "Speed"
    private var StepsCadence = "StepsCadence"
    private var Steps = "Steps"
    private var SwimmingStrokes = "SwimmingStrokes"
    private var TotalCaloriesBurned = "TotalCaloriesBurned"
    private var Vo2Max = "Vo2Max"
    private var WaistCircumference = "WaistCircumference"
    private var Weight = "Weight"
    private var WheelchairPushes = "WheelchairPushes"
    private val playStoreUri =
        "https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata"
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

    private fun launchPermissionsIntent(activity: Activity, permissions: Set<HealthPermission>) {
        val contract = PermissionController.createRequestPermissionResultContract()
        val intent = contract.createIntent(activity, permissions)

        activity.startActivityForResult(intent, 0)
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

    fun requestAllPermissions(types: List<String>?, readOnly: Boolean): Boolean {
        val allPermissions = emptySet<HealthPermission>().plus(mapToHealthPermissions(types, readOnly))
        return if (activity == null) {
            false
        } else {
            launchPermissionsIntent(activity, allPermissions)
            true
        }
    }

    suspend fun hasAllPermissions(types: List<String>?, readOnly: Boolean): Boolean {
        val permissions = mapToHealthPermissions(types, readOnly)
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

    private fun mapToHealthPermissions(types: List<String>?, readOnly: Boolean): MutableSet<HealthPermission> {
        val permissions = mutableSetOf<HealthPermission>()
        if (types != null) {
            for (item: String in types) {
                when (item) {
                    ActiveCaloriesBurned -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    ActiveCaloriesBurnedRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.createReadPermission(
                                ActiveCaloriesBurnedRecord::class
                            )
                        )
                    }
                    BasalBodyTemperature -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    BasalBodyTemperatureRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.createReadPermission(
                                BasalBodyTemperatureRecord::class
                            )
                        )
                    }
                    BasalMetabolicRate -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    BasalMetabolicRateRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.createReadPermission(
                                BasalMetabolicRateRecord::class
                            )
                        )
                    }
                    BloodGlucose -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(BloodGlucoseRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(BloodGlucoseRecord::class))
                    }
                    BloodPressure -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(BloodPressureRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(BloodPressureRecord::class))
                    }
                    BodyFat -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(BodyFatRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(BodyFatRecord::class))
                    }
                    BodyTemperature -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(BodyTemperatureRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(BodyTemperatureRecord::class))
                    }
                    BoneMass -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(BoneMassRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(BoneMassRecord::class))
                    }
                    CervicalMucus -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(CervicalMucusRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(CervicalMucusRecord::class))
                    }
                    CyclingPedalingCadence -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    CyclingPedalingCadenceRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.createReadPermission(
                                CyclingPedalingCadenceRecord::class
                            )
                        )
                    }
                    Distance -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(DistanceRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(DistanceRecord::class))
                    }
                    ElevationGained -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(ElevationGainedRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(ElevationGainedRecord::class))
                    }
                    ExerciseEvent -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(ExerciseEventRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(ExerciseEventRecord::class))
                    }
                    ExerciseLap -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(ExerciseLapRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(ExerciseLapRecord::class))
                    }
                    ExerciseRepetitions -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    ExerciseRepetitionsRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.createReadPermission(
                                ExerciseRepetitionsRecord::class
                            )
                        )
                    }
                    ExerciseSession -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(ExerciseSessionRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(ExerciseSessionRecord::class))
                    }
                    FloorsClimbed -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(FloorsClimbedRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(FloorsClimbedRecord::class))
                    }
                    HeartRate -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(HeartRateRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(HeartRateRecord::class))
                    }
                    Height -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(HeightRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(HeightRecord::class))
                    }
                    HipCircumference -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    HipCircumferenceRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.createReadPermission(HipCircumferenceRecord::class))
                    }
                    Hydration -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(HydrationRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(HydrationRecord::class))
                    }
                    LeanBodyMass -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(LeanBodyMassRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(LeanBodyMassRecord::class))
                    }
                    MenstruationFlow -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    MenstruationFlowRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.createReadPermission(MenstruationFlowRecord::class))
                    }
                    Nutrition -> {
                        if (!readOnly) {

                        }
                        permissions.add(HealthPermission.createWritePermission(NutritionRecord::class))
                        permissions.add(HealthPermission.createReadPermission(NutritionRecord::class))
                    }
                    OvulationTest -> {
                        if (!readOnly) {

                        }
                        permissions.add(HealthPermission.createWritePermission(OvulationTestRecord::class))
                        permissions.add(HealthPermission.createReadPermission(OvulationTestRecord::class))
                    }
                    OxygenSaturation -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    OxygenSaturationRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.createReadPermission(OxygenSaturationRecord::class))
                    }
                    Power -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(PowerRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(PowerRecord::class))
                    }
                    RespiratoryRate -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(RespiratoryRateRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(RespiratoryRateRecord::class))
                    }
                    RestingHeartRate -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    RestingHeartRateRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.createReadPermission(RestingHeartRateRecord::class))
                    }
                    SexualActivity -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(SexualActivityRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(SexualActivityRecord::class))
                    }
                    SleepSession -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(SleepSessionRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(SleepSessionRecord::class))
                    }
                    SleepStage -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(SleepStageRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(SleepStageRecord::class))
                    }
                    Speed -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(SpeedRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(SpeedRecord::class))
                    }
                    StepsCadence -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(StepsCadenceRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(StepsCadenceRecord::class))
                    }
                    Steps -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(StepsRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(StepsRecord::class))
                    }
                    SwimmingStrokes -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(SwimmingStrokesRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(SwimmingStrokesRecord::class))
                    }
                    TotalCaloriesBurned -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    TotalCaloriesBurnedRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.createReadPermission(
                                TotalCaloriesBurnedRecord::class
                            )
                        )
                    }
                    Vo2Max -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(Vo2MaxRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(Vo2MaxRecord::class))
                    }
                    WaistCircumference -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    WaistCircumferenceRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.createReadPermission(
                                WaistCircumferenceRecord::class
                            )
                        )
                    }
                    Weight -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.createWritePermission(WeightRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(WeightRecord::class))
                    }
                    WheelchairPushes -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    WheelchairPushesRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.createReadPermission(WheelchairPushesRecord::class))
                    }
                }
            }
        }
        return permissions
    }

}