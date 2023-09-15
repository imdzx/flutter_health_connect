package dev.duynp.flutter_health_connect

import androidx.health.connect.client.aggregate.AggregateMetric
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
const val SLEEP_STAGE = "SleepStage"
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
    SLEEP_STAGE to SleepStageRecord::class,
    SPEED to SpeedRecord::class,
    STEPS_CADENCE to StepsCadenceRecord::class,
    STEPS to StepsRecord::class,
    TOTAL_CALORIES_BURNED to TotalCaloriesBurnedRecord::class,
    VO2_MAX to Vo2MaxRecord::class,
    WEIGHT to WeightRecord::class,
    WHEELCHAIR_PUSHES to WheelchairPushesRecord::class,
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

// Used by the "aggregate" function.
// List of all possible records: https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/package-summary
val HealthConnectAggregateMetricTypeMap = hashMapOf<String, AggregateMetric<*>>(
    // ActiveCaloriesBurnedRecord
    "ActiveCaloriesBurnedRecordActiveCaloriesTotal" to ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL,

    // BasalBodyTemperatureRecord: No AggregateMetric

    // BasalMetabolicRateRecord:
    "BasalMetabolicRateRecordBasalCaloriesTotal" to BasalMetabolicRateRecord.BASAL_CALORIES_TOTAL,

    // BloodGlucoseRecord: No AggregateMetric

    // BloodPressureRecord
    "BloodPressureRecordSystolicAvg" to BloodPressureRecord.SYSTOLIC_AVG,
    "BloodPressureRecordSystolicMin" to BloodPressureRecord.SYSTOLIC_MIN,
    "BloodPressureRecordSystolicMax" to BloodPressureRecord.SYSTOLIC_MAX,
    "BloodPressureRecordDiastolicAvg" to BloodPressureRecord.DIASTOLIC_AVG,
    "BloodPressureRecordDiastolicMin" to BloodPressureRecord.DIASTOLIC_MIN,
    "BloodPressureRecordDiastolicMax" to BloodPressureRecord.DIASTOLIC_MAX,

    // BodyFatRecord: No AggregateMetric

    // BodyTemperatureRecord: No AggregateMetric

    // BodyWaterMassRecord: No AggregateMetric

    // BoneMassRecord: No AggregateMetric

    // CervicalMucusRecord: No AggregateMetric

    // CyclingPedalingCadenceRecord
    "CyclingPedalingCadenceRecordRpmAvg" to CyclingPedalingCadenceRecord.RPM_AVG,
    "CyclingPedalingCadenceRecordRpmMin" to CyclingPedalingCadenceRecord.RPM_MIN,
    "CyclingPedalingCadenceRecordRpmMax" to CyclingPedalingCadenceRecord.RPM_MAX,

    // DistanceRecord
    "DistanceRecordDistanceTotal" to DistanceRecord.DISTANCE_TOTAL,

    // ElevationGainedRecord
    "ElevationGainedRecordElevationGainedTotal" to ElevationGainedRecord.ELEVATION_GAINED_TOTAL,

    // ExerciseSessionRecord
    "ExerciseSessionRecordExerciseDurationTotal" to ExerciseSessionRecord.EXERCISE_DURATION_TOTAL,

    // FloorsClimbedRecord
    "FloorsClimbedRecordFloorsClimbedTotal" to FloorsClimbedRecord.FLOORS_CLIMBED_TOTAL,

    // HeartRateRecord
    "HeartRateRecordBpmAvg" to HeartRateRecord.BPM_AVG,
    "HeartRateRecordBpmMin" to HeartRateRecord.BPM_MIN,
    "HeartRateRecordBpmMax" to HeartRateRecord.BPM_MAX,
    "HeartRateRecordMeasurementsCount" to HeartRateRecord.MEASUREMENTS_COUNT,

    // HeartRateVariabilityRmssdRecord: No AggregateMetric

    "HeightRecordHeightAvg" to HeightRecord.HEIGHT_AVG,
    "HeightRecordHeightMin" to HeightRecord.HEIGHT_MIN,
    "HeightRecordHeightMax" to HeightRecord.HEIGHT_MAX,
    "HydrationRecordVolumeTotal" to HydrationRecord.VOLUME_TOTAL,

    // IntermenstrualBleedingRecord: No AggregateMetric

    // LeanBodyMassRecord: No AggregateMetric

    // MenstruationFlowRecord: No AggregateMetric

    // MenstruationPeriodRecord: No AggregateMetric

    // NutritionRecord
    "NutritionRecordBiotinTotal" to NutritionRecord.BIOTIN_TOTAL,
    "NutritionRecordCaffeineTotal" to NutritionRecord.CAFFEINE_TOTAL,
    "NutritionRecordCalciumTotal" to NutritionRecord.CALCIUM_TOTAL,
    "NutritionRecordEnergyTotal" to NutritionRecord.ENERGY_TOTAL,
    "NutritionRecordEnergyFromFatTotal" to NutritionRecord.ENERGY_FROM_FAT_TOTAL,
    "NutritionRecordChlorideTotal" to NutritionRecord.CHLORIDE_TOTAL,
    "NutritionRecordCholesterolTotal" to NutritionRecord.CHOLESTEROL_TOTAL,
    "NutritionRecordChromiumTotal" to NutritionRecord.CHROMIUM_TOTAL,
    "NutritionRecordCopperTotal" to NutritionRecord.COPPER_TOTAL,
    "NutritionRecordDietaryFiberTotal" to NutritionRecord.DIETARY_FIBER_TOTAL,
    "NutritionRecordFolateTotal" to NutritionRecord.FOLATE_TOTAL,
    "NutritionRecordFolicAcidTotal" to NutritionRecord.FOLIC_ACID_TOTAL,
    "NutritionRecordIodineTotal" to NutritionRecord.IODINE_TOTAL,
    "NutritionRecordIronTotal" to NutritionRecord.IRON_TOTAL,
    "NutritionRecordMagnesiumTotal" to NutritionRecord.MAGNESIUM_TOTAL,
    "NutritionRecordManganeseTotal" to NutritionRecord.MANGANESE_TOTAL,
    "NutritionRecordMolybdenumTotal" to NutritionRecord.MOLYBDENUM_TOTAL,
    "NutritionRecordMonounsaturatedFatTotal" to NutritionRecord.MONOUNSATURATED_FAT_TOTAL,
    "NutritionRecordNiacinTotal" to NutritionRecord.NIACIN_TOTAL,
    "NutritionRecordPantothenicAcidTotal" to NutritionRecord.PANTOTHENIC_ACID_TOTAL,
    "NutritionRecordPhosphorusTotal" to NutritionRecord.PHOSPHORUS_TOTAL,
    "NutritionRecordPolyunsaturatedFatTotal" to NutritionRecord.POLYUNSATURATED_FAT_TOTAL,
    "NutritionRecordPotassiumTotal" to NutritionRecord.POTASSIUM_TOTAL,
    "NutritionRecordProteinTotal" to NutritionRecord.PROTEIN_TOTAL,
    "NutritionRecordRiboflavinTotal" to NutritionRecord.RIBOFLAVIN_TOTAL,
    "NutritionRecordSaturatedFatTotal" to NutritionRecord.SATURATED_FAT_TOTAL,
    "NutritionRecordSeleniumTotal" to NutritionRecord.SELENIUM_TOTAL,
    "NutritionRecordSodiumTotal" to NutritionRecord.SODIUM_TOTAL,
    "NutritionRecordSugarTotal" to NutritionRecord.SUGAR_TOTAL,
    "NutritionRecordThiaminTotal" to NutritionRecord.THIAMIN_TOTAL,
    "NutritionRecordTotalCarbohydrateTotal" to NutritionRecord.TOTAL_CARBOHYDRATE_TOTAL,
    "NutritionRecordTotalFatTotal" to NutritionRecord.TOTAL_FAT_TOTAL,
    "NutritionRecordTransFatTotal" to NutritionRecord.TRANS_FAT_TOTAL,
    "NutritionRecordUnsaturatedFatTotal" to NutritionRecord.UNSATURATED_FAT_TOTAL,
    "NutritionRecordVitaminATotal" to NutritionRecord.VITAMIN_A_TOTAL,
    "NutritionRecordVitaminB12Total" to NutritionRecord.VITAMIN_B12_TOTAL,
    "NutritionRecordVitaminB6Total" to NutritionRecord.VITAMIN_B6_TOTAL,
    "NutritionRecordVitaminCTotal" to NutritionRecord.VITAMIN_C_TOTAL,
    "NutritionRecordVitaminDTotal" to NutritionRecord.VITAMIN_D_TOTAL,
    "NutritionRecordVitaminETotal" to NutritionRecord.VITAMIN_E_TOTAL,
    "NutritionRecordVitaminKTotal" to NutritionRecord.VITAMIN_K_TOTAL,
    "NutritionRecordZincTotal" to NutritionRecord.ZINC_TOTAL,

    // OvulationTestRecord: No AggregateMetric

    // OxygenSaturationRecord: No AggregateMetric

    // PowerRecord
    "PowerRecordPowerAvg" to PowerRecord.POWER_AVG,
    "PowerRecordPowerMin" to PowerRecord.POWER_MIN,
    "PowerRecordPowerMax" to PowerRecord.POWER_MAX,

    // RespiratoryRateRecord: No AggregateMetric

    // RestingHeartRate
    "RestingHeartRateRecordBpmAvg" to RestingHeartRateRecord.BPM_AVG,
    "RestingHeartRateRecordBpmMin" to RestingHeartRateRecord.BPM_MIN,
    "RestingHeartRateRecordBpmMax" to RestingHeartRateRecord.BPM_MAX,

    // SexualActivityRecord: No AggregateMetric

    // SleepSessionRecord
    "SleepSessionRecordSleepDurationTotal" to SleepSessionRecord.SLEEP_DURATION_TOTAL,

    // SpeedRecord
    "SpeedRecordSpeedAvg" to SpeedRecord.SPEED_AVG,
    "SpeedRecordSpeedMin" to SpeedRecord.SPEED_MIN,
    "SpeedRecordSpeedMax" to SpeedRecord.SPEED_MAX,

    // StepsCadenceRecord
    "StepsCadenceRecordRateAvg" to StepsCadenceRecord.RATE_AVG,
    "StepsCadenceRecordRateMin" to StepsCadenceRecord.RATE_MIN,
    "StepsCadenceRecordRateMax" to StepsCadenceRecord.RATE_MAX,

    // StepsRecord
    "StepsRecordCountTotal" to StepsRecord.COUNT_TOTAL,

    // TotalCaloriesBurnedRecord
    "TotalCaloriesBurnedRecordEnergyTotal" to TotalCaloriesBurnedRecord.ENERGY_TOTAL,

    // Vo2MaxRecord: No AggregateMetric

    // WeightRecord
    "WeightRecordWeightAvg" to WeightRecord.WEIGHT_AVG,
    "WeightRecordWeightMin" to WeightRecord.WEIGHT_MIN,
    "WeightRecordWeightMax" to WeightRecord.WEIGHT_MAX,

    // WheelchairPushesRecord
    "WheelchairPushesRecordCountTotal" to WheelchairPushesRecord.COUNT_TOTAL,
)
