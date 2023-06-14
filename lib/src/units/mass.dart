class Mass implements Comparable<Mass> {
  final double value;
  final MassUnit type;

  const Mass(this.value, this.type);

  const Mass.grams(double value) : this(value, MassUnit.grams);

  const Mass.kilograms(double value) : this(value, MassUnit.kilograms);

  const Mass.milligrams(double value) : this(value, MassUnit.milligrams);

  const Mass.micrograms(double value) : this(value, MassUnit.micrograms);

  const Mass.ounces(double value) : this(value, MassUnit.ounces);

  const Mass.pounds(double value) : this(value, MassUnit.pounds);

  /// Returns the mass in grams.
  double get inGrams => value * type.gramsPerUnit;

  /// Returns the mass in kilograms.
  double get inKilograms => _get(type: MassUnit.kilograms);

  /// Returns the mass in milligrams.
  double get inMilligrams => _get(type: MassUnit.milligrams);

  /// Returns the mass in micrograms.
  double get inMicrograms => _get(type: MassUnit.micrograms);

  /// Returns the mass in ounces.
  double get inOunces => _get(type: MassUnit.ounces);

  /// Returns the mass in pounds.
  double get inPounds => _get(type: MassUnit.pounds);

  double _get({required MassUnit type}) =>
      this.type == type ? value : inGrams / type.gramsPerUnit;

  @override
  int compareTo(Mass other) => type == other.type
      ? value.compareTo(other.value)
      : inGrams.compareTo(other.inGrams);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mass && value == other.value && type == other.type);

  @override
  int get hashCode => value.hashCode ^ type.hashCode;

  @override
  String toString() => '$value ${type.name.toLowerCase()}';

  factory Mass.fromMap(Map<String, dynamic> map) =>
      Mass.grams(map['grams'] as double);
}

enum MassUnit {
  grams(1.0, 'g'),
  kilograms(1000.0, 'kg'),
  milligrams(0.001, 'mg'),
  micrograms(0.000001, 'µg'),
  ounces(28.34952, 'oz'),
  pounds(453.59237, 'lb');

  final double gramsPerUnit;
  final String title;

  const MassUnit(this.gramsPerUnit, this.title);
}
