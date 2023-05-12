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
}
