import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/units/energy.dart';

import 'metadata/metadata.dart';

class TotalCaloriesBurnedRecord extends IntervalRecord {
  @override
  DateTime endTime;
  @override
  Duration? endZoneOffset;
  @override
  DateTime startTime;
  @override
  Duration? startZoneOffset;
  @override
  Metadata metadata;
  Energy totalCaloriesBurned;

  TotalCaloriesBurnedRecord({
    required this.endTime,
    this.endZoneOffset,
    required this.startTime,
    this.startZoneOffset,
    required this.totalCaloriesBurned,
    metadata,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(totalCaloriesBurned.inCalories >=
                _minTotalCaloriesBurned.inCalories &&
            totalCaloriesBurned.inCalories <=
                _maxTotalCaloriesBurned.inCalories);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalCaloriesBurnedRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          metadata == other.metadata &&
          totalCaloriesBurned == other.totalCaloriesBurned;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      metadata.hashCode ^
      totalCaloriesBurned.hashCode;

  static const Energy _minTotalCaloriesBurned = Energy.calories(0);
  static const Energy _maxTotalCaloriesBurned = Energy.calories(1000000);

  @override
  Map<String, dynamic> toMap() {
    return {
      'metadata': metadata.toMap(),
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'totalCaloriesBurned': totalCaloriesBurned.inCalories,
    };
  }

  @override
  factory TotalCaloriesBurnedRecord.fromMap(Map<String, dynamic> map) {
    return TotalCaloriesBurnedRecord(
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] == null
          ? null
          : Duration(hours: map['endZoneOffset'] as int),
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] == null
          ? null
          : Duration(hours: map['startZoneOffset'] as int),
      totalCaloriesBurned:
          Energy.fromMap(Map<String, dynamic>.from(map['totalCaloriesBurned'])),
    );
  } // f

  @override
  String toString() {
    return 'TotalCaloriesBurnedRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, startTime: $startTime, startZoneOffset: $startZoneOffset, metadata: $metadata, totalCaloriesBurned: $totalCaloriesBurned}';
  }
}
