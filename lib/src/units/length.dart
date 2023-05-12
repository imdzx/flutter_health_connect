class Length implements Comparable<Length> {
  final double value;
  final LengthUnit unit;

  const Length(this.value, this.unit);

  const Length.meters(double value) : this(value, LengthUnit.meters);

  const Length.kilometers(double value) : this(value, LengthUnit.kilometers);

  const Length.miles(double value) : this(value, LengthUnit.miles);

  const Length.feet(double value) : this(value, LengthUnit.feet);

  const Length.inches(double value) : this(value, LengthUnit.inches);

  double get inMeters => _get(unit: LengthUnit.meters);

  double get inKilometers => _get(unit: LengthUnit.kilometers);

  double get inMiles => _get(unit: LengthUnit.miles);

  double get inFeet => _get(unit: LengthUnit.feet);

  double get inInches => _get(unit: LengthUnit.inches);

  double _get({required LengthUnit unit}) =>
      this.unit == unit ? value : inMeters / unit.metersPerUnit;

  @override
  int compareTo(Length other) => unit == other.unit
      ? value.compareTo(other.value)
      : inMeters.compareTo(other.inMeters);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Length && value == other.value && unit == other.unit;

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;

  @override
  String toString() => '$value ${unit.title}';
}

enum LengthUnit {
  meters(1.0, 'meters'),
  kilometers(1000.0, 'kilometers'),
  miles(1609.344, 'miles'),
  feet(0.3048, 'feet'),
  inches(0.0254, 'inches');

  final double metersPerUnit;
  final String title;

  const LengthUnit(this.metersPerUnit, this.title);
}
