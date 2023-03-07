// ignore_for_file: constant_identifier_names

part of flutter_health_connect;

/// List of all available data types.
enum HealthConnectDataType {
  ActiveCaloriesBurned,
  BasalBodyTemperature,
  BasalMetabolicRate,
  BloodGlucose,
  BloodPressure,
  BodyFat,
  BodyTemperature,
  BoneMass,
  CervicalMucus,
  CyclingPedalingCadence,
  Distance,
  ElevationGained,
  ExerciseSession,
  FloorsClimbed,
  HeartRate,
  Height,
  Hydration,
  LeanBodyMass,
  MenstruationFlow,
  MenstruationPeriod,
  Nutrition,
  OvulationTest,
  OxygenSaturation,
  Power,
  RespiratoryRate,
  RestingHeartRate,
  SexualActivity,
  SleepSession,
  SleepStage,
  Speed,
  StepsCadence,
  Steps,
  TotalCaloriesBurned,
  Vo2Max,
  Weight,
  WheelchairPushes,
}

enum HealthConnectDataAccess {
  READ,
  WRITE,
  READ_WRITE,
}
