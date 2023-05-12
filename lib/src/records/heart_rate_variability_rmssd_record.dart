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
}
