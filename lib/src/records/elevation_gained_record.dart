import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/length.dart';

class ElevationGainedRecord extends IntervalRecord {
  /// Unit: meters
  static const String aggregationKeyElevationGainedTotal =
      'ElevationGainedRecordElevationGainedTotal';

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
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'elevation': elevation.inMeters,
      'metadata': metadata.toMap(),
    };
  }

  @override
  factory ElevationGainedRecord.fromMap(Map<String, dynamic> map) {
    return ElevationGainedRecord(
        startTime: DateTime.parse(map['startTime']),
        startZoneOffset: map['startZoneOffset'] != null
            ? Duration(hours: map['startZoneOffset'] as int)
            : null,
        endTime: DateTime.parse(map['endTime']),
        endZoneOffset: map['endZoneOffset'] != null
            ? Duration(hours: map['endZoneOffset'] as int)
            : null,
        elevation: Length.fromMap(Map<String, dynamic>.from(map['elevation'])),
        metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])));
  }

  @override
  String toString() {
    return 'ElevationGainedRecord(endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, startTime: $startTime, startZoneOffset: $startZoneOffset, elevation: $elevation)';
  }
}
