import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/units/temperature.dart';

import 'body_temperature_measurement_location.dart';
import 'metadata/metadata.dart';

class BodyTemperatureRecord extends InstantaneousRecord {
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  @override
  Metadata metadata;
  Temperature temperature;
  BodyTemperatureMeasurementLocation measurementLocation;

  BodyTemperatureRecord({
    required this.time,
    this.zoneOffset,
    required this.temperature,
    this.measurementLocation = BodyTemperatureMeasurementLocation.unknown,
    metadata,
  })  : assert(temperature.inCelsius >= _minTemperature.inCelsius &&
            temperature.inCelsius <= _maxTemperature.inCelsius),
        metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyTemperatureRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          temperature == other.temperature;

  @override
  int get hashCode =>
      time.hashCode ^ zoneOffset.hashCode ^ temperature.hashCode;

  static const Temperature _minTemperature = Temperature.celsius(0);
  static const Temperature _maxTemperature = Temperature.celsius(100);

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'temperature': temperature.inCelsius,
      'measurementLocation': measurementLocation.index,
    };
  }

  @override
  factory BodyTemperatureRecord.fromMap(Map<String, dynamic> map) {
    return BodyTemperatureRecord(
      time: DateTime.parse(map['time']),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(map['metadata'] as Map<String, dynamic>),
      temperature: Temperature.celsius(map['temperature'] as double),
      measurementLocation: (map['measurementLocation'] != null &&
              map['measurementLocation'] as int <
                  BodyTemperatureMeasurementLocation.values.length)
          ? BodyTemperatureMeasurementLocation
              .values[map['measurementLocation'] as int]
          : BodyTemperatureMeasurementLocation.unknown,
    );
  }

  @override
  String toString() {
    return 'BodyTemperatureRecord{time: $time, zoneOffset: $zoneOffset, metadata: $metadata, temperature: $temperature, measurementLocation: $measurementLocation}';
  }
}
