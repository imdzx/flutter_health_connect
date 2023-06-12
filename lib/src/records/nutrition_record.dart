import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/energy.dart';
import 'package:flutter_health_connect/src/units/mass.dart';

import 'meal_type.dart';

class NutritionRecord extends IntervalRecord {
  @override
  DateTime endTime;
  @override
  Duration? endZoneOffset;
  @override
  DateTime startTime;
  @override
  Duration? startZoneOffset;
  @override
  Metadata metadata;
  Mass? biotin;
  Mass? caffeine;
  Mass? calcium;
  Energy? energy;
  Energy? energyFromFat;
  Mass? chloride;
  Mass? cholesterol;
  Mass? chromium;
  Mass? copper;
  Mass? dietaryFiber;
  Mass? folate;
  Mass? folicAcid;
  Mass? iodine;
  Mass? iron;
  Mass? magnesium;
  Mass? manganese;
  Mass? molybdenum;
  Mass? monounsaturatedFat;
  Mass? niacin;
  Mass? pantothenicAcid;
  Mass? phosphorus;
  Mass? polyunsaturatedFat;
  Mass? potassium;
  Mass? protein;
  Mass? riboflavin;
  Mass? saturatedFat;
  Mass? selenium;
  Mass? sodium;
  Mass? sugar;
  Mass? thiamin;
  Mass? totalCarbohydrates;
  Mass? totalFat;
  Mass? transFat;
  Mass? unsaturatedFat;
  Mass? vitaminA;
  Mass? vitaminB12;
  Mass? vitaminB6;
  Mass? vitaminC;
  Mass? vitaminD;
  Mass? vitaminE;
  Mass? vitaminK;
  Mass? zinc;
  String? name;
  MealType mealType;

  NutritionRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.startTime,
    this.startZoneOffset,
    this.biotin,
    this.caffeine,
    this.calcium,
    this.energy,
    this.energyFromFat,
    this.chloride,
    this.cholesterol,
    this.chromium,
    this.copper,
    this.dietaryFiber,
    this.folate,
    this.folicAcid,
    this.iodine,
    this.iron,
    this.magnesium,
    this.manganese,
    this.molybdenum,
    this.monounsaturatedFat,
    this.niacin,
    this.pantothenicAcid,
    this.phosphorus,
    this.polyunsaturatedFat,
    this.potassium,
    this.protein,
    this.riboflavin,
    this.saturatedFat,
    this.selenium,
    this.sodium,
    this.sugar,
    this.thiamin,
    this.totalCarbohydrates,
    this.totalFat,
    this.transFat,
    this.unsaturatedFat,
    this.vitaminA,
    this.vitaminB12,
    this.vitaminB6,
    this.vitaminC,
    this.vitaminD,
    this.vitaminE,
    this.vitaminK,
    this.zinc,
    this.name,
    this.mealType = MealType.unknown,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(
            biotin == null ||
                biotin.inGrams >= _minMass.inGrams &&
                    biotin.inGrams <= _maxMass100.inGrams,
            "biotin"),
        assert(
            caffeine == null ||
                caffeine.inGrams >= _minMass.inGrams &&
                    caffeine.inGrams <= _maxMass100.inGrams,
            "caffeine"),
        assert(
            calcium == null ||
                calcium.inGrams >= _minMass.inGrams &&
                    calcium.inGrams <= _maxMass100.inGrams,
            "calcium"),
        assert(
            energy == null ||
                energy.inCalories >= _minEnergy.inCalories &&
                    energy.inCalories <= _maxEnergy.inCalories,
            "energy"),
        assert(
            energyFromFat == null ||
                energyFromFat.inCalories >= _minEnergy.inCalories &&
                    energyFromFat.inCalories <= _maxEnergy.inCalories,
            "energyFromFat"),
        assert(
            chloride == null ||
                chloride.inGrams >= _minMass.inGrams &&
                    chloride.inGrams <= _maxMass100.inGrams,
            "chloride"),
        assert(
            cholesterol == null ||
                cholesterol.inGrams >= _minMass.inGrams &&
                    cholesterol.inGrams <= _maxMass100.inGrams,
            "cholesterol"),
        assert(
            chromium == null ||
                chromium.inGrams >= _minMass.inGrams &&
                    chromium.inGrams <= _maxMass100.inGrams,
            "chromium"),
        assert(
            copper == null ||
                copper.inGrams >= _minMass.inGrams &&
                    copper.inGrams <= _maxMass100.inGrams,
            "copper"),
        assert(
            dietaryFiber == null ||
                dietaryFiber.inGrams >= _minMass.inGrams &&
                    dietaryFiber.inGrams <= _maxMass100K.inGrams,
            "dietaryFiber"),
        assert(
            folate == null ||
                folate.inGrams >= _minMass.inGrams &&
                    folate.inGrams <= _maxMass100.inGrams,
            "folate"),
        assert(
            folicAcid == null ||
                folicAcid.inGrams >= _minMass.inGrams &&
                    folicAcid.inGrams <= _maxMass100.inGrams,
            "folicAcid"),
        assert(
            iodine == null ||
                iodine.inGrams >= _minMass.inGrams &&
                    iodine.inGrams <= _maxMass100.inGrams,
            "iodine"),
        assert(
            iron == null ||
                iron.inGrams >= _minMass.inGrams &&
                    iron.inGrams <= _maxMass100.inGrams,
            "iron"),
        assert(
            magnesium == null ||
                magnesium.inGrams >= _minMass.inGrams &&
                    magnesium.inGrams <= _maxMass100.inGrams,
            "magnesium"),
        assert(
            manganese == null ||
                manganese.inGrams >= _minMass.inGrams &&
                    manganese.inGrams <= _maxMass100.inGrams,
            "manganese"),
        assert(
            molybdenum == null ||
                molybdenum.inGrams >= _minMass.inGrams &&
                    molybdenum.inGrams <= _maxMass100.inGrams,
            "molybdenum"),
        assert(
            monounsaturatedFat == null ||
                monounsaturatedFat.inGrams >= _minMass.inGrams &&
                    monounsaturatedFat.inGrams <= _maxMass100.inGrams,
            "monounsaturatedFat"),
        assert(
            niacin == null ||
                niacin.inGrams >= _minMass.inGrams &&
                    niacin.inGrams <= _maxMass100.inGrams,
            "niacin"),
        assert(
            pantothenicAcid == null ||
                pantothenicAcid.inGrams >= _minMass.inGrams &&
                    pantothenicAcid.inGrams <= _maxMass100.inGrams,
            "pantothenicAcid"),
        assert(
            phosphorus == null ||
                phosphorus.inGrams >= _minMass.inGrams &&
                    phosphorus.inGrams <= _maxMass100.inGrams,
            "phosphorus"),
        assert(
            polyunsaturatedFat == null ||
                polyunsaturatedFat.inGrams >= _minMass.inGrams &&
                    polyunsaturatedFat.inGrams <= _maxMass100K.inGrams,
            "polyunsaturatedFat"),
        assert(
            potassium == null ||
                potassium.inGrams >= _minMass.inGrams &&
                    potassium.inGrams <= _maxMass100.inGrams,
            "potassium"),
        assert(
            protein == null ||
                protein.inGrams >= _minMass.inGrams &&
                    protein.inGrams <= _maxMass100K.inGrams,
            "protein"),
        assert(
            riboflavin == null ||
                riboflavin.inGrams >= _minMass.inGrams &&
                    riboflavin.inGrams <= _maxMass100.inGrams,
            "riboflavin"),
        assert(
            saturatedFat == null ||
                saturatedFat.inGrams >= _minMass.inGrams &&
                    saturatedFat.inGrams <= _maxMass100K.inGrams,
            "saturatedFat"),
        assert(
            selenium == null ||
                selenium.inGrams >= _minMass.inGrams &&
                    selenium.inGrams <= _maxMass100.inGrams,
            "selenium"),
        assert(
            sodium == null ||
                sodium.inGrams >= _minMass.inGrams &&
                    sodium.inGrams <= _maxMass100.inGrams,
            "sodium"),
        assert(
            sugar == null ||
                sugar.inGrams >= _minMass.inGrams &&
                    sugar.inGrams <= _maxMass100K.inGrams,
            "sugar"),
        assert(
            thiamin == null ||
                thiamin.inGrams >= _minMass.inGrams &&
                    thiamin.inGrams <= _maxMass100.inGrams,
            "thiamin"),
        assert(
            totalCarbohydrates == null ||
                totalCarbohydrates.inGrams >= _minMass.inGrams &&
                    totalCarbohydrates.inGrams <= _maxMass100K.inGrams,
            "totalCarbohydrates"),
        assert(
            totalFat == null ||
                totalFat.inGrams >= _minMass.inGrams &&
                    totalFat.inGrams <= _maxMass100K.inGrams,
            "totalFat"),
        assert(
            transFat == null ||
                transFat.inGrams >= _minMass.inGrams &&
                    transFat.inGrams <= _maxMass100K.inGrams,
            "transFat"),
        assert(
            unsaturatedFat == null ||
                unsaturatedFat.inGrams >= _minMass.inGrams &&
                    unsaturatedFat.inGrams <= _maxMass100K.inGrams,
            "unsaturatedFat"),
        assert(
            vitaminA == null ||
                vitaminA.inGrams >= _minMass.inGrams &&
                    vitaminA.inGrams <= _maxMass100.inGrams,
            "vitaminA"),
        assert(
            vitaminB12 == null ||
                vitaminB12.inGrams >= _minMass.inGrams &&
                    vitaminB12.inGrams <= _maxMass100.inGrams,
            "vitaminB12"),
        assert(
            vitaminB6 == null ||
                vitaminB6.inGrams >= _minMass.inGrams &&
                    vitaminB6.inGrams <= _maxMass100.inGrams,
            "vitaminB6"),
        assert(
            vitaminC == null ||
                vitaminC.inGrams >= _minMass.inGrams &&
                    vitaminC.inGrams <= _maxMass100.inGrams,
            "vitaminC"),
        assert(
            vitaminD == null ||
                vitaminD.inGrams >= _minMass.inGrams &&
                    vitaminD.inGrams <= _maxMass100.inGrams,
            "vitaminD"),
        assert(
            vitaminE == null ||
                vitaminE.inGrams >= _minMass.inGrams &&
                    vitaminE.inGrams <= _maxMass100.inGrams,
            "vitaminE"),
        assert(
            vitaminK == null ||
                vitaminK.inGrams >= _minMass.inGrams &&
                    vitaminK.inGrams <= _maxMass100.inGrams,
            "vitaminK"),
        assert(
            zinc == null ||
                zinc.inGrams >= _minMass.inGrams &&
                    zinc.inGrams <= _maxMass100.inGrams,
            "zinc");

