import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';

class MenstruationFlowRecord extends InstantaneousRecord {
  @override
  Metadata metadata;
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  Flow flow;

  MenstruationFlowRecord(
      {required this.time, this.zoneOffset, this.flow = Flow.unknown, metadata})
      : metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenstruationFlowRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          flow == other.flow;

  @override
  int get hashCode =>
      metadata.hashCode ^ time.hashCode ^ zoneOffset.hashCode ^ flow.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'metadata': metadata.toMap(),
      'time': time.millisecondsSinceEpoch,
      'zoneOffset': zoneOffset?.inHours,
      'flow': flow.index
    };
  }

  @override
  factory MenstruationFlowRecord.fromMap(Map<String, dynamic> map) {
    return MenstruationFlowRecord(
        metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
        time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
        zoneOffset: map['zoneOffset'] != null
            ? Duration(hours: map['zoneOffset'] as int)
            : null,
        flow: (map['flow'] != null && map['flow'] as int < Flow.values.length)
            ? Flow.values[map['flow'] as int]
            : Flow.unknown);
  }
}

enum Flow {
  unknown,
  light,
  medium,
  heavy;

  static Flow fromString(String value) {
    switch (value) {
      case 'light':
        return Flow.light;
      case 'medium':
        return Flow.medium;
      case 'heavy':
        return Flow.heavy;
      default:
        return Flow.unknown;
    }
  }

  @override
  String toString() {
    switch (this) {
      case Flow.light:
        return 'light';
      case Flow.medium:
        return 'medium';
      case Flow.heavy:
        return 'heavy';
      default:
        return 'unknown';
    }
  }
}
