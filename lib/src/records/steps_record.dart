import 'package:flutter_health_connect/src/records/interval_record.dart';

import 'metadata/metadata.dart';

class StepsRecord extends IntervalRecord {
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
  int steps;

  StepsRecord({
    required this.endTime,
    this.endZoneOffset,
    required this.startTime,
    this.startZoneOffset,
    metadata,
    required this.steps,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(steps >= _minSteps && steps <= _maxSteps);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepsRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          metadata == other.metadata &&
          steps == other.steps;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      metadata.hashCode ^
      steps.hashCode;

  static const int _minSteps = 1;
  static const int _maxSteps = 1000000;
}
