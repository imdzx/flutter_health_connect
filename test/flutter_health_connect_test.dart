import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:flutter_health_connect/flutter_health_connect_platform_interface.dart';
import 'package:flutter_health_connect/flutter_health_connect_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterHealthConnectPlatform
    with MockPlatformInterfaceMixin
    implements FlutterHealthConnectPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterHealthConnectPlatform initialPlatform = FlutterHealthConnectPlatform.instance;

  test('$MethodChannelFlutterHealthConnect is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterHealthConnect>());
  });

  test('getPlatformVersion', () async {
    FlutterHealthConnect flutterHealthConnectPlugin = FlutterHealthConnect();
    MockFlutterHealthConnectPlatform fakePlatform = MockFlutterHealthConnectPlatform();
    FlutterHealthConnectPlatform.instance = fakePlatform;

    expect(await flutterHealthConnectPlugin.getPlatformVersion(), '42');
  });
}
