import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/length.dart';

class DistanceRecord extends IntervalRecord {
  /// Unit: meters
  static const String aggregationKeyDistanceTotal =
      'DistanceRecordDistanceTotal';

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
  Length distance;

  DistanceRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.startTime,
    this.startZoneOffset,
    required this.distance,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(distance.inMeters >= _minDistance.inMeters &&
            distance.inMeters <= _maxDistance.inMeters);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistanceRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          distance == other.distance;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      distance.hashCode;

  static const Length _minDistance = Length.meters(0);
  static const Length _maxDistance = Length.meters(1000000);

  @override
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'distance': distance.inMeters,
    };
  }

  @override
  factory DistanceRecord.fromMap(Map<String, dynamic> map) {
    return DistanceRecord(
        startTime: DateTime.parse(map['startTime']),
        startZoneOffset: map['startZoneOffset'] != null
            ? Duration(hours: map['startZoneOffset'] as int)
            : null,
        endTime: DateTime.parse(map['endTime']),
        endZoneOffset: map['endZoneOffset'] != null
            ? Duration(hours: map['endZoneOffset'] as int)
            : null,
        distance: Length.fromMap(Map<String, dynamic>.from(map['distance'])),
        metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])));
  }

  @override
  String toString() {
    return 'DistanceRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, startTime: $startTime, startZoneOffset: $startZoneOffset, distance: $distance}';
  }
}
