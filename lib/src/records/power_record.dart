import 'package:flutter_health_connect/src/records/series_record.dart';
import 'package:flutter_health_connect/src/units/power.dart';

import 'metadata/metadata.dart';

class PowerRecord extends SeriesRecord<PowerSample> {
  @override
  DateTime endTime;
  @override
  Duration? endZoneOffset;
  @override
  List<PowerSample> samples;
  @override
  DateTime startTime;
  @override
  Duration? startZoneOffset;
  @override
  Metadata metadata;

  PowerRecord({
    required this.endTime,
    this.endZoneOffset,
    required this.samples,
    required this.startTime,
    this.startZoneOffset,
    metadata,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime.");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PowerRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          samples == other.samples &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      samples.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode;
}

class PowerSample {
  Power power;
  DateTime time;

  PowerSample({
    required this.power,
    required this.time,
  }) : assert(power.inWatts >= _minPower.inWatts &&
            power.inWatts <= _maxPower.inWatts);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PowerSample && power == other.power && time == other.time;

  @override
  int get hashCode => power.hashCode ^ time.hashCode;

  static const Power _minPower = Power.watts(0);
  static const Power _maxPower = Power.watts(100000);
}
