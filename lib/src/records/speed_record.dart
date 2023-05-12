import 'package:flutter_health_connect/src/records/series_record.dart';
import 'package:flutter_health_connect/src/units/velocity.dart';

import 'metadata/metadata.dart';

class SpeedRecord extends SeriesRecord<SpeedSample> {
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
  @override
  List<SpeedSample> samples;

  SpeedRecord({
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
      other is SpeedRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          samples == other.samples;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      samples.hashCode;
}

class SpeedSample {
  Velocity speed;
  DateTime time;

  SpeedSample({
    required this.speed,
    required this.time,
  }) : assert(speed.inMetersPerSecond >= _minSpeed.inMetersPerSecond &&
            speed.inMetersPerSecond <= _maxSpeed.inMetersPerSecond);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeedSample && speed == other.speed && time == other.time;

  @override
  int get hashCode => speed.hashCode ^ time.hashCode;

  static const Velocity _minSpeed = Velocity.metersPerSecond(0);
  static const Velocity _maxSpeed = Velocity.metersPerSecond(1000000);
}
