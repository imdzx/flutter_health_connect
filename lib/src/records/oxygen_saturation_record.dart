import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/percentage.dart';

class OxygenSaturationRecord extends InstantaneousRecord {
  @override
  Metadata metadata;
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  Percentage percentage;

  OxygenSaturationRecord(
      {required this.time, this.zoneOffset, required this.percentage, metadata})
      : metadata = metadata ?? Metadata.empty(),
        assert(percentage.value >= 0 && percentage.value <= 100);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OxygenSaturationRecord &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          percentage == other.percentage;

  @override
  int get hashCode =>
      metadata.hashCode ^
      time.hashCode ^
      zoneOffset.hashCode ^
      percentage.hashCode;
}
