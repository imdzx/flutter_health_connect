import 'package:flutter_health_connect/src/records/instantaneous_record.dart';

import 'metadata/metadata.dart';

class CervicalMucusRecord extends InstantaneousRecord {
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  @override
  Metadata metadata;
  Sensation sensation;
  Appearance appearance;

  CervicalMucusRecord({
    required this.time,
    this.zoneOffset,
    this.sensation = Sensation.unknown,
    this.appearance = Appearance.unknown,
    metadata,
  }) : metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CervicalMucusRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset;

  @override
  int get hashCode => time.hashCode ^ zoneOffset.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'sensation': sensation.index,
      'appearance': appearance.index,
    };
  }

  @override
  factory CervicalMucusRecord.fromMap(Map<String, dynamic> map) {
    return CervicalMucusRecord(
      time: DateTime.parse(map['time']),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
      sensation: (map['sensation'] != null &&
              map['sensation'] as int < Sensation.values.length)
          ? Sensation.values[map['sensation'] as int]
          : Sensation.unknown,
      appearance: (map['appearance'] != null &&
              map['appearance'] as int < Appearance.values.length)
          ? Appearance.values[map['appearance'] as int]
          : Appearance.unknown,
    );
  }

  @override
  String toString() {
    return 'CervicalMucusRecord{time: $time, zoneOffset: $zoneOffset, metadata: $metadata, sensation: $sensation, appearance: $appearance}';
  }
}

enum Appearance {
  unknown,
  dry,
  sticky,
  creamy,
  watery,
  eggWhite,
  unusual;

  @override
  String toString() {
    switch (this) {
      case Appearance.unknown:
        return 'unknown';
      case Appearance.dry:
        return 'dry';
      case Appearance.sticky:
        return 'sticky';
      case Appearance.creamy:
        return 'creamy';
      case Appearance.watery:
        return 'watery';
      case Appearance.eggWhite:
        return 'egg_white';
      case Appearance.unusual:
        return 'unusual';
    }
  }
}

enum Sensation {
  unknown,
  light,
  medium,
  heavy;

  @override
  String toString() {
    switch (this) {
      case Sensation.unknown:
        return 'unknown';
      case Sensation.light:
        return 'light';
      case Sensation.medium:
        return 'medium';
      case Sensation.heavy:
        return 'heavy';
    }
  }
}
