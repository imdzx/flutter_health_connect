import 'package:flutter_health_connect/src/records/interval_record.dart';

import 'metadata/metadata.dart';

class SleepSessionRecord extends IntervalRecord {
  /// Unit: seconds
  static const String aggregationKeySleepDurationTotal =
      'SleepSessionRecordSleepDurationTotal';

  @override
  DateTime startTime;
  @override
  DateTime endTime;
  @override
  Duration? endZoneOffset;
  @override
  Duration? startZoneOffset;
  @override
  Metadata metadata;
  String? title;
  String? notes;
  List<SleepStage> stages;

  SleepSessionRecord({
    required this.startTime,
    required this.endTime,
    this.endZoneOffset,
    this.startZoneOffset,
    metadata,
    this.title,
    this.notes,
    this.stages = const [],
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime)) {
    if (stages.isNotEmpty) {
      List<SleepStage> sortedStages = stages
        ..sort((a, b) => a.startTime.compareTo(b.startTime));
      for (int i = 0; i < sortedStages.length - 1; i++) {
        assert(sortedStages[i].endTime.isAfter(sortedStages[i + 1].startTime));
      }
      assert(!sortedStages.first.startTime.isBefore(startTime));
      assert(!sortedStages.last.endTime.isAfter(endTime));
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepSessionRecord &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          startZoneOffset == other.startZoneOffset &&
          metadata == other.metadata &&
          title == other.title &&
          notes == other.notes &&
          stages == other.stages;

  @override
  int get hashCode =>
      startTime.hashCode ^
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      startZoneOffset.hashCode ^
      metadata.hashCode ^
      title.hashCode ^
      notes.hashCode ^
      stages.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'title': title,
      'notes': notes,
      'stages': stages.map((e) => e.toMap()).toList(),
      'metadata': metadata.toMap(),
    };
  }

  @override
  factory SleepSessionRecord.fromMap(Map<String, dynamic> map) {
    return SleepSessionRecord(
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] != null
          ? Duration(hours: map['startZoneOffset'] as int)
          : null,
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] != null
          ? Duration(hours: map['endZoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      title: map['title'] as String?,
      notes: map['notes'] as String?,
      stages:
          (map['stages'] as List).map((e) => SleepStage.fromMap(e)).toList(),
    );
  }

  @override
  String toString() {
    return 'SleepSessionRecord{startTime: $startTime, endTime: $endTime, endZoneOffset: $endZoneOffset, startZoneOffset: $startZoneOffset, metadata: $metadata, title: $title, notes: $notes, stages: $stages}';
  }
}

class SleepStage {
  DateTime startTime;
  DateTime endTime;
  SleepStageType type;

  SleepStage({
    required this.startTime,
    required this.endTime,
    required this.type,
  }) : assert(startTime.isBefore(endTime));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepStage &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          type == other.type;

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode ^ type.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toUtc().toIso8601String(),
      'endTime': endTime.toUtc().toIso8601String(),
      'type': type.index,
    };
  }

  static SleepStage fromMap(Map<String, dynamic> map) {
    return SleepStage(
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      type: (map['type'] != null &&
              map['type'] as int < SleepStageType.values.length)
          ? SleepStageType.values[map['type'] as int]
          : SleepStageType.unknown,
    );
  }

  @override
  String toString() {
    return 'SleepStage{startTime: $startTime, endTime: $endTime, type: $type}';
  }
}

enum SleepStageType {
  unknown,
  awake,
  sleeping,
  outOfBed,
  light,
  deep,
  rem,
  awakeInBed;

  SleepStageType fromString(String value) {
    switch (value) {
      case 'unknown':
        return SleepStageType.unknown;
      case 'awake':
        return SleepStageType.awake;
      case 'sleeping':
        return SleepStageType.sleeping;
      case 'out_of_bed':
        return SleepStageType.outOfBed;
      case 'light':
        return SleepStageType.light;
      case 'deep':
        return SleepStageType.deep;
      case 'rem':
        return SleepStageType.rem;
      case 'awake_in_bed':
        return SleepStageType.awakeInBed;
      default:
        throw ArgumentError.value(value, 'value', 'Invalid value.');
    }
  }

  @override
  String toString() {
    switch (this) {
      case SleepStageType.unknown:
        return 'unknown';
      case SleepStageType.awake:
        return 'awake';
      case SleepStageType.sleeping:
        return 'sleeping';
      case SleepStageType.outOfBed:
        return 'out_of_bed';
      case SleepStageType.light:
        return 'light';
      case SleepStageType.deep:
        return 'deep';
      case SleepStageType.rem:
        return 'rem';
      case SleepStageType.awakeInBed:
        return 'awake_in_bed';
    }
  }
}
