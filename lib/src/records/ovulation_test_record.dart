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

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'result': result.index,
    };
  }

  @override
  factory OvulationTestRecord.fromMap(Map<String, dynamic> map) {
    return OvulationTestRecord(
      time: DateTime.parse(map['time']),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
      result: (map['result'] != null &&
              map['result'] as int < OvulationTestResult.values.length)
          ? OvulationTestResult.values[map['result'] as int]
          : OvulationTestResult.inconclusive,
    );
  }

  @override
  String toString() {
    return 'OvulationTestRecord{time: $time, zoneOffset: $zoneOffset, metadata: $metadata, result: $result}';
  }
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
