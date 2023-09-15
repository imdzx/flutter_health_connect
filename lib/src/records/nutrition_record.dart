import 'package:flutter_health_connect/src/records/interval_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/energy.dart';
import 'package:flutter_health_connect/src/units/mass.dart';

import 'meal_type.dart';

class NutritionRecord extends IntervalRecord {
  /// Unit: grams
  static const String aggregationKeyBiotinTotal = 'NutritionRecordBiotinTotal';

  /// Unit: grams
  static const String aggregationKeyCaffeineTotal =
      'NutritionRecordCaffeineTotal';

  /// Unit: grams
  static const String aggregationKeyCalciumTotal =
      'NutritionRecordCalciumTotal';

  /// Unit: kilocalories
  static const String aggregationKeyEnergyTotal = 'NutritionRecordEnergyTotal';

  /// Unit: kilocalories
  static const String aggregationKeyEnergyFromFatTotal =
      'NutritionRecordEnergyFromFatTotal';

  /// Unit: grams
  static const String aggregationKeyChlorideTotal =
      'NutritionRecordChlorideTotal';

  /// Unit: grams
  static const String aggregationKeyCholesterolTotal =
      'NutritionRecordCholesterolTotal';

  /// Unit: grams
  static const String aggregationKeyChromiumTotal =
      'NutritionRecordChromiumTotal';

  /// Unit: grams
  static const String aggregationKeyCopperTotal = 'NutritionRecordCopperTotal';

  /// Unit: grams
  static const String aggregationKeyDietaryFiberTotal =
      'NutritionRecordDietaryFiberTotal';

  /// Unit: grams
  static const String aggregationKeyFolateTotal = 'NutritionRecordFolateTotal';

  /// Unit: grams
  static const String aggregationKeyFolicAcidTotal =
      'NutritionRecordFolicAcidTotal';

  /// Unit: grams
  static const String aggregationKeyIodineTotal = 'NutritionRecordIodineTotal';

  /// Unit: grams
  static const String aggregationKeyIronTotal = 'NutritionRecordIronTotal';

  /// Unit: grams
  static const String aggregationKeyMagnesiumTotal =
      'NutritionRecordMagnesiumTotal';

  /// Unit: grams
  static const String aggregationKeyManganeseTotal =
      'NutritionRecordManganeseTotal';

  /// Unit: grams
  static const String aggregationKeyMolybdenumTotal =
      'NutritionRecordMolybdenumTotal';

  /// Unit: grams
  static const String aggregationKeyMonounsaturatedFatTotal =
      'NutritionRecordMonounsaturatedFatTotal';

  /// Unit: grams
  static const String aggregationKeyNiacinTotal = 'NutritionRecordNiacinTotal';

  /// Unit: grams
  static const String aggregationKeyPantothenicAcidTotal =
      'NutritionRecordPantothenicAcidTotal';

  /// Unit: grams
  static const String aggregationKeyPhosphorusTotal =
      'NutritionRecordPhosphorusTotal';

  /// Unit: grams
  static const String aggregationKeyPolyunsaturatedFatTotal =
      'NutritionRecordPolyunsaturatedFatTotal';

  /// Unit: grams
  static const String aggregationKeyPotassiumTotal =
      'NutritionRecordPotassiumTotal';

  /// Unit: grams
  static const String aggregationKeyProteinTotal =
      'NutritionRecordProteinTotal';

  /// Unit: grams
  static const String aggregationKeyRiboflavinTotal =
      'NutritionRecordRiboflavinTotal';

  /// Unit: grams
  static const String aggregationKeySaturatedFatTotal =
      'NutritionRecordSaturatedFatTotal';

  /// Unit: grams
  static const String aggregationKeySeleniumTotal =
      'NutritionRecordSeleniumTotal';

  /// Unit: grams
  static const String aggregationKeySodiumTotal = 'NutritionRecordSodiumTotal';

  /// Unit: grams
  static const String aggregationKeySugarTotal = 'NutritionRecordSugarTotal';

  /// Unit: grams
  static const String aggregationKeyThiaminTotal =
      'NutritionRecordThiaminTotal';

  /// Unit: grams
  static const String aggregationKeyTotalCarbohydrateTotal =
      'NutritionRecordTotalCarbohydrateTotal';

  /// Unit: grams
  static const String aggregationKeyTotalFatTotal =
      'NutritionRecordTotalFatTotal';

  /// Unit: grams
  static const String aggregationKeyTransFatTotal =
      'NutritionRecordTransFatTotal';

  /// Unit: grams
  static const String aggregationKeyUnsaturatedFatTotal =
      'NutritionRecordUnsaturatedFatTotal';

