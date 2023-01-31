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
    final mTypes = List<HealthConnectDataType>.from(types, growable: true);
    List<String> keys = mTypes.map((e) => _enumToString(e)).toList();
    return await _channel.invokeMethod('hasPermissions', {
      'types': keys,
      'readOnly': readOnly,
    });
  }

  static Future<bool> requestPermissions(
    List<HealthConnectDataType> types, {
    bool readOnly = false,
  }) async {
    final mTypes = List<HealthConnectDataType>.from(types, growable: true);
    List<String> keys = mTypes.map((e) => _enumToString(e)).toList();
    return await _channel.invokeMethod('requestPermissions', {
      'types': keys,
      'readOnly': readOnly,
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
    final start = startTime.toIso8601String().substring(0, 10);
    final end =
        endTime.add(const Duration(days: 1)).toIso8601String().substring(0, 10);

    for (var type in types) {
      final args = <String, dynamic>{
        'type': _enumToString(type),
        'startTime': start,
        'endTime': end
      };
      var record = await _channel.invokeMethod('getRecord', args);
      dataPoints.addAll({type.name: '$record'});
    }
    return dataPoints;
  }

  static Future<bool> openHealthConnectSettings() async {
    return await _channel.invokeMethod('openHealthConnectSettings');
  }

  static String _enumToString(enumItem) => enumItem.toString().split('.').last;
}
