import 'package:flutter_health_connect/src/records/series_record.dart';
import 'package:flutter_health_connect/src/units/velocity.dart';

import 'metadata/metadata.dart';

class SpeedRecord extends SeriesRecord<SpeedSample> {
  /// Unit: meters per second
  static const String aggregationKeySpeedAvg = 'SpeedRecordSpeedAvg';

  /// Unit: meters per second
  static const String aggregationKeySpeedMin = 'SpeedRecordSpeedMin';

  /// Unit: meters per second
  static const String aggregationKeySpeedMax = 'SpeedRecordSpeedMax';

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

  @override
  Map<String, dynamic> toMap() {
    return {
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'samples': samples.map((e) => e.toMap()).toList(),
      'metadata': metadata.toMap(),
    };
  }

  @override
  factory SpeedRecord.fromMap(Map<String, dynamic> map) {
    return SpeedRecord(
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] == null
          ? null
          : Duration(hours: map['endZoneOffset'] as int),
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] == null
          ? null
          : Duration(hours: map['startZoneOffset'] as int),
      samples: (map['samples'] as List<dynamic>)
          .map((e) => SpeedSample.fromMap(e as Map<String, dynamic>))
          .toList(),
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
    );
  }

  @override
  String toString() {
    return 'SpeedRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, startTime: $startTime, startZoneOffset: $startZoneOffset, metadata: $metadata, samples: $samples}';
  }
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

  Map<String, dynamic> toMap() {
    return {
      'speed': speed.inMetersPerSecond,
      'time': time.toUtc().toIso8601String(),
    };
  }

  static SpeedSample fromMap(Map<String, dynamic> map) {
    return SpeedSample(
      speed: Velocity.fromMap(Map<String, dynamic>.from(map['speed'])),
      time: DateTime.parse(map['time']),
    );
  }

  @override
  String toString() {
    return 'SpeedSample{speed: $speed, time: $time}';
  }
}
