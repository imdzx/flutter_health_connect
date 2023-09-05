import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/volume.dart';

class HydrationRecord extends IntervalRecord {
  /// Unit: liters
  static const String aggregationKeyVolumeTotal = 'HydrationRecordVolumeTotal';

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
      'metadata': metadata.toMap(),
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'volume': volume.inLiters,
    };
  }

  @override
  factory HydrationRecord.fromMap(Map<String, dynamic> map) {
    return HydrationRecord(
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] != null
          ? Duration(hours: map['endZoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] != null
          ? Duration(hours: map['startZoneOffset'] as int)
          : null,
      volume: Volume.fromMap(Map<String, dynamic>.from(map['volume'])),
    );
  }

  @override
  String toString() {
    return 'HydrationRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, metadata: $metadata, startTime: $startTime, startZoneOffset: $startZoneOffset, volume: $volume}';
  }
}
