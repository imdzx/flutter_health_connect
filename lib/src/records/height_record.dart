import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/length.dart';

class HeightRecord extends InstantaneousRecord {
  @override
  Metadata metadata;
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  Length height;

  HeightRecord({
    required this.time,
    this.zoneOffset,
    required this.height,
    metadata,
  })  : metadata = metadata ?? Metadata.empty(),
        assert(height.inMeters >= _minHeight.inMeters &&
            height.inMeters <= _maxHeight.inMeters);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeightRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          height == other.height;

  @override
  int get hashCode => time.hashCode ^ zoneOffset.hashCode ^ height.hashCode;

  static const Length _minHeight = Length.meters(0);
  static const Length _maxHeight = Length.meters(3);
}
