import 'package:flutter_health_connect/src/records/instantaneous_record.dart';

import 'metadata/metadata.dart';

class OvulationTestRecord extends InstantaneousRecord {
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  @override
  Metadata metadata;
  OvulationTestResult result;

  OvulationTestRecord(
      {required this.time, this.zoneOffset, required this.result, metadata})
      : metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OvulationTestRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          metadata == other.metadata &&
          result == other.result;

  @override
  int get hashCode =>
      time.hashCode ^ zoneOffset.hashCode ^ metadata.hashCode ^ result.hashCode;
}

enum OvulationTestResult {
  inconclusive,
  positive,
  high,
  negative;

  @override
  String toString() {
    switch (this) {
      case OvulationTestResult.inconclusive:
        return 'inconclusive';
      case OvulationTestResult.positive:
        return 'positive';
      case OvulationTestResult.high:
        return 'high';
      case OvulationTestResult.negative:
        return 'negative';
    }
  }
}
