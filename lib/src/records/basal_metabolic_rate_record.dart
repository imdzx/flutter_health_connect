import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/power.dart';

import 'instantaneous_record.dart';

class BasalMetabolicRateRecord extends InstantaneousRecord {
  /// Unit: kilocalories
  static const String aggregationKeyBasalCaloriesTotal =
      'BasalMetabolicRateRecordBasalCaloriesTotal';

  final Power basalMetabolicRate;
  @override
  Metadata metadata;
  @override
  DateTime time;
  @override
  Duration? zoneOffset;

  BasalMetabolicRateRecord(
      {required this.time,
      this.zoneOffset,
      metadata,
      required this.basalMetabolicRate})
      : assert(basalMetabolicRate.value <= _maxBasalMetabolicRate.value),
        assert(basalMetabolicRate.value >= _minBasalMetabolicRate.value),
        metadata = metadata ?? Metadata.empty();

  static const Power _maxBasalMetabolicRate = Power.kilocaloriesPerDay(10000);
  static const Power _minBasalMetabolicRate = Power.kilocaloriesPerDay(0);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasalMetabolicRateRecord &&
          basalMetabolicRate == other.basalMetabolicRate &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffset == other.zoneOffset;

  @override
  int get hashCode =>
      basalMetabolicRate.hashCode ^
      metadata.hashCode ^
      time.hashCode ^
      zoneOffset.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'basalMetabolicRate': basalMetabolicRate.inKilocaloriesPerDay,
    };
  }

  @override
  factory BasalMetabolicRateRecord.fromMap(Map<String, dynamic> map) {
    return BasalMetabolicRateRecord(
      time: DateTime.parse(map['time']),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      basalMetabolicRate:
          Power.fromMap(Map<String, dynamic>.from(map['basalMetabolicRate'])),
    );
  }

  @override
  String toString() {
    return 'BasalMetabolicRateRecord{basalMetabolicRate: $basalMetabolicRate, metadata: $metadata, time: $time, zoneOffset: $zoneOffset}';
  }
}
