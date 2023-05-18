import 'dart:core';

import 'package:flutter_health_connect/src/records/record.dart';

abstract class IntervalRecord extends Record {
  abstract DateTime startTime;
  abstract Duration? startZoneOffset;
  abstract DateTime endTime;
  abstract Duration? endZoneOffset;

  @override
  factory IntervalRecord.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  IntervalRecord() : super.fromMap({});
}
