class Pressure implements Comparable<Pressure> {
  final double value;
  final PressureUnit unit;

  const Pressure(this.value, this.unit);

  const Pressure.millimetersOfMercury(double value)
      : this(value, PressureUnit.millimetersOfMercury);

  double get inMillimetersOfMercury => value;

  @override
  int compareTo(Pressure other) => value.compareTo(other.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Pressure && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => '$value mmHg';
}

enum PressureUnit {
  millimetersOfMercury('mmHg');

  final String title;

  const PressureUnit(this.title);
}
