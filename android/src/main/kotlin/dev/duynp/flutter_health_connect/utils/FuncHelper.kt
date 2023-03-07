package dev.duynp.flutter_health_connect

import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.*

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

const val playStoreUri =
    "https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata"
const val HEALTH_CONNECT_RESULT_CODE = 16969
const val MAX_LENGTH = 9999999

object FuncHelper {
    fun mapToHealthPermissions(
        types: List<String>?,
        readOnly: Boolean
    ): MutableSet<String
            > {
        val permissions = mutableSetOf<String>()
        if (types != null) {
            for (item: String in types) {
                when (item) {
                    ActiveCaloriesBurned -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    ActiveCaloriesBurnedRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.getReadPermission(
                                ActiveCaloriesBurnedRecord::class
                            )
                        )
                    }

                    BasalBodyTemperature -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    BasalBodyTemperatureRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.getReadPermission(
                                BasalBodyTemperatureRecord::class
                            )
                        )
                    }

                    BasalMetabolicRate -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    BasalMetabolicRateRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.getReadPermission(
                                BasalMetabolicRateRecord::class
                            )
                        )
                    }

                    BloodGlucose -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    BloodGlucoseRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(BloodGlucoseRecord::class))
                    }

                    BloodPressure -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    BloodPressureRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(BloodPressureRecord::class))
                    }

                    BodyFat -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(BodyFatRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(BodyFatRecord::class))
                    }

                    BodyTemperature -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    BodyTemperatureRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(BodyTemperatureRecord::class))
                    }

                    BoneMass -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(BoneMassRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(BoneMassRecord::class))
                    }

                    CervicalMucus -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    CervicalMucusRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(CervicalMucusRecord::class))
                    }

                    CyclingPedalingCadence -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    CyclingPedalingCadenceRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.getReadPermission(
                                CyclingPedalingCadenceRecord::class
                            )
                        )
                    }

                    Distance -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(DistanceRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(DistanceRecord::class))
                    }

                    ElevationGained -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    ElevationGainedRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(ElevationGainedRecord::class))
                    }


                    ExerciseSession -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    ExerciseSessionRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(ExerciseSessionRecord::class))
                    }

                    FloorsClimbed -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    FloorsClimbedRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(FloorsClimbedRecord::class))
                    }

                    HeartRate -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(HeartRateRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(HeartRateRecord::class))
                    }

                    Height -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(HeightRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(HeightRecord::class))
                    }

                    Hydration -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(HydrationRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(HydrationRecord::class))
                    }

                    LeanBodyMass -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    LeanBodyMassRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(LeanBodyMassRecord::class))
                    }

                    MenstruationFlow -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    MenstruationFlowRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(MenstruationFlowRecord::class))
                    }
                    MenstruationPeriod -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    MenstruationPeriodRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(MenstruationPeriodRecord::class))
                    }
                    Nutrition -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(NutritionRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(NutritionRecord::class))
                    }

                    OvulationTest -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    OvulationTestRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(OvulationTestRecord::class))
                    }

                    OxygenSaturation -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    OxygenSaturationRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(OxygenSaturationRecord::class))
                    }

                    Power -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(PowerRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(PowerRecord::class))
                    }

                    RespiratoryRate -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    RespiratoryRateRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(RespiratoryRateRecord::class))
                    }

                    RestingHeartRate -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    RestingHeartRateRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(RestingHeartRateRecord::class))
                    }

                    SexualActivity -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    SexualActivityRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(SexualActivityRecord::class))
                    }

                    SleepSession -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    SleepSessionRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(SleepSessionRecord::class))
                    }

                    SleepStage -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(SleepStageRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(SleepStageRecord::class))
                    }

                    Speed -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(SpeedRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(SpeedRecord::class))
                    }

                    StepsCadence -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    StepsCadenceRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(StepsCadenceRecord::class))
                    }

                    Steps -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(StepsRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(StepsRecord::class))
                    }

                    TotalCaloriesBurned -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    TotalCaloriesBurnedRecord::class
                                )
                            )
                        }
                        permissions.add(
                            HealthPermission.getReadPermission(
                                TotalCaloriesBurnedRecord::class
                            )
                        )
                    }

                    Vo2Max -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(Vo2MaxRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(Vo2MaxRecord::class))
                    }

                    Weight -> {
                        if (!readOnly) {
                            permissions.add(HealthPermission.getWritePermission(WeightRecord::class))
                        }
                        permissions.add(HealthPermission.getReadPermission(WeightRecord::class))
                    }

                    WheelchairPushes -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.getWritePermission(
                                    WheelchairPushesRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.getReadPermission(WheelchairPushesRecord::class))
                    }
                }
            }
        }
        return permissions
    }
}



