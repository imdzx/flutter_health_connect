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
}
