part of flutter_health_connect;

enum ErrorCode {
  /// Likely the Health Connect app is not installed, you should prompt your users to install it.
  unableToOpenHealthConnectApp,

  /// The API is not currently available. That could be because the Health Connect app is not installed or outdated, or because the
  /// device is too old to support Health Connect.
  notAvailable,

  /// You need to request permissions for for each of the types you want to read/write.
  missingPermissions,

  /// Something unexpected happened.
  unknown,
}

class FlutterHealthConnectException implements Exception {
  final ErrorCode code;
  final String? message;
  final dynamic details;
  final StackTrace? stackTrace;

  const FlutterHealthConnectException({
    required this.code,
    this.message = '',
    this.details,
    this.stackTrace,
  });

  @override
  String toString() => 'FlutterHealthConnectException: Code = $code'
      '\nmessage = $message'
      '${details != null ? '\ndetails = $details' : ''}'
      '${stackTrace != null ? '\nstackTrace = $stackTrace' : ''}';
}
