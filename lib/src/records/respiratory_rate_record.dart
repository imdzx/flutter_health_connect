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

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.millisecondsSinceEpoch,
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'rate': rate,
    };
  }

  @override
  factory RespiratoryRateRecord.fromMap(Map<String, dynamic> map) {
    return RespiratoryRateRecord(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
      rate: map['rate'] as double,
    );
  }

  @override
  String toString() {
    return 'RespiratoryRateRecord(time: $time, zoneOffset: $zoneOffset, metadata: $metadata, rate: $rate)';
  }
}
