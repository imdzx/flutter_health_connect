import 'package:flutter_health_connect/src/records/series_record.dart';

import 'metadata/metadata.dart';

class StepsCadenceRecord extends SeriesRecord<StepsCadenceSample> {
  @override
  DateTime endTime;
  @override
  Duration? endZoneOffset;
  @override
  DateTime startTime;
  @override
  Duration? startZoneOffset;
  @override
  List<StepsCadenceSample> samples;
  @override
  Metadata metadata;

  StepsCadenceRecord({
    required this.endTime,
    this.endZoneOffset,
    required this.startTime,
    this.startZoneOffset,
    required this.samples,
    metadata,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime.");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepsCadenceRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          samples == other.samples &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      samples.hashCode ^
      metadata.hashCode;
}

class StepsCadenceSample {
  double rate;
  DateTime time;

  StepsCadenceSample({
    required this.rate,
    required this.time,
  }) : assert(rate >= _minStepsPerMinute && rate <= _maxStepsPerMinute);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepsCadenceSample && rate == other.rate && time == other.time;

  @override
  int get hashCode => rate.hashCode ^ time.hashCode;

  static const _minStepsPerMinute = 0.0;
  static const _maxStepsPerMinute = 10000.0;
}
