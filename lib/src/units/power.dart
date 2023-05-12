class Power implements Comparable<Power> {
  final double value;
  final PowerUnit unit;

  const Power(this.value, this.unit);

  const Power.watts(double value) : this(value, PowerUnit.watts);

  const Power.kilocaloriesPerDay(double value)
      : this(value, PowerUnit.kilocaloriesPerDay);

  double get inWatts => value * unit.wattsPerUnit;

  double get inKilocaloriesPerDay => _get(unit: PowerUnit.kilocaloriesPerDay);

  double _get({required PowerUnit unit}) =>
      this.unit == unit ? value : inWatts / unit.wattsPerUnit;

  @override
  int compareTo(Power other) => unit == other.unit
      ? value.compareTo(other.value)
      : inWatts.compareTo(other.inWatts);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Power && value == other.value && unit == other.unit;

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;

  @override
  String toString() => '$value ${unit.title}';
}

enum PowerUnit {
  watts(1.0, 'Watts'),
  kilocaloriesPerDay(0.0484259259, 'kcal/day');

  final double wattsPerUnit;
  final String title;

  const PowerUnit(this.wattsPerUnit, this.title);
}
