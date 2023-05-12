import 'dart:core';

import 'package:flutter_health_connect/src/records/record.dart';

abstract class InstantaneousRecord extends Record {
  abstract DateTime time;
  abstract Duration? zoneOffset;
}
