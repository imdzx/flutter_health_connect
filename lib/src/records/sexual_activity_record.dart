import 'package:flutter_health_connect/src/records/instantaneous_record.dart';
import 'package:flutter_health_connect/src/records/metadata/metadata.dart';

class SexualActivityRecord extends InstantaneousRecord {
  @override
  Metadata metadata;
  @override
  DateTime time;
  @override
  Duration? zoneOffset;
  Protection protectionUsed;

  SexualActivityRecord({
    required this.time,
    this.zoneOffset,
    this.protectionUsed = Protection.unknown,
    metadata,
  }) : metadata = metadata ?? Metadata.empty();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SexualActivityRecord &&
          time == other.time &&
          zoneOffset == other.zoneOffset &&
          protectionUsed == other.protectionUsed;

  @override
  int get hashCode =>
      time.hashCode ^ zoneOffset.hashCode ^ protectionUsed.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'time': time.toUtc().toIso8601String(),
      'zoneOffset': zoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'protectionUsed': protectionUsed.index,
    };
  }

  @override
  factory SexualActivityRecord.fromMap(Map<String, dynamic> map) {
    return SexualActivityRecord(
      time: DateTime.parse(map['time']),
      zoneOffset: map['zoneOffset'] != null
          ? Duration(hours: map['zoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      protectionUsed: (map['protectionUsed'] != null &&
              map['protectionUsed'] < Protection.values.length)
          ? Protection.values[map['protectionUsed'] as int]
          : Protection.unknown,
    );
  }
}

enum Protection {
  unknown,
  protected,
  unprotected;

  @override
  String toString() {
    switch (this) {
      case Protection.unknown:
        return 'unknown';
      case Protection.protected:
        return 'protected';
      case Protection.unprotected:
        return 'unprotected';
    }
  }
}
