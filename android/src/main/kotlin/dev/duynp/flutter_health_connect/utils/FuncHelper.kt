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
const val ExerciseEvent = "ExerciseEvent"
const val ExerciseLap = "ExerciseLap"
const val ExerciseRepetitions = "ExerciseRepetitions"
const val ExerciseSession = "ExerciseSession"
const val FloorsClimbed = "FloorsClimbed"
const val HeartRate = "HeartRate"
const val Height = "Height"
const val HipCircumference = "HipCircumference"
const val Hydration = "Hydration"
const val LeanBodyMass = "LeanBodyMass"
const val MenstruationFlow = "MenstruationFlow"
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
const val SwimmingStrokes = "SwimmingStrokes"
const val TotalCaloriesBurned = "TotalCaloriesBurned"
const val Vo2Max = "Vo2Max"
const val WaistCircumference = "WaistCircumference"
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
    ): MutableSet<HealthPermission> {
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
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    BloodGlucoseRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.createReadPermission(BloodGlucoseRecord::class))
                    }

                    BloodPressure -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    BloodPressureRecord::class
                                )
                            )
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
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    BodyTemperatureRecord::class
                                )
                            )
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
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    CervicalMucusRecord::class
                                )
                            )
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
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    ElevationGainedRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.createReadPermission(ElevationGainedRecord::class))
                    }

                    ExerciseEvent -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    ExerciseEventRecord::class
                                )
                            )
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
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    ExerciseSessionRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.createReadPermission(ExerciseSessionRecord::class))
                    }

                    FloorsClimbed -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    FloorsClimbedRecord::class
                                )
                            )
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
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    LeanBodyMassRecord::class
                                )
                            )
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
                            permissions.add(HealthPermission.createWritePermission(NutritionRecord::class))
                        }
                        permissions.add(HealthPermission.createReadPermission(NutritionRecord::class))
                    }

                    OvulationTest -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    OvulationTestRecord::class
                                )
                            )
                        }
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
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    RespiratoryRateRecord::class
                                )
                            )
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
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    SexualActivityRecord::class
                                )
                            )
                        }
                        permissions.add(HealthPermission.createReadPermission(SexualActivityRecord::class))
                    }

                    SleepSession -> {
                        if (!readOnly) {
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    SleepSessionRecord::class
                                )
                            )
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
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    StepsCadenceRecord::class
                                )
                            )
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
                            permissions.add(
                                HealthPermission.createWritePermission(
                                    SwimmingStrokesRecord::class
                                )
                            )
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



