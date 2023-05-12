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
