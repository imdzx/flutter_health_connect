class Percentage implements Comparable<Percentage> {
  final double value;

  const Percentage(this.value);

  @override
  int compareTo(Percentage other) => value.compareTo(other.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Percentage && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => '$value%';

  factory Percentage.fromMap(Map<String, dynamic> map) => Percentage(
        map['value'] as double,
      );
}
