import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/records/series_record.dart';

class HeartRateRecord extends SeriesRecord<HeartRateSample> {
  @override
  DateTime endTime;
  @override
  Duration? endZoneOffset;
  @override
  Metadata metadata;
  @override
  List<HeartRateSample> samples;
  @override
  DateTime startTime;
  @override
  Duration? startZoneOffset;

  HeartRateRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.samples,
    required this.startTime,
    this.startZoneOffset,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime.");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          metadata == other.metadata &&
          samples == other.samples &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      metadata.hashCode ^
      samples.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode;
}

class HeartRateSample {
  int beatsPerMinute;
  DateTime time;

  HeartRateSample({
    required this.beatsPerMinute,
    required this.time,
  }) : assert(beatsPerMinute >= _minBeatsPerMinute &&
            beatsPerMinute <= _maxBeatsPerMinute);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateSample &&
          beatsPerMinute == other.beatsPerMinute &&
          time == other.time;

  @override
  int get hashCode => beatsPerMinute.hashCode ^ time.hashCode;

  static const int _minBeatsPerMinute = 1;
  static const int _maxBeatsPerMinute = 300;
}
