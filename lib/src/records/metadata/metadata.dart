import 'data_origin.dart';
import 'device.dart';
import 'device_types.dart';

class Metadata {
  final String id;
  final DataOrigin dataOrigin;
  final DateTime lastModifiedTime;
  final String? clientRecordId;
  final int clientRecordVersion;
  final Device? device;
  final RecordingMethod recordingMethod;

  Metadata.empty()
      : id = emptyId,
        dataOrigin = const DataOrigin(''),
        lastModifiedTime = DateTime.now(),
        clientRecordId = null,
        clientRecordVersion = 0,
        device = null,
        recordingMethod = RecordingMethod.unknown;

  Metadata(
      {this.id = emptyId,
      this.dataOrigin = const DataOrigin(''),
      this.clientRecordId,
      this.clientRecordVersion = 0,
      this.device,
      this.recordingMethod = RecordingMethod.unknown})
      : lastModifiedTime = DateTime.now();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Metadata &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          dataOrigin == other.dataOrigin &&
          lastModifiedTime == other.lastModifiedTime &&
          clientRecordId == other.clientRecordId &&
          clientRecordVersion == other.clientRecordVersion &&
          device == other.device &&
          recordingMethod == other.recordingMethod;

  @override
  int get hashCode =>
      id.hashCode ^
      dataOrigin.hashCode ^
      lastModifiedTime.hashCode ^
      clientRecordId.hashCode ^
      clientRecordVersion.hashCode ^
      device.hashCode ^
      recordingMethod.hashCode;

  static const String emptyId = '';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataOrigin': {'packageName': dataOrigin.packageName},
      'lastModifiedTime': lastModifiedTime.toUtc().toIso8601String(),
      'clientRecordId': clientRecordId,
      'clientRecordVersion': clientRecordVersion,
      'device': device == null
          ? null
          : {
              'manufacturer': device!.manufacturer,
              'model': device!.model,
              'type': device!.type?.index,
            },
      'recordingMethod': recordingMethod.index,
    };
  }

  factory Metadata.fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> dataOriginMap =
        Map<String, dynamic>.from(map['dataOrigin'] ?? {});
    Map<String, dynamic> deviceMap =
        Map<String, dynamic>.from(map['device'] ?? {});
    return Metadata(
      id: map['id'] as String,
      dataOrigin: DataOrigin(dataOriginMap['packageName'] as String),
      clientRecordId: map['clientRecordId'] as String?,
      clientRecordVersion: map['clientRecordVersion'] as int,
      device: Device(
          manufacturer: deviceMap['manufacturer'] as String?,
          model: deviceMap['model'] as String?,
          type: DeviceTypes.values[deviceMap['type'] as int]),
      recordingMethod: RecordingMethod.values[map['recordingMethod'] as int],
    );
  }
}

enum RecordingMethod {
  unknown,
  activelyRecorded,
  automaticallyRecorded,
  manualEntry,
}
