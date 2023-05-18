import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';

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
      'time': time.millisecondsSinceEpoch,
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
    };
  }

  @override
  factory IntermenstrualBleedingRecord.fromMap(Map<String, dynamic> map) {
    return IntermenstrualBleedingRecord(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'IntermenstrualBleedingRecord(time: $time, zoneOffset: $zoneOffset, metadata: $metadata)';
  }
}
