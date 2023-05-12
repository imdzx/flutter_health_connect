import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/units/mass.dart';

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
}
