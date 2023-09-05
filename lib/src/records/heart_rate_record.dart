import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/records/series_record.dart';

class HeartRateRecord extends SeriesRecord<HeartRateSample> {
  /// Unit: Beats per minute (BPM)
  static const String aggregationKeyBpmAvg = 'HeartRateRecordBpmAvg';

  /// Unit: Beats per minute (BPM)
  static const String aggregationKeyBpmMin = 'HeartRateRecordBpmMin';

  /// Unit: Beats per minute (BPM)
  static const String aggregationKeyBpmMax = 'HeartRateRecordBpmMax';

  /// Unit: No unit
  static const String aggregationKeyMeasurementsCount =
      'HeartRateRecordMeasurementsCount';

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

  @override
  Map<String, dynamic> toMap() {
    return {
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'samples': samples.map((e) => e.toMap()).toList(),
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
    };
  }

  @override
  factory HeartRateRecord.fromMap(Map<String, dynamic> map) {
    return HeartRateRecord(
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] == null
          ? null
          : Duration(hours: map['endZoneOffset'] as int),
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      samples: (map['samples'] as List<dynamic>)
          .map((e) => HeartRateSample.fromMap(e as Map<String, dynamic>))
          .toList(),
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] == null
          ? null
          : Duration(hours: map['startZoneOffset'] as int),
    );
  }

  @override
  String toString() {
    return 'HeartRateRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, samples: $samples, startTime: $startTime, startZoneOffset: $startZoneOffset}';
  }
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

  Map<String, dynamic> toMap() {
    return {
      'beatsPerMinute': beatsPerMinute,
      'time': time.toUtc().toIso8601String(),
    };
  }

  factory HeartRateSample.fromMap(Map<String, dynamic> map) {
    return HeartRateSample(
      beatsPerMinute: map['beatsPerMinute'] as int,
      time: DateTime.parse(map['time']),
    );
  }
}
