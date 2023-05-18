import 'package:flutter_health_connect/src/records/instantaneous_record.dart';

import 'metadata/metadata.dart';

class Vo2MaxRecord extends InstantaneousRecord {
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  double vo2MillilitersPerMinuteKilogram;
  Vo2MaxMeasurementMethod measurementMethod;
  @override
  Metadata metadata;

  Vo2MaxRecord({
    required this.time,
    this.zoneOffset,
    required this.vo2MillilitersPerMinuteKilogram,
    this.measurementMethod = Vo2MaxMeasurementMethod.other,
    metadata,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(vo2MillilitersPerMinuteKilogram >= 0 &&
            vo2MillilitersPerMinuteKilogram <= 100);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vo2MaxRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          vo2MillilitersPerMinuteKilogram ==
              other.vo2MillilitersPerMinuteKilogram &&
          measurementMethod == other.measurementMethod &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      time.hashCode ^
      zoneOffset.hashCode ^
      vo2MillilitersPerMinuteKilogram.hashCode ^
      measurementMethod.hashCode ^
      metadata.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.millisecondsSinceEpoch,
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'vo2MillilitersPerMinuteKilogram': vo2MillilitersPerMinuteKilogram,
      'measurementMethod': measurementMethod.index,
    };
  }

  @override
  factory Vo2MaxRecord.fromMap(Map<String, dynamic> map) {
    return Vo2MaxRecord(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
      vo2MillilitersPerMinuteKilogram:
          map['vo2MillilitersPerMinuteKilogram'] as double,
      measurementMethod: (map['measurementMethod'] != null &&
              map['measurementMethod'] as int <
                  Vo2MaxMeasurementMethod.values.length)
          ? Vo2MaxMeasurementMethod.values[map['measurementMethod'] as int]
          : Vo2MaxMeasurementMethod.other,
    );
  }
}

enum Vo2MaxMeasurementMethod {
  other,
  metabolicCart,
  heartRateRatio,
  cooperTest,
  multistageFitnessTest,
  rockportFitnessTest;

  @override
  String toString() {
    switch (this) {
      case Vo2MaxMeasurementMethod.other:
        return 'other';
      case Vo2MaxMeasurementMethod.metabolicCart:
        return 'metabolic_cart';
      case Vo2MaxMeasurementMethod.heartRateRatio:
        return 'heart_rate_ratio';
      case Vo2MaxMeasurementMethod.cooperTest:
        return 'cooper_test';
      case Vo2MaxMeasurementMethod.multistageFitnessTest:
        return 'multistage_fitness_test';
      case Vo2MaxMeasurementMethod.rockportFitnessTest:
        return 'rockport_fitness_test';
    }
  }

  static Vo2MaxMeasurementMethod fromString(String string) {
    switch (string) {
      case 'other':
        return Vo2MaxMeasurementMethod.other;
      case 'metabolic_cart':
        return Vo2MaxMeasurementMethod.metabolicCart;
      case 'heart_rate_ratio':
        return Vo2MaxMeasurementMethod.heartRateRatio;
      case 'cooper_test':
        return Vo2MaxMeasurementMethod.cooperTest;
      case 'multistage_fitness_test':
        return Vo2MaxMeasurementMethod.multistageFitnessTest;
      case 'rockport_fitness_test':
        return Vo2MaxMeasurementMethod.rockportFitnessTest;
      default:
        throw ArgumentError.value(string, 'string', 'Invalid string');
    }
  }
}
