import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/units/mass.dart';

import 'metadata/metadata.dart';

class WeightRecord extends InstantaneousRecord {
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  Mass weight;
  @override
  Metadata metadata;

  WeightRecord({
    required this.time,
    this.zoneOffset,
    required this.weight,
    metadata,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(weight.inKilograms >= _minWeight.inKilograms &&
            weight.inKilograms <= _maxWeight.inKilograms);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          weight == other.weight &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      time.hashCode ^ zoneOffset.hashCode ^ weight.hashCode ^ metadata.hashCode;

  static const Mass _minWeight = Mass.kilograms(0);
  static const Mass _maxWeight = Mass.kilograms(1000);
}
