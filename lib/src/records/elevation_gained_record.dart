import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/length.dart';

class ElevationGainedRecord extends IntervalRecord {
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
  Length elevation;

  ElevationGainedRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.startTime,
    this.startZoneOffset,
    required this.elevation,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(elevation.inMeters >= _minElevation.inMeters &&
            elevation.inMeters <= _maxElevation.inMeters);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ElevationGainedRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          elevation == other.elevation;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      elevation.hashCode;

  static const Length _minElevation = Length.meters(-1000000);
  static const Length _maxElevation = Length.meters(1000000);

  @override
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.millisecondsSinceEpoch,
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.millisecondsSinceEpoch,
      'endZoneOffset': endZoneOffset?.inHours,
      'elevation': elevation.inMeters,
      'metadata': metadata.toMap(),
    };
  }

  @override
  factory ElevationGainedRecord.fromMap(Map<String, dynamic> map) {
    return ElevationGainedRecord(
        startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
        startZoneOffset: map['startZoneOffset'] != null
            ? Duration(hours: map['startZoneOffset'] as int)
            : null,
        endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
        endZoneOffset: map['endZoneOffset'] != null
            ? Duration(hours: map['endZoneOffset'] as int)
            : null,
        elevation: Length.meters(map['elevation'] as double),
        metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>));
  }

  @override
  String toString() {
    return 'ElevationGainedRecord(endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, startTime: $startTime, startZoneOffset: $startZoneOffset, elevation: $elevation)';
  }
}
