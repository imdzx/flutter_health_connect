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

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'percentage': percentage.value,
    };
  }

  @override
  factory OxygenSaturationRecord.fromMap(Map<String, dynamic> map) {
    return OxygenSaturationRecord(
      time: DateTime.parse(map['time']),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      percentage:
          Percentage.fromMap(Map<String, dynamic>.from(map['percentage'])),
    );
  }

  @override
  String toString() {
    return 'OxygenSaturationRecord{metadata: $metadata, time: $time, zoneOffset: $zoneOffset, percentage: $percentage}';
  }
}
