class Temperature implements Comparable<Temperature> {
  final double value;
  final TemperatureUnit unit;

  const Temperature(this.value, this.unit);

  const Temperature.celsius(double value)
      : this(value, TemperatureUnit.celsius);

  const Temperature.fahrenheit(double value)
      : this(value, TemperatureUnit.fahrenheit);

  double get inCelsius {
    switch (unit) {
      case TemperatureUnit.celsius:
        return value;
      case TemperatureUnit.fahrenheit:
        return (value - 32.0) / 1.8;
    }
  }

  double get inFahrenheit {
    switch (unit) {
      case TemperatureUnit.celsius:
        return value * 1.8 + 32.0;
      case TemperatureUnit.fahrenheit:
        return value;
    }
  }

  @override
  int compareTo(Temperature other) {
    if (unit == other.unit) {
      return value.compareTo(other.value);
    } else {
      return inCelsius.compareTo(other.inCelsius);
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Temperature && value == other.value && unit == other.unit;

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;

  @override
  String toString() => '$value ${unit.toString().split('.').last}';

  factory Temperature.fromMap(Map<String, dynamic> map) =>
      Temperature.celsius(map['celsius'] as double);
}

enum TemperatureUnit {
  celsius('Celsius'),
  fahrenheit('Fahrenheit');

  final String title;

  const TemperatureUnit(this.title);
}
