import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';

class FloorsClimbedRecord extends IntervalRecord {
  /// Unit: No unit
  static const String aggregationKeyFloorsClimbedTotal =
      'FloorsClimbedRecordFloorsClimbedTotal';

  @override
  DateTime endTime;
  @override
  Duration? endZoneOffset;
  @override
  Metadata metadata;
  @override
  DateTime startTime;
  @override
  Duration? startZoneOffset;
  double floors;

  FloorsClimbedRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.startTime,
    this.startZoneOffset,
    required this.floors,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(floors >= _minFloors && floors <= _maxFloors);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FloorsClimbedRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          floors == other.floors;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      floors.hashCode;

  static const double _minFloors = 0;
  static const double _maxFloors = 1000000.0;

  @override
  Map<String, dynamic> toMap() {
    return {
      'metadata': metadata.toMap(),
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'floors': floors,
    };
  }

  @override
  factory FloorsClimbedRecord.fromMap(Map<String, dynamic> map) {
    return FloorsClimbedRecord(
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] == null
          ? null
          : Duration(hours: map['endZoneOffset'] as int),
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] == null
          ? null
          : Duration(hours: map['startZoneOffset'] as int),
      floors: map['floors'] as double,
    );
  }

  @override
  String toString() {
    return 'FloorsClimbedRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, startTime: $startTime, startZoneOffset: $startZoneOffset, floors: $floors}';
  }
}
