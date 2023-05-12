import 'data_origin.dart';
import 'device.dart';

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
}

enum RecordingMethod {
  unknown,
  activelyRecorded,
  automaticallyRecorded,
  manualEntry,
}
