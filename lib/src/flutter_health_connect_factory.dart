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

  static Future<bool> hasPermissions(List<HealthConnectDataType> types) async {
    final mTypes = List<HealthConnectDataType>.from(types, growable: true);
    List<String> keys = mTypes.map((e) => _enumToString(e)).toList();
    return await _channel.invokeMethod('hasPermissions', {'types': keys});
  }

  static Future<bool> requestPermissions(
      List<HealthConnectDataType> types) async {
    final mTypes = List<HealthConnectDataType>.from(types, growable: true);
    List<String> keys = mTypes.map((e) => _enumToString(e)).toList();
    return await _channel.invokeMethod('requestPermissions', {'types': keys});
  }

  static Future<dynamic> getRecord({
    required DateTime startTime,
    required DateTime endTime,
    required HealthConnectDataType type,
  }) async {
    if (endTime.isBefore(startTime)) {
      return null;
    }
    final start = startTime.toIso8601String().substring(0, 10);
    final end = endTime.add(const Duration(days: 1)).toIso8601String().substring(0, 10);
    final args = <String, dynamic>{
      'type': _enumToString(type),
      'startTime': start,
      'endTime': end
    };
    var record = await _channel.invokeMethod('getRecord', args);
    return record;
  }

  static Future<bool> openHealthConnectSettings() async {
    return await _channel.invokeMethod('openHealthConnectSettings');
  }

  static String _enumToString(enumItem) => enumItem.toString().split('.').last;
}