  static const Mass _minMass = Mass.grams(0);
  static const Mass _maxMass100 = Mass.grams(100);
  static const Mass _maxMass100K = Mass.grams(100000);
  static const Energy _minEnergy = Energy.calories(0);
  static const Energy _maxEnergy = Energy.calories(100000000);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionRecord &&
          biotin == other.biotin &&
          caffeine == other.caffeine &&
          calcium == other.calcium &&
          energy == other.energy &&
          energyFromFat == other.energyFromFat &&
          chloride == other.chloride &&
          cholesterol == other.cholesterol &&
          chromium == other.chromium &&
          copper == other.copper &&
          dietaryFiber == other.dietaryFiber &&
          folate == other.folate &&
          iodine == other.iodine &&
          iron == other.iron &&
          magnesium == other.magnesium &&
          manganese == other.manganese &&
          molybdenum == other.molybdenum &&
          monounsaturatedFat == other.monounsaturatedFat &&
          niacin == other.niacin &&
          pantothenicAcid == other.pantothenicAcid &&
          phosphorus == other.phosphorus &&
          polyunsaturatedFat == other.polyunsaturatedFat &&
          potassium == other.potassium &&
          protein == other.protein &&
          riboflavin == other.riboflavin &&
          saturatedFat == other.saturatedFat &&
          selenium == other.selenium &&
          sodium == other.sodium &&
          sugar == other.sugar &&
          thiamin == other.thiamin &&
          totalCarbohydrates == other.totalCarbohydrates &&
          totalFat == other.totalFat &&
          transFat == other.transFat &&
          unsaturatedFat == other.unsaturatedFat &&
          vitaminA == other.vitaminA &&
          vitaminB12 == other.vitaminB12 &&
          vitaminB6 == other.vitaminB6 &&
          vitaminC == other.vitaminC &&
          vitaminD == other.vitaminD &&
          vitaminE == other.vitaminE &&
          vitaminK == other.vitaminK &&
          zinc == other.zinc;

