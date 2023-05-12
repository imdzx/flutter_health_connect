class Volume implements Comparable<Volume> {
  final double value;
  final VolumeUnit unit;

  const Volume(this.value, this.unit);

  const Volume.liters(double value) : this(value, VolumeUnit.liters);

  const Volume.milliliters(double value) : this(value, VolumeUnit.milliliters);

  const Volume.fluidOuncesUS(double value)
      : this(value, VolumeUnit.fluidOuncesUS);

  double get inLiters => value * unit.litersPerUnit;

  double get inMilliliters => _get(VolumeUnit.milliliters);

  double get inFluidOuncesUS => _get(VolumeUnit.fluidOuncesUS);

  double _get(VolumeUnit unit) =>
      this.unit == unit ? value : value / unit.litersPerUnit;

  @override
  int compareTo(other) => unit == other.unit
      ? value.compareTo(other.value)
      : inLiters.compareTo(other.inLiters);

  @override
  bool operator ==(Object other) => (identical(this, other) ||
      other is Volume && value == other.value && unit == other.unit);

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;

  @override
  String toString() => '$value ${unit.title}';
}

enum VolumeUnit {
  liters(1.0, 'L'),
  milliliters(0.001, 'mL'),
  fluidOuncesUS(0.02957353, 'fl. oz (US)');

  final double litersPerUnit;
  final String title;

  const VolumeUnit(this.litersPerUnit, this.title);
}
