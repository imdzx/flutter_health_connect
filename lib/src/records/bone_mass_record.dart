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
}
