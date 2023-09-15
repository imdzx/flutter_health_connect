import 'package:flutter_health_connect/src/records/series_record.dart';
import 'package:flutter_health_connect/src/units/power.dart';

import 'metadata/metadata.dart';

class PowerRecord extends SeriesRecord<PowerSample> {
  /// Unit: watts
  static const String aggregationKeyPowerAvg = 'PowerRecordPowerAvg';

  /// Unit: watts
  static const String aggregationKeyPowerMin = 'PowerRecordPowerMin';

  /// Unit: watts
  static const String aggregationKeyPowerMax = 'PowerRecordPowerMax';

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

  @override
  Map<String, dynamic> toMap() {
    return {
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'samples': samples.map((e) => e.toMap()).toList(),
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'metadata': metadata.toMap(),
    };
  }

  @override
  factory PowerRecord.fromMap(Map<String, dynamic> map) {
    return PowerRecord(
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] == null
          ? null
          : Duration(hours: map['endZoneOffset'] as int),
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] == null
          ? null
          : Duration(hours: map['startZoneOffset'] as int),
      samples: List<PowerSample>.from(
          map['samples']?.map((x) => PowerSample.fromMap(x))),
    );
  }

  @override
  String toString() {
    return 'PowerRecord(endTime: $endTime, endZoneOffset: $endZoneOffset, samples: $samples, startTime: $startTime, startZoneOffset: $startZoneOffset, metadata: $metadata)';
  }
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

  Map<String, dynamic> toMap() {
    return {
      'power': power.inWatts,
      'time': time.toUtc().toIso8601String(),
    };
  }

  static PowerSample fromMap(Map<String, dynamic> map) {
    return PowerSample(
      power: Power.fromMap(Map<String, dynamic>.from(map['power'])),
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }
}
