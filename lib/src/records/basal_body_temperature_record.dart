import 'package:flutter_health_connect/src/records/body_temperature_measurement_location.dart';
import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/temperature.dart';

class BasalBodyTemperatureRecord extends InstantaneousRecord {
  @override
  Metadata metadata;
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  Temperature temperature;
  BodyTemperatureMeasurementLocation measurementLocation;

  BasalBodyTemperatureRecord(
      {required this.time,
      this.zoneOffset,
      metadata,
      required this.temperature,
      this.measurementLocation = BodyTemperatureMeasurementLocation.unknown})
      : assert(temperature.value <= _maxTemperature.value),
        assert(temperature.value >= _minTemperature.value),
        metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasalBodyTemperatureRecord &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffset == other.zoneOffset;

  @override
  int get hashCode => metadata.hashCode ^ time.hashCode ^ zoneOffset.hashCode;

  static const Temperature _maxTemperature = Temperature.celsius(100);
  static const Temperature _minTemperature = Temperature.celsius(0);
}
