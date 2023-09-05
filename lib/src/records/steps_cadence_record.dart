import 'package:flutter_health_connect/src/records/series_record.dart';

import 'metadata/metadata.dart';

class StepsCadenceRecord extends SeriesRecord<StepsCadenceSample> {
  /// Unit: No unit
  static const String aggregationKeyRateAvg = 'StepsCadenceRecordRateAvg';

  /// Unit: No unit
  static const String aggregationKeyRateMin = 'StepsCadenceRecordRateMin';

  /// Unit: No unit
  static const String aggregationKeyRateMax = 'StepsCadenceRecordRateMax';

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
  factory StepsCadenceRecord.fromMap(Map<String, dynamic> map) {
    return StepsCadenceRecord(
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] == null
          ? null
          : Duration(hours: map['endZoneOffset'] as int),
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] == null
          ? null
          : Duration(hours: map['startZoneOffset'] as int),
      samples: (map['samples'] as List)
          .map((e) => StepsCadenceSample.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'StepsCadenceRecord(endTime: $endTime, endZoneOffset: $endZoneOffset, startTime: $startTime, startZoneOffset: $startZoneOffset, samples: $samples, metadata: $metadata)';
  }
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

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'time': time.toUtc().toIso8601String(),
    };
  }

  static StepsCadenceSample fromMap(Map<String, dynamic> map) {
    return StepsCadenceSample(
      rate: map['rate'] as double,
      time: DateTime.parse(map['time']),
    );
  }

  @override
  String toString() => 'StepsCadenceSample(rate: $rate, time: $time)';
}
