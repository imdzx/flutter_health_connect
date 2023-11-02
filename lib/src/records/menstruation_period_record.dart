import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/utils.dart';

class MenstruationPeriodRecord extends IntervalRecord {
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

  MenstruationPeriodRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.startTime,
    this.startZoneOffset,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(endTime.difference(startTime) <= maxDuration,
            "Period must not exceed 31 days.");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstruationPeriodRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode;

  static const maxDuration = Duration(days: 31);

  @override
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'metadata': metadata.toMap(),
    };
  }

  @override
  factory MenstruationPeriodRecord.fromMap(Map<String, dynamic> map) {
    return MenstruationPeriodRecord(
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      endZoneOffset: map['endZoneOffset'] != null
          ? parseDuration(map['endZoneOffset'])
          : null,
      metadata: Metadata.fromMap(map['metadata']),
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      startZoneOffset: map['startZoneOffset'] != null
          ? parseDuration(map['startZoneOffset'])
          : null,
    );
  }
}
