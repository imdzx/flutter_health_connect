package dev.duynp.flutter_health_connect

import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.*
import java.time.ZoneId

const val ActiveCaloriesBurned = "ActiveCaloriesBurned"
const val BasalBodyTemperature = "BasalBodyTemperature"
const val BasalMetabolicRate = "BasalMetabolicRate"
const val BloodGlucose = "BloodGlucose"
const val BloodPressure = "BloodPressure"
const val BodyFat = "BodyFat"
const val BodyTemperature = "BodyTemperature"
const val BoneMass = "BoneMass"
const val CervicalMucus = "CervicalMucus"
const val CyclingPedalingCadence = "CyclingPedalingCadence"
const val Distance = "Distance"
const val ElevationGained = "ElevationGained"
const val ExerciseSession = "ExerciseSession"
const val FloorsClimbed = "FloorsClimbed"
const val HeartRate = "HeartRate"
const val Height = "Height"
const val Hydration = "Hydration"
const val LeanBodyMass = "LeanBodyMass"
const val MenstruationFlow = "MenstruationFlow"
const val MenstruationPeriod = "MenstruationPeriod"
const val Nutrition = "Nutrition"
const val OvulationTest = "OvulationTest"
const val OxygenSaturation = "OxygenSaturation"
const val Power = "Power"
const val RespiratoryRate = "RespiratoryRate"
const val RestingHeartRate = "RestingHeartRate"
const val SexualActivity = "SexualActivity"
const val SleepSession = "SleepSession"
const val SleepStage = "SleepStage"
const val Speed = "Speed"
const val StepsCadence = "StepsCadence"
const val Steps = "Steps"
const val TotalCaloriesBurned = "TotalCaloriesBurned"
const val Vo2Max = "Vo2Max"
const val Weight = "Weight"
const val WheelchairPushes = "WheelchairPushes"

val HealthConnectRecordTypeMap = hashMapOf(
    ActiveCaloriesBurned to ActiveCaloriesBurnedRecord::class,
    BasalBodyTemperature to BasalBodyTemperatureRecord::class,
    BasalMetabolicRate to BasalMetabolicRateRecord::class,
    BloodGlucose to BloodGlucoseRecord::class,
    BloodPressure to BloodPressureRecord::class,
    BodyFat to BodyFatRecord::class,
    BodyTemperature to BodyTemperatureRecord::class,
    BoneMass to BoneMassRecord::class,
    CervicalMucus to CervicalMucusRecord::class,
    CyclingPedalingCadence to CyclingPedalingCadenceRecord::class,
    Distance to DistanceRecord::class,
    ElevationGained to ElevationGainedRecord::class,
    ExerciseSession to ExerciseSessionRecord::class,
    FloorsClimbed to FloorsClimbedRecord::class,
    HeartRate to HeartRateRecord::class,
    Height to HeightRecord::class,
    Hydration to HydrationRecord::class,
    LeanBodyMass to LeanBodyMassRecord::class,
    MenstruationFlow to MenstruationFlowRecord::class,
    MenstruationPeriod to MenstruationPeriodRecord::class,
    Nutrition to NutritionRecord::class,
    OvulationTest to OvulationTestRecord::class,
    OxygenSaturation to OxygenSaturationRecord::class,
    Power to PowerRecord::class,
    RespiratoryRate to RespiratoryRateRecord::class,
    RestingHeartRate to RestingHeartRateRecord::class,
    SexualActivity to SexualActivityRecord::class,
    SleepSession to SleepSessionRecord::class,
    SleepStage to SleepStageRecord::class,
    Speed to SpeedRecord::class,
    StepsCadence to StepsCadenceRecord::class,
    Steps to StepsRecord::class,
    TotalCaloriesBurned to TotalCaloriesBurnedRecord::class,
    Vo2Max to Vo2MaxRecord::class,
    Weight to WeightRecord::class,
    WheelchairPushes to WheelchairPushesRecord::class,
)
const val HEALTH_CONNECT_RESULT_CODE = 16969
const val MAX_LENGTH = 9999999

fun mapTypesToPermissions(
    types: List<String>?,
    readOnly: Boolean
): MutableSet<String
        > {
    val permissions = mutableSetOf<String>()
    if (types != null) {
        for (item: String in types) {
            HealthConnectRecordTypeMap[item]?.let { classType ->
                if (!readOnly) {
                    permissions.add(HealthPermission.getWritePermission(classType))
                }
                permissions.add(HealthPermission.getReadPermission(classType))
            }
        }
    }
    return permissions
}



