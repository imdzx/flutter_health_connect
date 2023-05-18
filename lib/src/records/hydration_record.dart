import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/volume.dart';

class HydrationRecord extends IntervalRecord {
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
  Volume volume;

  HydrationRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.startTime,
    this.startZoneOffset,
    required this.volume,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(volume.inLiters >= _minVolume.inLiters &&
            volume.inLiters <= _maxVolume.inLiters);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HydrationRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset &&
          volume == other.volume;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      volume.hashCode;

  static const Volume _minVolume = Volume.liters(0);
  static const Volume _maxVolume = Volume.liters(100);

  @override
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.millisecondsSinceEpoch,
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.millisecondsSinceEpoch,
      'endZoneOffset': endZoneOffset?.inHours,
      'volume': volume.inLiters,
    };
  }

  @override
  factory HydrationRecord.fromMap(Map<String, dynamic> map) {
    return HydrationRecord(
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
      endZoneOffset: map['endZoneOffset'] != null
          ? Duration(hours: map['endZoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      startZoneOffset: map['startZoneOffset'] != null
          ? Duration(hours: map['startZoneOffset'] as int)
          : null,
      volume: Volume.liters(map['volume'] as double),
    );
  }

  @override
  String toString() {
    return 'HydrationRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, startTime: $startTime, startZoneOffset: $startZoneOffset, volume: $volume}';
  }
}
