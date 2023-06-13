class Velocity implements Comparable<Velocity> {
  final double value;
  final VelocityUnits unit;

  const Velocity(this.value, this.unit);

  const Velocity.metersPerSecond(double value)
      : this(value, VelocityUnits.metersPerSecond);

  const Velocity.kilometersPerHour(double value)
      : this(value, VelocityUnits.kilometersPerHour);

  const Velocity.milesPerHour(double value)
      : this(value, VelocityUnits.milesPerHour);

  double get inMetersPerSecond => value * unit.metersPerSecondPerUnit;

  double get inKilometersPerHour => _get(unit: VelocityUnits.kilometersPerHour);

  double get inMilesPerHour => _get(unit: VelocityUnits.milesPerHour);

  double _get({required VelocityUnits unit}) => this.unit == unit
      ? value
      : inMetersPerSecond / unit.metersPerSecondPerUnit;

  @override
  int compareTo(Velocity other) => unit == other.unit
      ? value.compareTo(other.value)
      : inMetersPerSecond.compareTo(other.inMetersPerSecond);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Velocity && value == other.value && unit == other.unit;

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;

  @override
  String toString() => '$value ${unit.title}';

  factory Velocity.fromMap(Map<String, dynamic> map) => Velocity(
        map['value'] as double,
        VelocityUnits.values[map['unit'] as int],
      );
}

enum VelocityUnits {
  metersPerSecond(1.0, 'meters/sec'),
  kilometersPerHour(1.0 / 3.6, 'km/h'),
  milesPerHour(0.447040357632, 'miles/h');

  final double metersPerSecondPerUnit;
  final String title;

  const VelocityUnits(this.metersPerSecondPerUnit, this.title);
}
