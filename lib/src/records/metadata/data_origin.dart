class DataOrigin {
  final String packageName;

  const DataOrigin(this.packageName);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataOrigin && packageName == other.packageName;

  @override
  int get hashCode => packageName.hashCode;

  @override
  String toString() => 'DataOrigin{packageName: $packageName}';
}
