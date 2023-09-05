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

  @Deprecated('Use getRecords instead')
  static Future<Map<String, dynamic>> getRecord({
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
    return await _channel
        .invokeMethod('getRecord', args)
        .then((value) => Map<String, Object>.from(value));
  }

  static Future<List<dynamic>> getRecords({
    required DateTime startTime,
    required DateTime endTime,
    required HealthConnectDataType type,
    int? pageSize,
    String? pageToken,
    bool ascendingOrder = true,
  }) async {
    final start = startTime.toUtc().toIso8601String();
    final end = endTime.toUtc().toIso8601String();
    final args = <String, dynamic>{
      'type': type.name,
      'startTime': start,
      'endTime': end,
      'pageSize': pageSize,
      'pageToken': pageToken,
      'ascendingOrder': ascendingOrder,
    };
    List<dynamic>? data = await _channel.invokeMethod('getRecords', args);
    if (data != null && data.isNotEmpty) {
      List<dynamic> records = data
          .map((e) => mapToRecord(type, Map<String, dynamic>.from(e)))
          .toList();
      return records;
    } else {
      return [];
    }
  }

  static dynamic mapToRecord(
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

  static Future<bool> deleteRecordsByIds({
    required HealthConnectDataType type,
    List<String> idList = const [],
    List<String> clientRecordIdsList = const [],
  }) async {
    final args = <String, dynamic>{
      'type': type.name,
      'idList': idList,
      'clientRecordIdsList': clientRecordIdsList,
    };
    return await _channel.invokeMethod('deleteRecordsByIds', args);
  }

  static Future<bool> deleteRecordsByTime({
    required HealthConnectDataType type,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final start = startTime.toUtc().toIso8601String();
    final end = endTime.toUtc().toIso8601String();
    final args = <String, dynamic>{
      'type': type.name,
      'startTime': start,
      'endTime': end,
    };
    return await _channel.invokeMethod('deleteRecordsByTime', args);
  }

  /// Get statistics by aggregating data.
  /// This can, for example, give you the total steps count over the last 7 days, or the average heart rate over the last month.
  ///
  /// You need the corresponding permission to get statistic for a given type. See [requestPermissions].
  ///
  /// [aggregationKeys] is a list of all the metrics you want to get statistics about. These keys can be found in
  /// their corresponding records, like [StepsRecord.aggregationKeyCountTotal].
  ///
  /// This function returns a map with the [aggregationKeys] as keys and the associated results as values. All values are
  /// doubles, look at the aggregationKey description to read more about the units.
  ///
  /// This function calls the "aggregate" function of the Health Connect SDK on Android. See:
  /// https://developer.android.com/health-and-fitness/guides/health-connect/common-workflows/aggregate-data
  /// NOTE: This does not support Bucket aggregation, only Basic aggregation.
  ///
  /// Example:
  ///  var result = await HealthConnectFactory.aggregate(
  ///     aggregationKeys: [
  ///       StepsRecord.aggregationKeyCountTotal,
  ///       ExerciseSessionRecord.aggregationKeyExerciseDurationTotal,
  ///     ],
  ///     startTime: DateTime.now().subtract(const Duration(days: 1)),
  ///     endTime: DateTime.now(),
  ///   );
  ///
  ///  // Statics over the last 24 hours:
  ///  var stepsCountTotal = result[StepsRecord.aggregationKeyCountTotal];
  ///  var exerciseDurationTotal = result[ExerciseSessionRecord.aggregationKeyExerciseDurationTotal];
  ///
  static Future<Map<String, double>> aggregate({
    required List<String> aggregationKeys,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    if (aggregationKeys.isEmpty) {
      return {};
    }
    final start = startTime.toUtc().toIso8601String();
    final end = endTime.toUtc().toIso8601String();
    final args = <String, dynamic>{
      'aggregationKeys': aggregationKeys,
      'startTime': start,
      'endTime': end,
    };

    return await _channel
        .invokeMethod('aggregate', args)
        .then((value) => Map<String, double>.from(value));
  }
}
