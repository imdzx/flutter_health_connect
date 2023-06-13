class BloodGlucose implements Comparable<BloodGlucose> {
  final double value;
  final BloodGlucoseUnit unit;

  const BloodGlucose(this.value, this.unit);

  const BloodGlucose.milligramsPerDeciliter(double value)
      : this(value, BloodGlucoseUnit.milligramsPerDeciliter);

  const BloodGlucose.millimolesPerLiter(double value)
      : this(value, BloodGlucoseUnit.millimolesPerLiter);

  double get inMilligramsPerDeciliter {
    return _get(unit: BloodGlucoseUnit.milligramsPerDeciliter);
  }

  double get inMillimolesPerLiter {
    return _get(unit: BloodGlucoseUnit.millimolesPerLiter);
  }

  double _get({required BloodGlucoseUnit unit}) {
    return this.unit == unit
        ? value
        : inMilligramsPerDeciliter / unit.millimolesPerLiterPerUnit;
  }

  @override
  int compareTo(BloodGlucose other) {
    if (unit == other.unit) {
      return value.compareTo(other.value);
    } else {
      return inMilligramsPerDeciliter.compareTo(other.inMilligramsPerDeciliter);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodGlucose && value == other.value && unit == other.unit;

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;

  @override
  String toString() => '$value ${unit.toString().split('.').last}';

  factory BloodGlucose.fromMap(Map<String, dynamic> map) => BloodGlucose(
        map['value'] as double,
        BloodGlucoseUnit.values[map['unit'] as int],
      );
}

enum BloodGlucoseUnit {
  millimolesPerLiter('mmol/L', 1.0),
  milligramsPerDeciliter('mg/dL', 1 / 18.0);

  final double millimolesPerLiterPerUnit;
  final String title;

  const BloodGlucoseUnit(this.title, this.millimolesPerLiterPerUnit);
}
