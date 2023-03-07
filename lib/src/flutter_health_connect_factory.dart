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

  static Future<Map<String, dynamic>> getRecord({
    required DateTime startTime,
    required DateTime endTime,
    required List<HealthConnectDataType> types,
  }) async {
    Map<String, dynamic> dataPoints = {};
    if (endTime.isBefore(startTime)) {
      return dataPoints;
    }
    final start = startTime.toLocal().toIso8601String();
    final end = endTime.toLocal().toIso8601String();
    final futures = <Future>[];
    for (var type in types) {
      final args = <String, dynamic>{
        'type': type.name,
        'startTime': start,
        'endTime': end
      };
      futures.add(_channel
          .invokeMethod('getRecord', args)
          .then((value) => dataPoints.addAll({type.name: value})));
    }
    await Future.wait(futures);
    return dataPoints;
  }

  static Future<bool> openHealthConnectSettings() async {
    return await _channel.invokeMethod('openHealthConnectSettings');
  }
}
