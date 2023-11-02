import 'package:duration/duration.dart';
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

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'temperature': temperature.inCelsius,
      'measurementLocation': measurementLocation.index,
    };
  }

  @override
  factory BasalBodyTemperatureRecord.fromMap(Map<String, dynamic> map) {
    return BasalBodyTemperatureRecord(
      time: DateTime.parse(map['time']),
      zoneOffset:
          map['zoneOffset'] != null ? parseTime(map['zoneOffset']) : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      temperature:
          Temperature.fromMap(Map<String, dynamic>.from(map['temperature'])),
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
    return 'BasalBodyTemperatureRecord{metadata: $metadata, time: $time, zoneOffset: $zoneOffset, temperature: $temperature, measurementLocation: $measurementLocation}';
  }
}
