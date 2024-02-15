import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/units/mass.dart';
import 'package:flutter_health_connect/src/utils.dart';

import 'metadata/metadata.dart';

class BodyWaterMassRecord extends InstantaneousRecord {
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  @override
  Metadata metadata;
  Mass mass;

  BodyWaterMassRecord({
    required this.time,
    this.zoneOffset,
    required this.mass,
    metadata,
  })  : assert(mass.inKilograms >= _minBodyWaterMass.inKilograms &&
            mass.inKilograms <= _maxBodyWaterMass.inKilograms),
        metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyWaterMassRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          mass == other.mass;

  @override
  int get hashCode => time.hashCode ^ zoneOffset.hashCode ^ mass.hashCode;

  static const Mass _minBodyWaterMass = Mass.kilograms(0);
  static const Mass _maxBodyWaterMass = Mass.kilograms(1000);

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
  factory BodyWaterMassRecord.fromMap(Map<String, dynamic> map) {
    return BodyWaterMassRecord(
        time: DateTime.parse(map['time']),
        zoneOffset: map['zoneOffset'] != null
            ? parseTimeZoneOffset(map['zoneOffset'])
            : null,
        metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
        mass: Mass.fromMap(Map<String, dynamic>.from(map['mass'])));
  }

  @override
  String toString() {
    return 'BodyWaterMassRecord{time: $time, zoneOffset: $zoneOffset, metadata: $metadata, mass: $mass}';
  }
}
