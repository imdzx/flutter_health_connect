import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/records/series_record.dart';

class CyclingPedalingCadenceRecord extends SeriesRecord<Sample> {
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
  @override
  List<Sample> samples;

  CyclingPedalingCadenceRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.startTime,
    this.startZoneOffset,
    required this.samples,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime.");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CyclingPedalingCadenceRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          samples == other.samples;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      samples.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'endTime': endTime.millisecondsSinceEpoch,
      'endZoneOffset': endZoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'startTime': startTime.millisecondsSinceEpoch,
      'startZoneOffset': startZoneOffset?.inHours,
      'samples': samples.map((e) => e.toMap()).toList(),
    };
  }

  @override
  factory CyclingPedalingCadenceRecord.fromMap(Map<String, dynamic> map) {
    return CyclingPedalingCadenceRecord(
        startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
        startZoneOffset: map['startZoneOffset'] != null
            ? Duration(hours: map['startZoneOffset'] as int)
            : null,
        endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
        endZoneOffset: map['endZoneOffset'] != null
            ? Duration(hours: map['endZoneOffset'] as int)
            : null,
        samples:
            List<Sample>.from(map['samples']?.map((e) => Sample.fromMap(e))),
        metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>));
  }

  @override
  String toString() {
    return 'CyclingPedalingCadenceRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, startTime: $startTime, startZoneOffset: $startZoneOffset, samples: $samples}';
  }
}

class Sample {
  double revolutionsPerMinute;

  Sample({
    required this.revolutionsPerMinute,
  }) : assert(revolutionsPerMinute >= _minRevolutionsPerMinute &&
            revolutionsPerMinute <= _maxRevolutionsPerMinute);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sample && revolutionsPerMinute == other.revolutionsPerMinute;

  @override
  int get hashCode => revolutionsPerMinute.hashCode;

  static const double _minRevolutionsPerMinute = 0;
  static const double _maxRevolutionsPerMinute = 10000.0;

  Map<String, dynamic> toMap() {
    return {
      'revolutionsPerMinute': revolutionsPerMinute,
    };
  }

  static Sample fromMap(Map<String, dynamic> map) {
    return Sample(
      revolutionsPerMinute: map['revolutionsPerMinute'] as double,
    );
  }

  @override
  String toString() {
    return 'Sample{revolutionsPerMinute: $revolutionsPerMinute}';
  }
}
