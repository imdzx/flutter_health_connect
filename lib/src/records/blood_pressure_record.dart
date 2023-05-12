import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/pressure.dart';

class BloodPressureRecord extends InstantaneousRecord {
  @override
  Metadata metadata;
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  Pressure systolic;
  Pressure diastolic;

  BloodPressureMeasurementLocation measurementLocation;
  BloodPressureBodyPosition bodyPosition;

  BloodPressureRecord({
    metadata,
    required this.time,
    this.zoneOffset,
    required this.systolic,
    required this.diastolic,
    this.measurementLocation = BloodPressureMeasurementLocation.unknown,
    this.bodyPosition = BloodPressureBodyPosition.unknown,
  })  : assert(systolic.inMillimetersOfMercury >=
                _minSystolic.inMillimetersOfMercury &&
            systolic.inMillimetersOfMercury <=
                _maxSystolic.inMillimetersOfMercury),
        assert(diastolic.inMillimetersOfMercury >=
                _minDiastolic.inMillimetersOfMercury &&
            diastolic.inMillimetersOfMercury <=
                _maxDiastolic.inMillimetersOfMercury),
        metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureRecord &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          systolic == other.systolic &&
          diastolic == other.diastolic &&
          measurementLocation == other.measurementLocation &&
          bodyPosition == other.bodyPosition;

  @override
  int get hashCode =>
      metadata.hashCode ^
      time.hashCode ^
      zoneOffset.hashCode ^
      systolic.hashCode ^
      diastolic.hashCode ^
      measurementLocation.hashCode ^
      bodyPosition.hashCode;

  static const Pressure _minSystolic = Pressure.millimetersOfMercury(20);
  static const Pressure _maxSystolic = Pressure.millimetersOfMercury(200);
  static const Pressure _minDiastolic = Pressure.millimetersOfMercury(10);
  static const Pressure _maxDiastolic = Pressure.millimetersOfMercury(180);
}

enum BloodPressureMeasurementLocation {
  unknown,
  leftUpperArm,
  leftLowerArm,
  rightUpperArm,
  rightLowerArm;

  @override
  String toString() {
    switch (this) {
      case BloodPressureMeasurementLocation.unknown:
        return 'unknown';
      case BloodPressureMeasurementLocation.leftUpperArm:
        return 'leftUpperArm';
      case BloodPressureMeasurementLocation.leftLowerArm:
        return 'leftLowerArm';
      case BloodPressureMeasurementLocation.rightUpperArm:
        return 'rightUpperArm';
      case BloodPressureMeasurementLocation.rightLowerArm:
        return 'rightLowerArm';
    }
  }
}

enum BloodPressureBodyPosition {
  unknown,
  standingUp,
  sittingDown,
  lyingDown,
  reclining;

  @override
  String toString() {
    switch (this) {
      case BloodPressureBodyPosition.unknown:
        return 'unknown';
      case BloodPressureBodyPosition.standingUp:
        return 'standingUp';
      case BloodPressureBodyPosition.sittingDown:
        return 'sittingDown';
      case BloodPressureBodyPosition.lyingDown:
        return 'lyingDown';
      case BloodPressureBodyPosition.reclining:
        return 'reclining';
    }
  }
}