  /// Unit: grams
  static const String aggregationKeyVitaminATotal =
      'NutritionRecordVitaminATotal';

  /// Unit: grams
  static const String aggregationKeyVitaminB12Total =
      'NutritionRecordVitaminB12Total';

  /// Unit: grams
  static const String aggregationKeyVitaminB6Total =
      'NutritionRecordVitaminB6Total';

  /// Unit: grams
  static const String aggregationKeyVitaminCTotal =
      'NutritionRecordVitaminCTotal';

  /// Unit: grams
  static const String aggregationKeyVitaminDTotal =
      'NutritionRecordVitaminDTotal';

  /// Unit: grams
  static const String aggregationKeyVitaminETotal =
      'NutritionRecordVitaminETotal';

  /// Unit: grams
  static const String aggregationKeyVitaminKTotal =
      'NutritionRecordVitaminKTotal';

  /// Unit: grams
  static const String aggregationKeyZincTotal = 'NutritionRecordZincTotal';

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
                (biotin.inGrams >= _minMass.inGrams &&
                    biotin.inGrams <= _maxMass100.inGrams),
            "biotin"),
        assert(
            caffeine == null ||
                (caffeine.inGrams >= _minMass.inGrams &&
                    caffeine.inGrams <= _maxMass100.inGrams),
            "caffeine"),
        assert(
            calcium == null ||
                (calcium.inGrams >= _minMass.inGrams &&
                    calcium.inGrams <= _maxMass100.inGrams),
            "calcium"),
        assert(
            energy == null ||
                (energy.inCalories >= _minEnergy.inCalories &&
                    energy.inCalories <= _maxEnergy.inCalories),
            "energy"),
        assert(
            energyFromFat == null ||
                (energyFromFat.inCalories >= _minEnergy.inCalories &&
                    energyFromFat.inCalories <= _maxEnergy.inCalories),
            "energyFromFat"),
        assert(
            chloride == null ||
                (chloride.inGrams >= _minMass.inGrams &&
                    chloride.inGrams <= _maxMass100.inGrams),
            "chloride"),
        assert(
            cholesterol == null ||
                (cholesterol.inGrams >= _minMass.inGrams &&
                    cholesterol.inGrams <= _maxMass100.inGrams),
            "cholesterol"),
        assert(
            chromium == null ||
                (chromium.inGrams >= _minMass.inGrams &&
                    chromium.inGrams <= _maxMass100.inGrams),
            "chromium"),
        assert(
            copper == null ||
                (copper.inGrams >= _minMass.inGrams &&
                    copper.inGrams <= _maxMass100.inGrams),
            "copper"),
        assert(
            dietaryFiber == null ||
                (dietaryFiber.inGrams >= _minMass.inGrams &&
                    dietaryFiber.inGrams <= _maxMass100K.inGrams),
            "dietaryFiber"),
        assert(
            folate == null ||
                (folate.inGrams >= _minMass.inGrams &&
                    folate.inGrams <= _maxMass100.inGrams),
            "folate"),
        assert(
            folicAcid == null ||
                (folicAcid.inGrams >= _minMass.inGrams &&
                    folicAcid.inGrams <= _maxMass100.inGrams),
            "folicAcid"),
        assert(
            iodine == null ||
                (iodine.inGrams >= _minMass.inGrams &&
                    iodine.inGrams <= _maxMass100.inGrams),
            "iodine"),
        assert(
            iron == null ||
                (iron.inGrams >= _minMass.inGrams &&
                    iron.inGrams <= _maxMass100.inGrams),
            "iron"),
        assert(
            magnesium == null ||
                (magnesium.inGrams >= _minMass.inGrams &&
                    magnesium.inGrams <= _maxMass100.inGrams),
            "magnesium"),
        assert(
            manganese == null ||
                (manganese.inGrams >= _minMass.inGrams &&
                    manganese.inGrams <= _maxMass100.inGrams),
            "manganese"),
        assert(
            molybdenum == null ||
                (molybdenum.inGrams >= _minMass.inGrams &&
                    molybdenum.inGrams <= _maxMass100.inGrams),
            "molybdenum"),
        assert(
            monounsaturatedFat == null ||
                (monounsaturatedFat.inGrams >= _minMass.inGrams &&
                    monounsaturatedFat.inGrams <= _maxMass100K.inGrams),
            "monounsaturatedFat"),
        assert(
            niacin == null ||
                (niacin.inGrams >= _minMass.inGrams &&
                    niacin.inGrams <= _maxMass100.inGrams),
            "niacin"),
        assert(
            pantothenicAcid == null ||
                (pantothenicAcid.inGrams >= _minMass.inGrams &&
                    pantothenicAcid.inGrams <= _maxMass100.inGrams),
            "pantothenicAcid"),
        assert(
            phosphorus == null ||
                (phosphorus.inGrams >= _minMass.inGrams &&
                    phosphorus.inGrams <= _maxMass100.inGrams),
            "phosphorus"),
        assert(
            polyunsaturatedFat == null ||
                (polyunsaturatedFat.inGrams >= _minMass.inGrams &&
                    polyunsaturatedFat.inGrams <= _maxMass100K.inGrams),
            "polyunsaturatedFat"),
        assert(
            potassium == null ||
                (potassium.inGrams >= _minMass.inGrams &&
                    potassium.inGrams <= _maxMass100.inGrams),
            "potassium"),
        assert(
            protein == null ||
                (protein.inGrams >= _minMass.inGrams &&
                    protein.inGrams <= _maxMass100K.inGrams),
            "protein"),
        assert(
            riboflavin == null ||
                (riboflavin.inGrams >= _minMass.inGrams &&
                    riboflavin.inGrams <= _maxMass100.inGrams),
            "riboflavin"),
        assert(
            saturatedFat == null ||
                (saturatedFat.inGrams >= _minMass.inGrams &&
                    saturatedFat.inGrams <= _maxMass100K.inGrams),
            "saturatedFat"),
        assert(
            selenium == null ||
                (selenium.inGrams >= _minMass.inGrams &&
                    selenium.inGrams <= _maxMass100.inGrams),
            "selenium"),
        assert(
            sodium == null ||
                (sodium.inGrams >= _minMass.inGrams &&
                    sodium.inGrams <= _maxMass100.inGrams),
            "sodium"),
        assert(
            sugar == null ||
                (sugar.inGrams >= _minMass.inGrams &&
                    sugar.inGrams <= _maxMass100K.inGrams),
            "sugar"),
        assert(
            thiamin == null ||
                (thiamin.inGrams >= _minMass.inGrams &&
                    thiamin.inGrams <= _maxMass100.inGrams),
            "thiamin"),
        assert(
            totalCarbohydrates == null ||
                (totalCarbohydrates.inGrams >= _minMass.inGrams &&
                    totalCarbohydrates.inGrams <= _maxMass100K.inGrams),
            "totalCarbohydrates"),
        assert(
            totalFat == null ||
                (totalFat.inGrams >= _minMass.inGrams &&
                    totalFat.inGrams <= _maxMass100K.inGrams),
            "totalFat"),
        assert(
            transFat == null ||
                (transFat.inGrams >= _minMass.inGrams &&
                    transFat.inGrams <= _maxMass100K.inGrams),
            "transFat"),
        assert(
            unsaturatedFat == null ||
                (unsaturatedFat.inGrams >= _minMass.inGrams &&
                    unsaturatedFat.inGrams <= _maxMass100K.inGrams),
            "unsaturatedFat"),
        assert(
            vitaminA == null ||
                (vitaminA.inGrams >= _minMass.inGrams &&
                    vitaminA.inGrams <= _maxMass100.inGrams),
            "vitaminA"),
        assert(
            vitaminB12 == null ||
                (vitaminB12.inGrams >= _minMass.inGrams &&
                    vitaminB12.inGrams <= _maxMass100.inGrams),
            "vitaminB12"),
        assert(
            vitaminB6 == null ||
                (vitaminB6.inGrams >= _minMass.inGrams &&
                    vitaminB6.inGrams <= _maxMass100.inGrams),
            "vitaminB6"),
        assert(
            vitaminC == null ||
                (vitaminC.inGrams >= _minMass.inGrams &&
                    vitaminC.inGrams <= _maxMass100.inGrams),
            "vitaminC"),
        assert(
            vitaminD == null ||
                (vitaminD.inGrams >= _minMass.inGrams &&
                    vitaminD.inGrams <= _maxMass100.inGrams),
            "vitaminD"),
        assert(
            vitaminE == null ||
                (vitaminE.inGrams >= _minMass.inGrams &&
                    vitaminE.inGrams <= _maxMass100.inGrams),
            "vitaminE"),
        assert(
            vitaminK == null ||
                (vitaminK.inGrams >= _minMass.inGrams &&
                    vitaminK.inGrams <= _maxMass100.inGrams),
            "vitaminK"),
        assert(
            zinc == null ||
                (zinc.inGrams >= _minMass.inGrams &&
                    zinc.inGrams <= _maxMass100.inGrams),
            "zinc");

  static const Mass _minMass = Mass.grams(0);
  static const Mass _maxMass100 = Mass.grams(100);
  static const Mass _maxMass100K = Mass.grams(100000);
  static const Energy _minEnergy = Energy.kilocalories(0);
  static const Energy _maxEnergy = Energy.kilocalories(100000);

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
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'name': name,
      'mealType': mealType.index,
      'biotin': biotin?.inGrams,
      'caffeine': caffeine?.inGrams,
      'calcium': calcium?.inGrams,
      'energy': energy?.inKilocalories,
      'energyFromFat': energyFromFat?.inKilocalories,
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
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] == null
          ? null
          : Duration(hours: map['startZoneOffset'] as int),
      name: map['name'] as String,
      mealType: (map['mealType'] != null &&
              map['mealType'] as int < MealType.values.length)
          ? MealType.values[map['mealType'] as int]
          : MealType.unknown,
      biotin: map['biotin'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['biotin'])),
      caffeine: map['caffeine'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['caffeine'])),
      calcium: map['calcium'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['calcium'])),
      energy: map['energy'] == null
          ? null
          : Energy.fromMap(Map<String, dynamic>.from(map['energy'])),
      energyFromFat: map['energyFromFat'] == null
          ? null
          : Energy.fromMap(Map<String, dynamic>.from(map['energyFromFat'])),
      chloride: map['chloride'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['chloride'])),
      cholesterol: map['cholesterol'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['cholesterol'])),
      chromium: map['chromium'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['chromium'])),
      copper: map['copper'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['copper'])),
      dietaryFiber: map['dietaryFiber'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['dietaryFiber'])),
      folate: map['folate'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['folate'])),
      iodine: map['iodine'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['iodine'])),
      iron: map['iron'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['iron'])),
      magnesium: map['magnesium'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['magnesium'])),
      manganese: map['manganese'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['manganese'])),
      molybdenum: map['molybdenum'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['molybdenum'])),
      monounsaturatedFat: map['monounsaturatedFat'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['monounsaturatedFat'])),
      niacin: map['niacin'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['niacin'])),
      pantothenicAcid: map['pantothenicAcid'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['pantothenicAcid'])),
      phosphorus: map['phosphorus'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['phosphorus'])),
      polyunsaturatedFat: map['polyunsaturatedFat'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['polyunsaturatedFat'])),
      potassium: map['potassium'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['potassium'])),
      protein: map['protein'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['protein'])),
      riboflavin: map['riboflavin'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['riboflavin'])),
      saturatedFat: map['saturatedFat'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['saturatedFat'])),
      selenium: map['selenium'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['selenium'])),
      sodium: map['sodium'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['sodium'])),
      sugar: map['sugar'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['sugar'])),
      thiamin: map['thiamin'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['thiamin'])),
      totalCarbohydrates: map['totalCarbohydrates'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['totalCarbohydrates'])),
      totalFat: map['totalFat'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['totalFat'])),
      transFat: map['transFat'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['transFat'])),
      unsaturatedFat: map['unsaturatedFat'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['unsaturatedFat'])),
      vitaminA: map['vitaminA'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['vitaminA'])),
      vitaminB12: map['vitaminB12'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['vitaminB12'])),
      vitaminB6: map['vitaminB6'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['vitaminB6'])),
      vitaminC: map['vitaminC'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['vitaminC'])),
      vitaminD: map['vitaminD'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['vitaminD'])),
      vitaminE: map['vitaminE'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['vitaminE'])),
      vitaminK: map['vitaminK'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['vitaminK'])),
      zinc: map['zinc'] == null
          ? null
          : Mass.fromMap(Map<String, dynamic>.from(map['zinc'])),
    );
  }

  @override
  String toString() {
    return 'NutritionRecord {Energy: $energy, EnergyFromFat: $energyFromFat, Chloride: $chloride, Cholesterol: $cholesterol, Chromium: $chromium, Copper: $copper, DietaryFiber: $dietaryFiber, Folate: $folate, Iodine: $iodine, Iron: $iron, Magnesium: $magnesium, Manganese: $manganese, Molybdenum: $molybdenum, MonounsaturatedFat: $monounsaturatedFat, Niacin: $niacin, PantothenicAcid: $pantothenicAcid, Phosphorus: $phosphorus, PolyunsaturatedFat: $polyunsaturatedFat, Potassium: $potassium, Protein: $protein, Riboflavin: $riboflavin, SaturatedFat: $saturatedFat, Selenium: $selenium, Sodium: $sodium, Sugar: $sugar, Thiamin: $thiamin, TotalCarbohydrates: $totalCarbohydrates, TotalFat: $totalFat, TransFat: $transFat, UnsaturatedFat: $unsaturatedFat, VitaminA: $vitaminA, VitaminB12: $vitaminB12, VitaminB6: $vitaminB6, VitaminC: $vitaminC, VitaminD: $vitaminD, VitaminE: $vitaminE, VitaminK: $vitaminK, Zinc: $zinc}';
  }
}
