import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';
import 'package:flutter_health_connect/src/units/length.dart';

class HeightRecord extends InstantaneousRecord {
  /// Unit: meters
  static const String aggregationKeyHeightAvg = 'HeightRecordHeightAvg';

  /// Unit: meters
  static const String aggregationKeyHeightMin = 'HeightRecordHeightMin';

  /// Unit: meters
  static const String aggregationKeyHeightMax = 'HeightRecordHeightMax';

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

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'height': height.inMeters,
    };
  }

  @override
  factory HeightRecord.fromMap(Map<String, dynamic> map) {
    return HeightRecord(
      time: DateTime.parse(map['time']),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      height: Length.fromMap(Map<String, dynamic>.from(map['height'])),
    );
  }

  @override
  String toString() {
    return 'HeightRecord{metadata: $metadata, time: $time, zoneOffset: $zoneOffset, height: $height}';
  }
}
