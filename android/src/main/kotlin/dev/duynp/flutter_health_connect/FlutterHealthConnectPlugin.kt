package dev.duynp.flutter_health_connect

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.PermissionController.Companion.createRequestPermissionResultContract
import androidx.health.connect.client.changes.UpsertionChange
import androidx.health.connect.client.request.ChangesTokenRequest
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.records.*
import androidx.health.connect.client.units.*
import androidx.health.connect.client.records.metadata.DataOrigin
import androidx.health.connect.client.records.metadata.Device
import androidx.health.connect.client.records.metadata.Metadata
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.time.TimeRangeFilter
import androidx.health.connect.client.units.Energy
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializationFeature
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule
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

/** FlutterHealthConnectPlugin */
class FlutterHealthConnectPlugin(private var channel: MethodChannel? = null) : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    private var replyMapper: ObjectMapper = ObjectMapper()
    private var permissionResult: Result? = null
    private lateinit var client: HealthConnectClient
    private var activity: Activity? = null
    private var context: Context? = null
    private lateinit var scope: CoroutineScope

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        scope = CoroutineScope(SupervisorJob() + Dispatchers.Main)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_health_connect")
        channel?.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        client = HealthConnectClient.getOrCreate(context!!)
        replyMapper.registerModule(JavaTimeModule())
        replyMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        scope.cancel()
        channel = null
        activity = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        if (channel == null) {
            return
        }
        binding.addActivityResultListener(this)
        activity = binding.activity
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onDetachedFromActivity() {
        if (channel == null) {
            return
        }
        activity = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val args = call.arguments?.let { it as? HashMap<*, *> } ?: hashMapOf<String, Any>()
        val requestedTypes = (args["types"] as? ArrayList<*>)?.filterIsInstance<String>()
        when (call.method) {

            "isApiSupported" -> result.success(context?.let { HealthConnectClient.getSdkStatus(it) } != HealthConnectClient.SDK_UNAVAILABLE)

            "isAvailable" -> result.success(context?.let { HealthConnectClient.getSdkStatus(it) } == HealthConnectClient.SDK_AVAILABLE)

            "installHealthConnect" -> {
                try {
                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata&url=healthconnect%3A%2F%2Fonboarding"))
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    intent.addFlags(Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED)
                    context?.startActivity(intent)
                    result.success(true)
                } catch (e: Throwable) {
                    result.error("UNABLE_TO_START_ACTIVITY", e.message, e)
                }
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
                try {
                    permissionResult = result
                    val isReadOnly = call.argument<Boolean>("readOnly") ?: false
                    val allPermissions = mapTypesToPermissions(
                        requestedTypes,
                        isReadOnly
                    )
                    val contract = createRequestPermissionResultContract()
                    val intent = context?.let { contract.createIntent(it, allPermissions) }
                    activity!!.startActivityForResult(intent, HEALTH_CONNECT_RESULT_CODE)
                } catch (e: Throwable) {
                    result.error("UNABLE_TO_START_ACTIVITY", e.message, e)
                }
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
                            when (change) {
                                is UpsertionChange -> hashMapOf(
                                    change::class.simpleName to
                                            hashMapOf(
                                                change.record::class.simpleName to
                                                        replyMapper.convertValue(
                                                            change.record,
                                                            hashMapOf<String, Any>()::class.java
                                                        )
                                            )
                                )
                                else -> hashMapOf(
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
                    val pageSize = call.argument<Int>("pageSize") ?: MAX_LENGTH
                    val pageToken = call.argument<String?>("pageToken")
                    val ascendingOrder = call.argument<Boolean?>("ascendingOrder") ?: true
                    try {
                        val start =
                            startTime?.let { LocalDateTime.parse(it) } ?: LocalDateTime.now()
                                .minus(1, ChronoUnit.DAYS)
                        val end = endTime?.let { LocalDateTime.parse(it) } ?: LocalDateTime.now()
                        HealthConnectRecordTypeMap[type]?.let { classType ->
                            val reply = client.readRecords(
                                ReadRecordsRequest(
                                    recordType = classType,
                                    timeRangeFilter = TimeRangeFilter.between(start, end),
                                    pageSize = pageSize,
                                    pageToken = pageToken,
                                    ascendingOrder = ascendingOrder,
                                )
                            )
                            result.success(
                                replyMapper.convertValue(
                                    reply,
                                    hashMapOf<String, Any>()::class.java
                                )
                            )
                        } ?: throw Throwable("Unsupported type $type")
                    } catch (e: Throwable) {
                        result.error("GET_RECORD_FAIL", e.localizedMessage, e)
                    }
                }
            }

            "getRecords" -> {
                scope.launch {
                    val type = call.argument<String>("type") ?: ""
                    val startTime = call.argument<String>("startTime")
                    val endTime = call.argument<String>("endTime")
                    val pageSize = call.argument<Int>("pageSize") ?: MAX_LENGTH
                    val pageToken = call.argument<String?>("pageToken")
                    val ascendingOrder = call.argument<Boolean?>("ascendingOrder") ?: true
                    val records = mutableListOf<Map<String, Any?>>()
                    try {
                        val start =
                            startTime?.let { Instant.parse(it) } ?: Instant.now()
                                .minus(1, ChronoUnit.DAYS)
                        val end = endTime?.let { Instant.parse(it) } ?: Instant.now()
                        HealthConnectRecordTypeMap[type]?.let { classType ->
                            val reply = client.readRecords(
                                ReadRecordsRequest(
                                    recordType = classType,
                                    timeRangeFilter = TimeRangeFilter.between(start, end),
                                    pageSize = pageSize,
                                    pageToken = pageToken,
                                    ascendingOrder = ascendingOrder,
                                )
                            )
                            reply.records.forEach {
                                records.add(
                                    replyMapper.convertValue(
                                        it,
                                        hashMapOf<String, Any?>()::class.java
                                    )
                                )
                            }
                            result.success(records)
                        } ?: throw Throwable("Unsupported type $type")
                    } catch (e: Throwable) {
                        result.error("GET_RECORDS_FAIL", e.localizedMessage, e)
                    }
                }
            }

            "writeData" -> writeData(call, result)

            "openHealthConnectSettings" -> {
                try {
                    val intent = Intent()
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    intent.action = HealthConnectClient.ACTION_HEALTH_CONNECT_SETTINGS
                    context?.startActivity(intent)
                    result.success(true)
                } catch (e: Throwable) {
                    result.error("UNABLE_TO_START_ACTIVITY", e.message, e)
                }
            }

            "deleteRecordsByTime" -> {
                scope.launch {
                    val type = call.argument<String>("type") ?: ""
                    val startTime = call.argument<String>("startTime")
                    val endTime = call.argument<String>("endTime")
                    try {
                        HealthConnectRecordTypeMap[type]?.let { classType ->
                            val start =
                                startTime?.let { Instant.parse(it) } ?: Instant.now()
                                    .minus(1, ChronoUnit.DAYS)
                            val end = endTime?.let { Instant.parse(it) } ?: Instant.now()
                            val reply = client.deleteRecords(
                                recordType = classType,
                                timeRangeFilter = TimeRangeFilter.between(start, end),
                            )
                            result.success(reply)
                        } ?: throw Throwable("Unsupported type $type")
                    } catch (e: Throwable) {
                        result.error("DELETE_RECORDS_FAIL", e.localizedMessage, e)
                    }
                }
            }

            "deleteRecordsByIds" -> {
                scope.launch {
                    val type = call.argument<String>("type") ?: ""
                    val idList = call.argument<List<String>>("idList") ?: emptyList()
                    val clientRecordIdsList = call.argument<List<String>>("clientRecordIdsList") ?: emptyList()
                    try {
                        HealthConnectRecordTypeMap[type]?.let { classType ->
                            val reply = client.deleteRecords(classType, idList, clientRecordIdsList)
                            result.success(reply)
                        } ?: throw Throwable("Unsupported type $type")
                    } catch (e: Throwable) {
                        result.error("DELETE_RECORDS_FAIL", e.localizedMessage, e)
                    }
                }
            }

            "aggregate" -> aggregate(call, result)

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

    private fun writeData(call: MethodCall, result: Result) {
            val type = call.argument<String>("type") ?: ""
            val data: List<Map<String, Any>> =
                call.argument<List<Map<String, Any>>>("data") ?: emptyList()
            if (data.isNotEmpty()) {
                val recordsList: MutableList<Record> = emptyList<Record>().toMutableList()
                for (recordMap in data) {
                    val metadataMap = recordMap["metadata"] as Map<*, *>?
                    val metadata = if (metadataMap != null) {
                        val dataOriginMap = metadataMap["dataOrigin"] as Map<*, *>?
                        val dataOrigin = if (dataOriginMap != null) DataOrigin(
                            packageName = dataOriginMap["packageName"] as String
                        ) else DataOrigin(packageName = "")
                        val deviceMap = metadataMap["device"] as Map<*, *>?
                        val device = if (deviceMap != null) Device(
                            manufacturer = deviceMap["manufacturer"] as String?,
                            model = deviceMap["model"] as String?,
                            type = deviceMap["type"] as Int
                        ) else null
                        Metadata(
                            id = metadataMap["id"] as String,
                            dataOrigin = dataOrigin,
                            lastModifiedTime = Instant.parse(metadataMap["lastModifiedTime"] as String),
                            clientRecordId = metadataMap["clientRecordId"] as String?,
                            clientRecordVersion = (metadataMap["clientRecordVersion"] as Int).toLong(),
                            device = device
                        )
                    } else Metadata()
                    val record = when (type) {
                        ACTIVE_CALORIES_BURNED -> ActiveCaloriesBurnedRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            energy = Energy.kilocalories(recordMap["energy"] as Double),
                            metadata = metadata,
                        )
                        BASAL_BODY_TEMPERATURE -> BasalBodyTemperatureRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            temperature = Temperature.celsius(recordMap["temperature"] as Double),
                            measurementLocation = recordMap["measurementLocation"] as Int,
                            metadata = metadata,
                        )
                        BASAL_METABOLIC_RATE -> BasalMetabolicRateRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            basalMetabolicRate = Power.kilocaloriesPerDay(recordMap["basalMetabolicRate"] as Double),
                            metadata = metadata,
                        )
                        BLOOD_GLUCOSE -> BloodGlucoseRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            level = BloodGlucose.millimolesPerLiter(recordMap["level"] as Double),
                            specimenSource = recordMap["specimenSource"] as Int,
                            mealType = recordMap["mealType"] as Int,
                            relationToMeal = recordMap["relationToMeal"] as Int,
                            metadata = metadata,
                        )
                        BLOOD_PRESSURE -> BloodPressureRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            systolic = Pressure.millimetersOfMercury(recordMap["systolicPressure"] as Double),
                            diastolic = Pressure.millimetersOfMercury(recordMap["diastolicPressure"] as Double),
                            bodyPosition = recordMap["bodyPosition"] as Int,
                            measurementLocation = recordMap["measurementLocation"] as Int,
                            metadata = metadata,
                        )
                        BODY_FAT -> BodyFatRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            percentage = Percentage(recordMap["percentage"] as Double),
                            metadata = metadata,
                        )
                        BODY_TEMPERATURE -> BodyTemperatureRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            temperature = Temperature.celsius(recordMap["temperature"] as Double),
                            metadata = metadata,
                        )
                        BODY_WATER_MASS -> BodyWaterMassRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            mass = Mass.kilograms(recordMap["mass"] as Double),
                            metadata = metadata,
                        )
                        BONE_MASS -> BoneMassRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            mass = Mass.kilograms(recordMap["mass"] as Double),
                            metadata = metadata,
                        )
                        CERVICAL_MUCUS -> CervicalMucusRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            appearance = recordMap["appearance"] as Int,
                            sensation = recordMap["sensation"] as Int,
                            metadata = metadata,
                        )
                        CYCLING_PEDALING_CADENCE -> CyclingPedalingCadenceRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            samples = (recordMap["samples"] as List<*>).filterIsInstance<CyclingPedalingCadenceRecord.Sample>(),
                            metadata = metadata,
                        )
                        DISTANCE -> DistanceRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            distance = Length.meters(recordMap["distance"] as Double),
                            metadata = metadata,
                        )
                        ELEVATION_GAINED -> ElevationGainedRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            elevation = Length.meters(recordMap["elevation"] as Double),
                            metadata = metadata,
                        )
                        EXERCISE_SESSION -> ExerciseSessionRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            exerciseType = recordMap["exerciseType"] as Int,
                            title = recordMap["title"] as String?,
                            notes = recordMap["notes"] as String?,
                            metadata = metadata,
                        )
                        FLOORS_CLIMBED -> FloorsClimbedRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            floors = recordMap["floors"] as Double,
                            metadata = metadata,
                        )
                        HEART_RATE -> HeartRateRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            samples = (recordMap["samples"] as List<*>).filterIsInstance<HeartRateRecord.Sample>(),
                            metadata = metadata,
                        )
                        HEART_RATE_VARIABILITY -> HeartRateVariabilityRmssdRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            heartRateVariabilityMillis = recordMap["heartRateVariabilityMillis"] as Double,
                            metadata = metadata,
                        )
                        HEIGHT -> HeightRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            height = Length.meters(recordMap["height"] as Double),
                            metadata = metadata,
                        )
                        HYDRATION -> HydrationRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            volume = Volume.liters(recordMap["volume"] as Double),
                            metadata = metadata,
                        )
                        INTERMENSTRUAL_BLEEDING -> IntermenstrualBleedingRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            metadata = metadata,
                        )
                        LEAN_BODY_MASS -> LeanBodyMassRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            mass = Mass.kilograms(recordMap["mass"] as Double),
                            metadata = metadata,
                        )
                        MENSTRUATION_FLOW -> MenstruationFlowRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            flow = recordMap["flow"] as Int,
                            metadata = metadata,
                        )
                        MENSTRUATION_PERIOD -> MenstruationPeriodRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            metadata = metadata,
                        )
                        NUTRITION -> NutritionRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            biotin = if (recordMap["biotin"] != null) Mass.grams(recordMap["biotin"] as Double) else null,
                            caffeine = if (recordMap["caffeine"] != null) Mass.grams(recordMap["caffeine"] as Double) else null,
                            calcium = if (recordMap["calcium"] != null) Mass.grams(recordMap["calcium"] as Double) else null,
                            energy = if (recordMap["energy"] != null) Energy.kilocalories(recordMap["energy"] as Double) else null,
                            energyFromFat = if (recordMap["energyFromFat"] != null) Energy.kilocalories(recordMap["energyFromFat"] as Double) else null,
                            chloride = if (recordMap["chloride"] != null) Mass.grams(recordMap["chloride"] as Double) else null,
                            cholesterol = if (recordMap["cholesterol"] != null) Mass.grams(recordMap["cholesterol"] as Double) else null,
                            chromium = if (recordMap["chromium"] != null) Mass.grams(recordMap["chromium"] as Double) else null,
                            copper = if (recordMap["copper"] != null) Mass.grams(recordMap["copper"] as Double) else null,
                            dietaryFiber = if (recordMap["dietaryFiber"] != null) Mass.grams(recordMap["dietaryFiber"] as Double) else null,
                            folate = if (recordMap["folate"] != null) Mass.grams(recordMap["folate"] as Double) else null,
                            folicAcid = if (recordMap["folicAcid"] != null) Mass.grams(recordMap["folicAcid"] as Double) else null,
                            iodine = if (recordMap["iodine"] != null) Mass.grams(recordMap["iodine"] as Double) else null,
                            iron = if (recordMap["iron"] != null) Mass.grams(recordMap["iron"] as Double) else null,
                            magnesium = if (recordMap["magnesium"] != null) Mass.grams(recordMap["magnesium"] as Double) else null,
                            manganese = if (recordMap["manganese"] != null) Mass.grams(recordMap["manganese"] as Double) else null,
                            molybdenum = if (recordMap["molybdenum"] != null) Mass.grams(recordMap["molybdenum"] as Double) else null,
                            monounsaturatedFat = if (recordMap["monounsaturatedFat"] != null) Mass.grams(recordMap["monounsaturatedFat"] as Double) else null,
                            niacin = if (recordMap["niacin"] != null) Mass.grams(recordMap["niacin"] as Double) else null,
                            pantothenicAcid = if (recordMap["pantothenicAcid"] != null) Mass.grams(recordMap["pantothenicAcid"] as Double) else null,
                            phosphorus = if (recordMap["phosphorus"] != null) Mass.grams(recordMap["phosphorus"] as Double) else null,
                            polyunsaturatedFat = if (recordMap["polyunsaturatedFat"] != null) Mass.grams(recordMap["polyunsaturatedFat"] as Double) else null,
                            potassium = if (recordMap["potassium"] != null) Mass.grams(recordMap["potassium"] as Double) else null,
                            protein = if (recordMap["protein"] != null) Mass.grams(recordMap["protein"] as Double) else null,
                            riboflavin = if (recordMap["riboflavin"] != null) Mass.grams(recordMap["riboflavin"] as Double) else null,
                            saturatedFat = if (recordMap["saturatedFat"] != null) Mass.grams(recordMap["saturatedFat"] as Double) else null,
                            selenium = if (recordMap["selenium"] != null) Mass.grams(recordMap["selenium"] as Double) else null,
                            sodium = if (recordMap["sodium"] != null) Mass.grams(recordMap["sodium"] as Double) else null,
                            sugar = if (recordMap["sugar"] != null) Mass.grams(recordMap["sugar"] as Double) else null,
                            thiamin = if (recordMap["thiamin"] != null) Mass.grams(recordMap["thiamin"] as Double) else null,
                            totalCarbohydrate = if (recordMap["totalCarbohydrate"] != null) Mass.grams(recordMap["totalCarbohydrate"] as Double) else null,
                            totalFat = if (recordMap["totalFat"] != null) Mass.grams(recordMap["totalFat"] as Double) else null,
                            transFat = if (recordMap["transFat"] != null) Mass.grams(recordMap["transFat"] as Double) else null,
                            unsaturatedFat = if (recordMap["unsaturatedFat"] != null) Mass.grams(recordMap["unsaturatedFat"] as Double) else null,
                            vitaminA = if (recordMap["vitaminA"] != null) Mass.grams(recordMap["vitaminA"] as Double) else null,
                            vitaminB12 = if (recordMap["vitaminB12"] != null) Mass.grams(recordMap["vitaminB12"] as Double) else null,
                            vitaminB6 = if (recordMap["vitaminB6"] != null) Mass.grams(recordMap["vitaminB6"] as Double) else null,
                            vitaminC = if (recordMap["vitaminC"] != null) Mass.grams(recordMap["vitaminC"] as Double) else null,
                            vitaminD = if (recordMap["vitaminD"] != null) Mass.grams(recordMap["vitaminD"] as Double) else null,
                            vitaminE = if (recordMap["vitaminE"] != null) Mass.grams(recordMap["vitaminE"] as Double) else null,
                            vitaminK = if (recordMap["vitaminK"] != null) Mass.grams(recordMap["vitaminK"] as Double) else null,
                            zinc = if (recordMap["zinc"] != null) Mass.grams(recordMap["zinc"] as Double) else null,
                            name = recordMap["name"] as String?,
                            mealType = recordMap["mealType"] as Int,
                            metadata = metadata,
                        )
                        OVULATION_TEST -> OvulationTestRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            result = recordMap["result"] as Int,
                            metadata = metadata,
                        )
                        OXYGEN_SATURATION -> OxygenSaturationRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            percentage = Percentage(recordMap["percentage"] as Double),
                            metadata = metadata,
                        )
                        POWER -> PowerRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            samples = (recordMap["samples"] as List<*>).filterIsInstance<PowerRecord.Sample>(),
                            metadata = metadata,
                        )
                        RESPIRATORY_RATE -> RespiratoryRateRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            rate = recordMap["rate"] as Double,
                            metadata = metadata,
                        )
                        RESTING_HEART_RATE -> RestingHeartRateRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            beatsPerMinute = (recordMap["beatsPerMinute"] as Int).toLong(),
                            metadata = metadata,
                        )
                        SEXUAL_ACTIVITY -> SexualActivityRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            protectionUsed = recordMap["protectionUsed"] as Int,
                            metadata = metadata,
                        )
                        SLEEP_SESSION -> SleepSessionRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            title = recordMap["title"] as String?,
                            notes = recordMap["notes"] as String?,
                            metadata = metadata,
                        )
                        SLEEP_STAGE -> SleepStageRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            stage = recordMap["stage"] as Int,
                            metadata = metadata,
                        )
                        SPEED -> SpeedRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            samples = (recordMap["samples"] as List<*>).filterIsInstance<SpeedRecord.Sample>(),
                            metadata = metadata,
                        )
                        STEPS_CADENCE -> StepsCadenceRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            samples = (recordMap["samples"] as List<*>).filterIsInstance<StepsCadenceRecord.Sample>(),
                            metadata = metadata,
                        )
                        STEPS -> StepsRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            count = (recordMap["count"] as Int).toLong(),
                            metadata = metadata,
                        )
                        TOTAL_CALORIES_BURNED -> TotalCaloriesBurnedRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            energy = Energy.kilocalories(recordMap["energy"] as Double),
                            metadata = metadata,
                        )
                        VO2_MAX -> Vo2MaxRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            vo2MillilitersPerMinuteKilogram = recordMap["vo2MillilitersPerMinuteKilogram"] as Double,
                            measurementMethod = recordMap["measurementMethod"] as Int,
                            metadata = metadata,
                        )
                        WEIGHT -> WeightRecord(
                            time = Instant.parse(recordMap["time"] as String),
                            zoneOffset = if (recordMap["zoneOffset"] != null) ZoneOffset.ofHours(recordMap["zoneOffset"] as Int) else null,
                            weight = Mass.kilograms(recordMap["weight"] as Double),
                            metadata = metadata,
                        )
                        WHEELCHAIR_PUSHES -> WheelchairPushesRecord(
                            startTime = Instant.parse(recordMap["startTime"] as String),
                            startZoneOffset = if (recordMap["startZoneOffset"] != null) ZoneOffset.ofHours(recordMap["startZoneOffset"] as Int) else null,
                            endTime = Instant.parse(recordMap["endTime"] as String),
                            endZoneOffset = if (recordMap["endTimeOffset"] != null) ZoneOffset.ofHours(recordMap["endZoneOffset"] as Int) else null,
                            count = (recordMap["count"] as Int).toLong(),
                            metadata = metadata,
                        )
                        else -> throw IllegalArgumentException("The type $type was not supported in this version of the plugin")
                    }
                    recordsList.add(record)
                }
                scope.launch {
                try {
                    client.insertRecords(recordsList)
                    result.success(true)
                } catch (e: Throwable) {
                    result.error("WRITE_DATA_FAIL", e.localizedMessage, e)
                }
            }
        }
    }

    private fun aggregate(call: MethodCall, result: Result) {
        scope.launch {
            try {
                val aggregationKeys =
                    (call.argument<ArrayList<*>>("aggregationKeys")?.filterIsInstance<String>() as ArrayList<String>?)?.toList()

                if(aggregationKeys.isNullOrEmpty()) {
                    result.success(LinkedHashMap<String, Any?>())
                } else {
                    val startTime = call.argument<String>("startTime")
                    val endTime = call.argument<String>("endTime")
                    val start = startTime?.let { Instant.parse(it) } ?: Instant.now()
                        .minus(1, ChronoUnit.DAYS)
                    val end = endTime?.let { Instant.parse(it) } ?: Instant.now()
                    val metrics =
                        aggregationKeys.mapNotNull { HealthConnectAggregateMetricTypeMap[it] }

                    val response =
                        client.aggregate(
                            AggregateRequest(
                                metrics.toSet(),
                                timeRangeFilter = TimeRangeFilter.between(start, end)
                            )
                        )

                    val resultData = aggregationKeys.associateBy(
                        {it},
                        {
                            replyMapper.convertValue(
                                response[HealthConnectAggregateMetricTypeMap[it]!!],
                                Double::class.java
                            )
                        }
                    )
                    result.success(resultData)
                }
            } catch (e: Exception) {
                result.error("AGGREGATE_FAIL", e.localizedMessage, e)
            }
        }

    }


}
