import 'package:flutter_health_connect/src/records/metadata/device_types.dart';

class Device {
  String? manufacturer;
  String? model;
  DeviceTypes? type;

  Device({
    this.manufacturer,
    this.model,
    this.type = DeviceTypes.unknown,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Device &&
          manufacturer == other.manufacturer &&
          model == other.model &&
          type == other.type;

  @override
  int get hashCode => manufacturer.hashCode ^ model.hashCode ^ type.hashCode;
}
