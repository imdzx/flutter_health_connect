import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_health_connect_method_channel.dart';

abstract class FlutterHealthConnectPlatform extends PlatformInterface {
  /// Constructs a FlutterHealthConnectPlatform.
  FlutterHealthConnectPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterHealthConnectPlatform _instance = MethodChannelFlutterHealthConnect();

  /// The default instance of [FlutterHealthConnectPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterHealthConnect].
  static FlutterHealthConnectPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterHealthConnectPlatform] when
  /// they register themselves.
  static set instance(FlutterHealthConnectPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
