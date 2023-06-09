part of flutter_health_connect;

class HealthConnectFactory {
  static const MethodChannel _channel = MethodChannel('flutter_health_connect');

  static Future<bool> isApiSupported() async {
    return await _channel.invokeMethod('isApiSupported');
  }

  static Future<bool> isAvailable() async {
    return await _channel.invokeMethod('isAvailable');
  }

  static installHealthConnect() async {
    _channel.invokeMethod('installHealthConnect');
  }

  static Future<bool> hasPermissions(
    List<HealthConnectDataType> types, {
    bool readOnly = false,
  }) async {
    return await _channel.invokeMethod('hasPermissions', {
      'types': types.map((e) => e.name).toList(),
      'readOnly': readOnly,
    });
  }

  static Future<bool> requestPermissions(
    List<HealthConnectDataType> types, {
    bool readOnly = false,
  }) async {
    return await _channel.invokeMethod('requestPermissions', {
      'types': types.map((e) => e.name).toList(),
      'readOnly': readOnly,
    });
  }

  static Future<Map<String, dynamic>> getChanges(String token) async {
    return await _channel.invokeMethod('getChanges', {
      'token': token,
    }).then((value) => Map<String, Object>.from(value));
  }

  static Future<String> getChangesToken(
      List<HealthConnectDataType> types) async {
    return await _channel.invokeMethod('getChangesToken', {
      'types': types.map((e) => e.name).toList(),
    });
  }

  static Future<List<Record>> getRecords({
    required DateTime startTime,
    required DateTime endTime,
    required HealthConnectDataType type,
    int? pageSize,
    String? pageToken,
    bool ascendingOrder = true,
  }) async {
    final start = startTime.toLocal().toIso8601String();
    final end = endTime.toLocal().toIso8601String();
    final args = <String, dynamic>{
      'type': type.name,
      'startTime': start,
      'endTime': end,
      'pageSize': pageSize,
      'pageToken': pageToken,
      'ascendingOrder': ascendingOrder,
    };
    List<dynamic>? data = await _channel.invokeMethod('getRecord', args);
    if (data == null && data!.isNotEmpty) {
      List<Record> records =
          data.map((e) => mapToRecord(type, jsonDecode(e))).toList();
      return records;
    } else {
      return [];
    }
  }

  static Record mapToRecord(
      HealthConnectDataType type, Map<String, dynamic> map) {
    switch (type) {
      case HealthConnectDataType.ActiveCaloriesBurned:
        return ActiveCaloriesBurnedRecord.fromMap(map);
      case HealthConnectDataType.BasalBodyTemperature:
        return BasalBodyTemperatureRecord.fromMap(map);
      case HealthConnectDataType.BasalMetabolicRate:
        return BasalMetabolicRateRecord.fromMap(map);
      case HealthConnectDataType.BloodGlucose:
        return BloodGlucoseRecord.fromMap(map);
      case HealthConnectDataType.BloodPressure:
        return BloodPressureRecord.fromMap(map);
      case HealthConnectDataType.BodyFat:
        return BodyFatRecord.fromMap(map);
      case HealthConnectDataType.BodyTemperature:
        return BodyTemperatureRecord.fromMap(map);
      case HealthConnectDataType.BodyWaterMass:
        return BodyWaterMassRecord.fromMap(map);
      case HealthConnectDataType.BoneMass:
        return BoneMassRecord.fromMap(map);
      case HealthConnectDataType.CervicalMucus:
        return CervicalMucusRecord.fromMap(map);
      case HealthConnectDataType.CyclingPedalingCadence:
        return CyclingPedalingCadenceRecord.fromMap(map);
      case HealthConnectDataType.Distance:
        return DistanceRecord.fromMap(map);
      case HealthConnectDataType.ElevationGained:
        return ElevationGainedRecord.fromMap(map);
      case HealthConnectDataType.ExerciseSession:
        return ExerciseSessionRecord.fromMap(map);
      case HealthConnectDataType.FloorsClimbed:
        return FloorsClimbedRecord.fromMap(map);
      case HealthConnectDataType.HeartRate:
        return HeartRateRecord.fromMap(map);
      case HealthConnectDataType.HeartRateVariabilityRmssd:
        return HeartRateVariabilityRmssdRecord.fromMap(map);
      case HealthConnectDataType.Height:
        return HeightRecord.fromMap(map);
      case HealthConnectDataType.Hydration:
        return HydrationRecord.fromMap(map);
      case HealthConnectDataType.IntermenstrualBleeding:
        return IntermenstrualBleedingRecord.fromMap(map);
      case HealthConnectDataType.LeanBodyMass:
        return LeanBodyMassRecord.fromMap(map);
      case HealthConnectDataType.MenstruationFlow:
        return MenstruationFlowRecord.fromMap(map);
      case HealthConnectDataType.MenstruationPeriod:
        return MenstruationPeriodRecord.fromMap(map);
      case HealthConnectDataType.Nutrition:
        return NutritionRecord.fromMap(map);
      case HealthConnectDataType.OvulationTest:
        return OvulationTestRecord.fromMap(map);
      case HealthConnectDataType.OxygenSaturation:
        return OxygenSaturationRecord.fromMap(map);
      case HealthConnectDataType.Power:
        return PowerRecord.fromMap(map);
      case HealthConnectDataType.RespiratoryRate:
        return RespiratoryRateRecord.fromMap(map);
      case HealthConnectDataType.RestingHeartRate:
        return RestingHeartRateRecord.fromMap(map);
      case HealthConnectDataType.SexualActivity:
        return SexualActivityRecord.fromMap(map);
      case HealthConnectDataType.SleepSession:
        return SleepSessionRecord.fromMap(map);
      case HealthConnectDataType.SleepStage:
        return SleepStageRecord.fromMap(map);
      case HealthConnectDataType.Speed:
        return SpeedRecord.fromMap(map);
      case HealthConnectDataType.StepsCadence:
        return StepsCadenceRecord.fromMap(map);
      case HealthConnectDataType.Steps:
        return StepsRecord.fromMap(map);
      case HealthConnectDataType.TotalCaloriesBurned:
        return TotalCaloriesBurnedRecord.fromMap(map);
      case HealthConnectDataType.Vo2Max:
        return Vo2MaxRecord.fromMap(map);
      case HealthConnectDataType.Weight:
        return WeightRecord.fromMap(map);
      case HealthConnectDataType.WheelchairPushes:
        return WheelchairPushesRecord.fromMap(map);
    }
  }

  static Future<bool> writeData({
    required HealthConnectDataType type,
    required List<Record> data,
  }) async {
    final args = <String, dynamic>{
      'type': type.name,
      'data':
          List<Map<String, dynamic>>.from(data.map((Record e) => e.toMap())),
    };
    return await _channel.invokeMethod('writeData', args);
  }

  static Future<bool> openHealthConnectSettings() async {
    return await _channel.invokeMethod('openHealthConnectSettings');
  }
}