  @override
  int get hashCode =>
      biotin.hashCode ^
      caffeine.hashCode ^
      calcium.hashCode ^
      energy.hashCode ^
      energyFromFat.hashCode ^
      chloride.hashCode ^
      cholesterol.hashCode ^
      chromium.hashCode ^
      copper.hashCode ^
      dietaryFiber.hashCode ^
      folate.hashCode ^
      iodine.hashCode ^
      iron.hashCode ^
      magnesium.hashCode ^
      manganese.hashCode ^
      molybdenum.hashCode ^
      monounsaturatedFat.hashCode ^
      niacin.hashCode ^
      pantothenicAcid.hashCode ^
      phosphorus.hashCode ^
      polyunsaturatedFat.hashCode ^
      potassium.hashCode ^
      protein.hashCode ^
      riboflavin.hashCode ^
      saturatedFat.hashCode ^
      selenium.hashCode ^
      sodium.hashCode ^
      sugar.hashCode ^
      thiamin.hashCode ^
      totalCarbohydrates.hashCode ^
      totalFat.hashCode ^
      transFat.hashCode ^
      unsaturatedFat.hashCode ^
      vitaminA.hashCode ^
      vitaminB12.hashCode ^
      vitaminB6.hashCode ^
      vitaminC.hashCode ^
      vitaminD.hashCode ^
      vitaminE.hashCode ^
      vitaminK.hashCode ^
      zinc.hashCode ^
      name.hashCode ^
      mealType.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode ^
      endTime.hashCode ^
      endZoneOffset.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime.toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'name': name,
      'mealType': mealType.index,
      'biotin': biotin?.inGrams,
      'caffeine': caffeine?.inGrams,
      'calcium': calcium?.inGrams,
      'energy': energy?.inCalories,
      'energyFromFat': energyFromFat?.inCalories,
      'chloride': chloride?.inGrams,
      'cholesterol': cholesterol?.inGrams,
      'chromium': chromium?.inGrams,
      'copper': copper?.inGrams,
      'dietaryFiber': dietaryFiber?.inGrams,
      'folate': folate?.inGrams,
      'iodine': iodine?.inGrams,
      'iron': iron?.inGrams,
      'magnesium': magnesium?.inGrams,
      'manganese': manganese?.inGrams,
      'molybdenum': molybdenum?.inGrams,
      'monounsaturatedFat': monounsaturatedFat?.inGrams,
      'niacin': niacin?.inGrams,
      'pantothenicAcid': pantothenicAcid?.inGrams,
      'phosphorus': phosphorus?.inGrams,
      'polyunsaturatedFat': polyunsaturatedFat?.inGrams,
      'potassium': potassium?.inGrams,
      'protein': protein?.inGrams,
      'riboflavin': riboflavin?.inGrams,
      'saturatedFat': saturatedFat?.inGrams,
      'selenium': selenium?.inGrams,
      'sodium': sodium?.inGrams,
      'sugar': sugar?.inGrams,
      'thiamin': thiamin?.inGrams,
      'totalCarbohydrates': totalCarbohydrates?.inGrams,
      'totalFat': totalFat?.inGrams,
      'transFat': transFat?.inGrams,
      'unsaturatedFat': unsaturatedFat?.inGrams,
      'vitaminA': vitaminA?.inGrams,
      'vitaminB12': vitaminB12?.inGrams,
      'vitaminB6': vitaminB6?.inGrams,
      'vitaminC': vitaminC?.inGrams,
      'vitaminD': vitaminD?.inGrams,
      'vitaminE': vitaminE?.inGrams,
      'vitaminK': vitaminK?.inGrams,
      'zinc': zinc?.inGrams,
    };
  }

  @override
  factory NutritionRecord.fromMap(Map<String, dynamic> map) {
    return NutritionRecord(
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] == null
          ? null
          : Duration(hours: map['endZoneOffset'] as int),
      metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] == null
          ? null
          : Duration(hours: map['startZoneOffset'] as int),
      name: map['name'] as String,
      mealType: (map['mealType'] != null &&
              map['mealType'] as int < MealType.values.length)
          ? MealType.values[map['mealType'] as int]
          : MealType.unknown,
      biotin:
          map['biotin'] == null ? null : Mass.grams(map['biotin'] as double),
      caffeine: map['caffeine'] == null
          ? null
          : Mass.grams(map['caffeine'] as double),
      calcium:
          map['calcium'] == null ? null : Mass.grams(map['calcium'] as double),
      energy: map['energy'] == null
          ? null
          : Energy.calories(map['energy'] as double),
      energyFromFat: map['energyFromFat'] == null
          ? null
          : Energy.calories(map['energyFromFat'] as double),
      chloride: map['chloride'] == null
          ? null
          : Mass.grams(map['chloride'] as double),
      cholesterol: map['cholesterol'] == null
          ? null
          : Mass.grams(map['cholesterol'] as double),
      chromium: map['chromium'] == null
          ? null
          : Mass.grams(map['chromium'] as double),
      copper:
          map['copper'] == null ? null : Mass.grams(map['copper'] as double),
      dietaryFiber: map['dietaryFiber'] == null
          ? null
          : Mass.grams(map['dietaryFiber'] as double),
      folate:
          map['folate'] == null ? null : Mass.grams(map['folate'] as double),
      iodine:
          map['iodine'] == null ? null : Mass.grams(map['iodine'] as double),
      iron: map['iron'] == null ? null : Mass.grams(map['iron'] as double),
      magnesium: map['magnesium'] == null
          ? null
          : Mass.grams(map['magnesium'] as double),
      manganese: map['manganese'] == null
          ? null
          : Mass.grams(map['manganese'] as double),
      molybdenum: map['molybdenum'] == null
          ? null
          : Mass.grams(map['molybdenum'] as double),
      monounsaturatedFat: map['monounsaturatedFat'] == null
          ? null
          : Mass.grams(map['monounsaturatedFat'] as double),
      niacin:
          map['niacin'] == null ? null : Mass.grams(map['niacin'] as double),
      pantothenicAcid: map['pantothenicAcid'] == null
          ? null
          : Mass.grams(map['pantothenicAcid'] as double),
      phosphorus: map['phosphorus'] == null
          ? null
          : Mass.grams(map['phosphorus'] as double),
      polyunsaturatedFat: map['polyunsaturatedFat'] == null
          ? null
          : Mass.grams(map['polyunsaturatedFat'] as double),
      potassium: map['potassium'] == null
          ? null
          : Mass.grams(map['potassium'] as double),
      protein:
          map['protein'] == null ? null : Mass.grams(map['protein'] as double),
      riboflavin: map['riboflavin'] == null
          ? null
          : Mass.grams(map['riboflavin'] as double),
      saturatedFat: map['saturatedFat'] == null
          ? null
          : Mass.grams(map['saturatedFat'] as double),
      selenium: map['selenium'] == null
          ? null
          : Mass.grams(map['selenium'] as double),
      sodium:
          map['sodium'] == null ? null : Mass.grams(map['sodium'] as double),
      sugar: map['sugar'] == null ? null : Mass.grams(map['sugar'] as double),
      thiamin:
          map['thiamin'] == null ? null : Mass.grams(map['thiamin'] as double),
      totalCarbohydrates: map['totalCarbohydrates'] == null
          ? null
          : Mass.grams(map['totalCarbohydrates'] as double),
      totalFat: map['totalFat'] == null
          ? null
          : Mass.grams(map['totalFat'] as double),
      transFat: map['transFat'] == null
          ? null
          : Mass.grams(map['transFat'] as double),
      unsaturatedFat: map['unsaturatedFat'] == null
          ? null
          : Mass.grams(map['unsaturatedFat'] as double),
      vitaminA: map['vitaminA'] == null
          ? null
          : Mass.grams(map['vitaminA'] as double),
      vitaminB12: map['vitaminB12'] == null
          ? null
          : Mass.grams(map['vitaminB12'] as double),
      vitaminB6: map['vitaminB6'] == null
          ? null
          : Mass.grams(map['vitaminB6'] as double),
      vitaminC: map['vitaminC'] == null
          ? null
          : Mass.grams(map['vitaminC'] as double),
      vitaminD: map['vitaminD'] == null
          ? null
          : Mass.grams(map['vitaminD'] as double),
      vitaminE: map['vitaminE'] == null
          ? null
          : Mass.grams(map['vitaminE'] as double),
      vitaminK: map['vitaminK'] == null
          ? null
          : Mass.grams(map['vitaminK'] as double),
      zinc: map['zinc'] == null ? null : Mass.grams(map['zinc'] as double),
    );
  }
}
