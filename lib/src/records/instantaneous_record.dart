import 'dart:core';

import 'package:flutter_health_connect/src/records/record.dart';

abstract class InstantaneousRecord extends Record {
  abstract DateTime time;
  abstract Duration? zoneOffset;

  @override
  factory InstantaneousRecord.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  InstantaneousRecord() : super.fromMap({});
}
