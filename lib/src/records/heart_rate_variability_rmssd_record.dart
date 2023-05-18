import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';

class HeartRateVariabilityRmssdRecord extends InstantaneousRecord {
  @override
  Metadata metadata;
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  double heartRateVariabilityMillis;

  HeartRateVariabilityRmssdRecord({
    required this.time,
    this.zoneOffset,
    required this.heartRateVariabilityMillis,
    metadata,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(heartRateVariabilityMillis >= _minHeartRateVariabilityMillis &&
            heartRateVariabilityMillis <= _maxHeartRateVariabilityMillis);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateVariabilityRmssdRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          heartRateVariabilityMillis == other.heartRateVariabilityMillis;

  @override
  int get hashCode =>
      time.hashCode ^ zoneOffset.hashCode ^ heartRateVariabilityMillis.hashCode;

  static const double _minHeartRateVariabilityMillis = 1.0;
  static const double _maxHeartRateVariabilityMillis = 200.0;

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.millisecondsSinceEpoch,
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'heartRateVariabilityMillis': heartRateVariabilityMillis,
    };
  }

  @override
  factory HeartRateVariabilityRmssdRecord.fromMap(Map<String, dynamic> map) {
    return HeartRateVariabilityRmssdRecord(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
      heartRateVariabilityMillis: map['heartRateVariabilityMillis'] as double,
    );
  }

  @override
  String toString() {
    return 'HeartRateVariabilityRmssdRecord{metadata: $metadata, time: $time, zoneOffset: $zoneOffset, heartRateVariabilityMillis: $heartRateVariabilityMillis}';
  }
}
