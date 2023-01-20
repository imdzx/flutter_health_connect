
import 'flutter_health_connect_platform_interface.dart';

class FlutterHealthConnect {
  Future<String?> getPlatformVersion() {
    return FlutterHealthConnectPlatform.instance.getPlatformVersion();
  }
}
