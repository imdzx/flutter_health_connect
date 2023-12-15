package dev.duynp.flutter_health_connect

import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.*

const val ACTIVE_CALORIES_BURNED = "ActiveCaloriesBurned"
const val BASAL_BODY_TEMPERATURE = "BasalBodyTemperature"
const val BASAL_METABOLIC_RATE = "BasalMetabolicRate"
const val BLOOD_GLUCOSE = "BloodGlucose"
const val BLOOD_PRESSURE = "BloodPressure"
const val BODY_FAT = "BodyFat"
const val BODY_TEMPERATURE = "BodyTemperature"
const val BODY_WATER_MASS = "BodyWaterMass"
const val BONE_MASS = "BoneMass"
const val CERVICAL_MUCUS = "CervicalMucus"
const val CYCLING_PEDALING_CADENCE = "CyclingPedalingCadence"
const val DISTANCE = "Distance"
const val ELEVATION_GAINED = "ElevationGained"
const val EXERCISE_SESSION = "ExerciseSession"
const val FLOORS_CLIMBED = "FloorsClimbed"
const val HEART_RATE = "HeartRate"
const val HEART_RATE_VARIABILITY = "HeartRateVariabilityRmssd"
const val HEIGHT = "Height"
const val HYDRATION = "Hydration"
const val INTERMENSTRUAL_BLEEDING = "IntermenstrualBleedingRecord"
const val LEAN_BODY_MASS = "LeanBodyMass"
const val MENSTRUATION_FLOW = "MenstruationFlow"
const val MENSTRUATION_PERIOD = "MenstruationPeriod"
const val NUTRITION = "Nutrition"
const val OVULATION_TEST = "OvulationTest"
const val OXYGEN_SATURATION = "OxygenSaturation"
const val POWER = "Power"
const val RESPIRATORY_RATE = "RespiratoryRate"
const val RESTING_HEART_RATE = "RestingHeartRate"
const val SEXUAL_ACTIVITY = "SexualActivity"
const val SLEEP_SESSION = "SleepSession"
const val SPEED = "Speed"
const val STEPS_CADENCE = "StepsCadence"
const val STEPS = "Steps"
const val TOTAL_CALORIES_BURNED = "TotalCaloriesBurned"
const val VO2_MAX = "Vo2Max"
const val WEIGHT = "Weight"
const val WHEELCHAIR_PUSHES = "WheelchairPushes"

val HealthConnectRecordTypeMap = hashMapOf(
    ACTIVE_CALORIES_BURNED to ActiveCaloriesBurnedRecord::class,
    BASAL_BODY_TEMPERATURE to BasalBodyTemperatureRecord::class,
    BASAL_METABOLIC_RATE to BasalMetabolicRateRecord::class,
    BLOOD_GLUCOSE to BloodGlucoseRecord::class,
    BLOOD_PRESSURE to BloodPressureRecord::class,
    BODY_FAT to BodyFatRecord::class,
    BODY_TEMPERATURE to BodyTemperatureRecord::class,
    BODY_WATER_MASS to BodyWaterMassRecord::class,
    BONE_MASS to BoneMassRecord::class,
    CERVICAL_MUCUS to CervicalMucusRecord::class,
    CYCLING_PEDALING_CADENCE to CyclingPedalingCadenceRecord::class,
    DISTANCE to DistanceRecord::class,
    ELEVATION_GAINED to ElevationGainedRecord::class,
    EXERCISE_SESSION to ExerciseSessionRecord::class,
    FLOORS_CLIMBED to FloorsClimbedRecord::class,
    HEART_RATE to HeartRateRecord::class,
    HEART_RATE_VARIABILITY to HeartRateVariabilityRmssdRecord::class,
    HEIGHT to HeightRecord::class,
    HYDRATION to HydrationRecord::class,
    INTERMENSTRUAL_BLEEDING to IntermenstrualBleedingRecord::class,
    LEAN_BODY_MASS to LeanBodyMassRecord::class,
    MENSTRUATION_FLOW to MenstruationFlowRecord::class,
    MENSTRUATION_PERIOD to MenstruationPeriodRecord::class,
    NUTRITION to NutritionRecord::class,
    OVULATION_TEST to OvulationTestRecord::class,
    OXYGEN_SATURATION to OxygenSaturationRecord::class,
    POWER to PowerRecord::class,
    RESPIRATORY_RATE to RespiratoryRateRecord::class,
    RESTING_HEART_RATE to RestingHeartRateRecord::class,
    SEXUAL_ACTIVITY to SexualActivityRecord::class,
    SLEEP_SESSION to SleepSessionRecord::class,
    SPEED to SpeedRecord::class,
    STEPS_CADENCE to StepsCadenceRecord::class,
    STEPS to StepsRecord::class,
    TOTAL_CALORIES_BURNED to TotalCaloriesBurnedRecord::class,
    VO2_MAX to Vo2MaxRecord::class,
    WEIGHT to WeightRecord::class,
    WHEELCHAIR_PUSHES to WheelchairPushesRecord::class,
)
const val HEALTH_CONNECT_RESULT_CODE = 16969
const val MAX_LENGTH = 5000

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



