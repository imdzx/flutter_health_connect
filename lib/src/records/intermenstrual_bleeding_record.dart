import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/utils.dart';

class IntermenstrualBleedingRecord extends InstantaneousRecord {
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  @override
  Metadata metadata;

  IntermenstrualBleedingRecord({
    required this.time,
    this.zoneOffset,
    metadata,
  }) : metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntermenstrualBleedingRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          metadata == other.metadata;

  @override
  int get hashCode => time.hashCode ^ zoneOffset.hashCode ^ metadata.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
    };
  }

  @override
  factory IntermenstrualBleedingRecord.fromMap(Map<String, dynamic> map) {
    return IntermenstrualBleedingRecord(
      time: DateTime.parse(map['time']),
      zoneOffset:
          map['zoneOffset'] != null ? parseDuration(map['zoneOffset']) : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
    );
  }

  @override
  String toString() {
    return 'IntermenstrualBleedingRecord(time: $time, zoneOffset: $zoneOffset, metadata: $metadata)';
  }
}
