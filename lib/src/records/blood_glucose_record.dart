import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/meal_type.dart';
import 'package:flutter_health_connect/src/units/blood_glucose.dart';
import 'package:flutter_health_connect/src/utils.dart';

import 'metadata/metadata.dart';

class BloodGlucoseRecord extends InstantaneousRecord {
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  @override
  Metadata metadata;
  BloodGlucose level;
  SpecimenSource specimenSource;
  RelationToMeal relationToMeal;
  MealType mealType;

  BloodGlucoseRecord(
      {required this.time,
      this.zoneOffset,
      required this.level,
      this.specimenSource = SpecimenSource.unknown,
      this.relationToMeal = RelationToMeal.unknown,
      this.mealType = MealType.unknown,
      metadata})
      : assert(level.inMillimolesPerLiter <= _maxLevel.inMillimolesPerLiter),
        assert(level.inMillimolesPerLiter >= _minLevel.inMillimolesPerLiter),
        metadata = metadata ?? Metadata.empty();

  static const BloodGlucose _maxLevel = BloodGlucose.millimolesPerLiter(50.0);
  static const BloodGlucose _minLevel = BloodGlucose.millimolesPerLiter(0);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodGlucoseRecord &&
          level == other.level &&
          specimenSource == other.specimenSource &&
          relationToMeal == other.relationToMeal &&
          mealType == other.mealType &&
          time == other.time &&
          zoneOffset == other.zoneOffset;

  @override
  int get hashCode =>
      level.hashCode ^
      specimenSource.hashCode ^
      relationToMeal.hashCode ^
      mealType.hashCode ^
      time.hashCode ^
      zoneOffset.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'level': level.inMilligramsPerDeciliter,
      'specimenSource': specimenSource.index,
      'relationToMeal': relationToMeal.index,
      'mealType': mealType.index,
    };
  }

  @override
  factory BloodGlucoseRecord.fromMap(Map<String, dynamic> map) {
    return BloodGlucoseRecord(
      time: DateTime.parse(map['time']),
      zoneOffset:
          map['zoneOffset'] != null ? parseDuration(map['zoneOffset']) : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      level: BloodGlucose.fromMap(Map<String, dynamic>.from(map['level'])),
      specimenSource: (map['specimenSource'] != null &&
              map['specimenSource'] as int < SpecimenSource.values.length)
          ? SpecimenSource.values[map['specimenSource'] as int]
          : SpecimenSource.unknown,
      relationToMeal: (map['relationToMeal'] != null &&
              map['relationToMeal'] as int < RelationToMeal.values.length)
          ? RelationToMeal.values[map['relationToMeal'] as int]
          : RelationToMeal.unknown,
      mealType: (map['mealType'] != null &&
              map['mealType'] as int < MealType.values.length)
          ? MealType.values[map['mealType'] as int]
          : MealType.unknown,
    );
  }

  @override
  String toString() {
    return 'BloodGlucoseRecord{time: $time, zoneOffset: $zoneOffset, metadata: $metadata, level: $level, specimenSource: $specimenSource, relationToMeal: $relationToMeal, mealType: $mealType}';
  }
}

enum SpecimenSource {
  unknown,
  interstitialFluid,
  capillaryBlood,
  plasma,
  serum,
  tears,
  wholeBlood;

  @override
  String toString() {
    switch (this) {
      case SpecimenSource.unknown:
        return 'unknown';
      case SpecimenSource.interstitialFluid:
        return 'interstitial_fluid';
      case SpecimenSource.capillaryBlood:
        return 'capillary_blood';
      case SpecimenSource.plasma:
        return 'plasma';
      case SpecimenSource.serum:
        return 'serum';
      case SpecimenSource.tears:
        return 'tears';
      case SpecimenSource.wholeBlood:
        return 'whole_blood';
    }
  }
}

enum RelationToMeal {
  unknown,
  general,
  fasting,
  beforeMeal,
  afterMeal;

  @override
  String toString() {
    switch (this) {
      case RelationToMeal.unknown:
        return 'unknown';
      case RelationToMeal.general:
        return 'general';
      case RelationToMeal.fasting:
        return 'fasting';
      case RelationToMeal.beforeMeal:
        return 'before_meal';
      case RelationToMeal.afterMeal:
        return 'after_meal';
    }
  }
}
