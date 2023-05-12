import 'package:flutter_health_connect/src/records/instantaneous_record.dart';

import 'metadata/metadata.dart';

class RespiratoryRateRecord extends InstantaneousRecord {
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  @override
  Metadata metadata;
  double rate;

  RespiratoryRateRecord({
    required this.time,
    this.zoneOffset,
    metadata,
    required this.rate,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(rate >= 0 && rate <= 1000.0);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RespiratoryRateRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          rate == other.rate &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      time.hashCode ^ zoneOffset.hashCode ^ rate.hashCode ^ metadata.hashCode;
}
