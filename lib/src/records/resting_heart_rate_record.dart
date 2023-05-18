import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';

class RestingHeartRateRecord extends InstantaneousRecord {
  @override
  Metadata metadata;
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  int beatsPerMinute;

  RestingHeartRateRecord({
    required this.time,
    this.zoneOffset,
    required this.beatsPerMinute,
    metadata,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(beatsPerMinute >= 0 && beatsPerMinute <= 300);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestingHeartRateRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          beatsPerMinute == other.beatsPerMinute;

  @override
  int get hashCode =>
      time.hashCode ^ zoneOffset.hashCode ^ beatsPerMinute.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.millisecondsSinceEpoch,
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'beatsPerMinute': beatsPerMinute,
    };
  }

  @override
  factory RestingHeartRateRecord.fromMap(Map<String, dynamic> map) {
    return RestingHeartRateRecord(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
      beatsPerMinute: map['beatsPerMinute'] as int,
    );
  }

  @override
  String toString() {
    return 'RestingHeartRateRecord(time: $time, zoneOffset: $zoneOffset, metadata: $metadata, beatsPerMinute: $beatsPerMinute)';
  }
}
