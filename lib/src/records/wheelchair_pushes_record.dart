import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';

class WheelchairPushesRecord extends IntervalRecord {
  /// Unit: No unit
  static const String aggregationKeyCountTotal =
      'WheelchairPushesRecordCountTotal';

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
  int count;

  WheelchairPushesRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.startTime,
    this.startZoneOffset,
    required this.count,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(count >= _minCount && count <= _maxCount);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WheelchairPushesRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          count == other.count;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      count.hashCode;

  static const int _minCount = 1;
  static const int _maxCount = 1000000;

  @override
  Map<String, dynamic> toMap() {
    return {
      'metadata': metadata.toMap(),
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'count': count,
    };
  }

  @override
  factory WheelchairPushesRecord.fromMap(Map<String, dynamic> map) {
    return WheelchairPushesRecord(
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] != null
          ? Duration(hours: map['startZoneOffset'] as int)
          : null,
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] != null
          ? Duration(hours: map['endZoneOffset'] as int)
          : null,
      count: map['count'] as int,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
    );
  }

  @override
  String toString() {
    return 'WheelchairPushesRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, startTime: $startTime, startZoneOffset: $startZoneOffset, count: $count}';
  }
}
