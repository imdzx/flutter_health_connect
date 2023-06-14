class Energy implements Comparable<Energy> {
  final double value;
  final EnergyUnit unit;

  const Energy(this.value, this.unit);

  const Energy.calories(double value) : this(value, EnergyUnit.calories);

  const Energy.kilocalories(double value)
      : this(value, EnergyUnit.kilocalories);

  const Energy.joules(double value) : this(value, EnergyUnit.joules);

  const Energy.kilojoules(double value) : this(value, EnergyUnit.kilojoules);

  double get inCalories => _get(unit: EnergyUnit.calories);

  double get inKilocalories => _get(unit: EnergyUnit.kilocalories);

  double get inJoules => _get(unit: EnergyUnit.joules);

  double get inKilojoules => _get(unit: EnergyUnit.kilojoules);

  double _get({required EnergyUnit unit}) =>
      this.unit == unit ? value : inCalories / unit.caloriesPerUnit;

  @override
  int compareTo(Energy other) => unit == other.unit
      ? value.compareTo(other.value)
      : inCalories.compareTo(other.inCalories);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Energy && value == other.value && unit == other.unit;

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;

  @override
  String toString() => '$value ${unit.title}';

  factory Energy.fromMap(Map<String, dynamic> map) =>
      Energy.calories(map['calories'] as double);
}

enum EnergyUnit {
  calories(1.0, 'cal'),
  kilocalories(1000.0, 'kcal'),
  joules(0.2390057361, 'J'),
  kilojoules(239.0057361, 'kJ');

  final double caloriesPerUnit;
  final String title;

  const EnergyUnit(this.caloriesPerUnit, this.title);
}
