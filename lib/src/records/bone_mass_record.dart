import 'package:duration/duration.dart';
import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/units/mass.dart';

import 'metadata/metadata.dart';

class BoneMassRecord extends InstantaneousRecord {
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  @override
  Metadata metadata;
  Mass mass;

  BoneMassRecord({
    required this.time,
    this.zoneOffset,
    required this.mass,
    metadata,
  })  : assert(mass.inKilograms >= _minBoneMass.inKilograms &&
            mass.inKilograms <= _maxBoneMass.inKilograms),
        metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoneMassRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          mass == other.mass;

  @override
  int get hashCode => time.hashCode ^ zoneOffset.hashCode ^ mass.hashCode;

  static const Mass _minBoneMass = Mass.kilograms(0);
  static const Mass _maxBoneMass = Mass.kilograms(100);

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'mass': mass.inKilograms,
    };
  }

  @override
  factory BoneMassRecord.fromMap(Map<String, dynamic> map) {
    return BoneMassRecord(
        time: DateTime.parse(map['time']),
        zoneOffset:
            map['zoneOffset'] != null ? parseTime(map['zoneOffset']) : null,
        metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
        mass: Mass.fromMap(Map<String, dynamic>.from(map['mass'])));
  }

  @override
  String toString() {
    return 'BoneMassRecord{time: $time, zoneOffset: $zoneOffset, metadata: $metadata, mass: $mass}';
  }
}
