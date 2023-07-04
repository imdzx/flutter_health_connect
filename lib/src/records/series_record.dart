import 'package:flutter_health_connect/src/records/interval_record.dart';

abstract class SeriesRecord<E> extends IntervalRecord {
  abstract List<E> samples;
}
