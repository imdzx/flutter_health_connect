import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/units/mass.dart';

import 'metadata/metadata.dart';

class WeightRecord extends InstantaneousRecord {
  /// Unit: kilograms
  static const String aggregationKeyWeightAvg = 'WeightRecordWeightAvg';

  /// Unit: kilograms
  static const String aggregationKeyWeightMin = 'WeightRecordWeightMin';

  /// Unit: kilograms
  static const String aggregationKeyWeightMax = 'WeightRecordWeightMax';

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

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'weight': weight.inKilograms,
    };
  }

  @override
  factory WeightRecord.fromMap(Map<String, dynamic> map) {
    return WeightRecord(
      time: DateTime.parse(map['time']),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      weight: Mass.fromMap(Map<String, dynamic>.from(map['weight'])),
    );
  }

  @override
  String toString() {
    return 'WeightRecord{time: $time, zoneOffset: $zoneOffset, weight: $weight, metadata: $metadata}';
  }
}
