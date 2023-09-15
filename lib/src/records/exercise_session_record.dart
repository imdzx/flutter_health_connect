import 'package:flutter_health_connect/src/records/interval_record.dart';

import 'exercise_lap.dart';
import 'exercise_route.dart';
import 'exercise_segment.dart';
import 'metadata/metadata.dart';

class ExerciseSessionRecord extends IntervalRecord {
  /// Unit: seconds
  static const String aggregationKeyExerciseDurationTotal =
      'ExerciseSessionRecordExerciseDurationTotal';

  @override
  DateTime endTime;
  @override
  Duration? endZoneOffset;
  @override
  DateTime startTime;
  @override
  Duration? startZoneOffset;
  @override
  Metadata metadata;
  ExerciseType exerciseType;
  String? title;
  String? notes;
  List<ExerciseSegment> segments;
  List<ExerciseLap> laps;
  ExerciseRoute? route;
  bool hasRoute;

  ExerciseSessionRecord({
    required this.endTime,
    this.endZoneOffset,
    metadata,
    required this.startTime,
    this.startZoneOffset,
    required this.exerciseType,
    this.title,
    this.notes,
    this.segments = const [],
    this.laps = const [],
    this.route,
  })  : metadata = metadata ?? Metadata.empty(),
        hasRoute = route != null {
    assert(startTime.isBefore(endTime), "startTime must not be after endTime.");
    if (segments.isNotEmpty) {
      var sortedSegments = segments
        ..sort((a, b) => a.startTime.compareTo(b.startTime));
      for (int i = 0; i < sortedSegments.length - 1; i++) {
        assert(
            !sortedSegments[i].endTime.isAfter(sortedSegments[i + 1].startTime),
            "segments can not overlap.");
      }
      // check all segments are within parent session duration
      assert(!sortedSegments.first.startTime.isBefore(startTime),
          "segments can not be out of parent time range.");
      assert(!sortedSegments.last.endTime.isAfter(endTime),
          "segments can not be out of parent time range.");
      for (var segment in sortedSegments) {
        assert(segment.isCompatibleWith(exerciseType),
            "segmentType and sessionType is not compatible.");
      }
    }
    if (laps.isNotEmpty) {
      var sortedLaps = laps.toList()
        ..sort((a, b) => a.startTime.compareTo(b.startTime));
      for (int i = 0; i < sortedLaps.length - 1; i++) {
        assert(!sortedLaps[i].endTime.isAfter(sortedLaps[i + 1].startTime),
            "laps can not overlap.");
      }
      // check all laps are within parent session duration
      assert(!sortedLaps.first.startTime.isBefore(startTime),
          "laps can not be out of parent time range.");
      assert(!sortedLaps.last.endTime.isAfter(endTime),
          "laps can not be out of parent time range.");
    }
    assert(route == null || hasRoute,
        "hasRoute must be true if the route is not null");
    if (route != null) {
      assert(route!.isWithin(startTime, endTime),
          "route can not be out of parent time range.");
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSessionRecord &&
          endTime == other.endTime &&
          endZoneOffset == other.endZoneOffset &&
          startTime == other.startTime &&
          startZoneOffset == other.startZoneOffset;

  @override
  int get hashCode =>
      endTime.hashCode ^
      endZoneOffset.hashCode ^
      startTime.hashCode ^
      startZoneOffset.hashCode;

  @override
  Map<String, dynamic> toMap() {
    return {
      'endTime': endTime.toUtc().toIso8601String(),
      'endZoneOffset': endZoneOffset?.inHours,
      'startTime': startTime.toUtc().toIso8601String(),
      'startZoneOffset': startZoneOffset?.inHours,
      'metadata': metadata.toMap(),
      'exerciseType': exerciseType.value,
      'title': title,
      'notes': notes,
      'segments': segments.map((e) => e.toMap()).toList(),
      'laps': laps.map((e) => e.toMap()).toList(),
      'route': route?.toMap(),
      'hasRoute': hasRoute,
    };
  }

  @override
  factory ExerciseSessionRecord.fromMap(Map<String, dynamic> map) {
    return ExerciseSessionRecord(
      startTime: DateTime.parse(map['startTime']),
      startZoneOffset: map['startZoneOffset'] != null
          ? Duration(hours: map['startZoneOffset'] as int)
          : null,
      endTime: DateTime.parse(map['endTime']),
      endZoneOffset: map['endZoneOffset'] != null
          ? Duration(hours: map['endZoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(Map<String, dynamic>.from(map['metadata'])),
      exerciseType: ExerciseType.fromValue(map['exerciseType']),
      title: map['title'],
      notes: map['notes'],
      segments: List<ExerciseSegment>.from(
          map['segments']?.map((x) => ExerciseSegment.fromMap(x))),
      laps: List<ExerciseLap>.from(
          map['laps']?.map((x) => ExerciseLap.fromMap(x))),
      route: map['route'] != null ? ExerciseRoute.fromMap(map['route']) : null,
    );
  }

  @override
  String toString() {
    return 'ExerciseSessionRecord{endTime: $endTime, endZoneOffset: $endZoneOffset, startTime: $startTime, startZoneOffset: $startZoneOffset, metadata: $metadata, exerciseType: $exerciseType, title: $title, notes: $notes, segments: $segments, laps: $laps, route: $route, hasRoute: $hasRoute}';
  }
}

enum ExerciseType {
  otherWorkout(0),
  badminton(2),
  baseball(4),
  basketball(5),
  biking(8),
  bikingStationary(9),
  bootCamp(10),
  boxing(11),
  calisthenics(13),
  cricket(14),
  dancing(16),
  elliptical(25),
  exerciseClass(26),
  fencing(27),
  footballAmerican(28),
  footballAustralian(29),
  frisbeeDisc(31),
  golf(32),
  guidedBreathing(33),
  gymnastics(34),
  handball(35),
  highIntensityIntervalTraining(36),
  hiking(37),
  iceHockey(38),
  iceSkating(39),
  martialArts(44),
  paddling(46),
  paragliding(47),
  pilates(48),
  racquetball(50),
  rockClimbing(51),
  rollerHockey(52),
  rowing(53),
  rowingMachine(54),
  rugby(55),
  running(56),
  runningTreadmill(57),
  sailing(58),
  scubaDiving(59),
  skating(60),
  skiing(61),
  snowboarding(62),
  snowshoeing(63),
  soccer(64),
  softball(65),
  squash(66),
  stairClimbing(68),
  stairClimbingMachine(69),
  strengthTraining(70),
  stretching(71),
  surfing(72),
  swimmingOpenWater(73),
  swimmingPool(74),
  tableTennis(75),
  tennis(76),
  volleyball(78),
  walking(79),
  waterPolo(80),
  weightlifting(81),
  wheelchair(82),
  yoga(83);

  final int value;

  const ExerciseType(this.value);

  factory ExerciseType.fromValue(int value) {
    return values.firstWhere((e) => e.value == value,
        orElse: () => otherWorkout);
  }

  @override
  String toString() {
    switch (this) {
      case ExerciseType.otherWorkout:
        return 'Other Workout';
      case ExerciseType.badminton:
        return 'Badminton';
      case ExerciseType.baseball:
        return 'Baseball';
      case ExerciseType.basketball:
        return 'Basketball';
      case ExerciseType.biking:
        return 'Biking';
      case ExerciseType.bikingStationary:
        return 'Stationary Biking';
      case ExerciseType.bootCamp:
        return 'BootCamp';
      case ExerciseType.boxing:
        return 'Boxing';
      case ExerciseType.calisthenics:
        return 'Calisthenics';
      case ExerciseType.cricket:
        return 'Cricket';
      case ExerciseType.dancing:
        return 'Dancing';
      case ExerciseType.elliptical:
        return 'Elliptical';
      case ExerciseType.exerciseClass:
        return 'Exercise Class';
      case ExerciseType.fencing:
        return 'Fencing';
      case ExerciseType.footballAmerican:
        return 'American Football';
      case ExerciseType.footballAustralian:
        return 'Australian Football';
      case ExerciseType.frisbeeDisc:
        return 'Frisbee Disc';
      case ExerciseType.golf:
        return 'Golf';
      case ExerciseType.guidedBreathing:
        return 'Guided Breathing';
      case ExerciseType.gymnastics:
        return 'Gymnastics';
      case ExerciseType.handball:
        return 'Handball';
      case ExerciseType.highIntensityIntervalTraining:
        return 'High Intensity Interval Training';
      case ExerciseType.hiking:
        return 'Hiking';
      case ExerciseType.iceHockey:
        return 'Ice Hockey';
      case ExerciseType.iceSkating:
        return 'Ice Skating';
      case ExerciseType.martialArts:
        return 'Martial Arts';
      case ExerciseType.paddling:
        return 'Paddling';
      case ExerciseType.paragliding:
        return 'Paragliding';
      case ExerciseType.pilates:
        return 'Pilates';
      case ExerciseType.racquetball:
        return 'Racquetball';
      case ExerciseType.rockClimbing:
        return 'Rock Climbing';
      case ExerciseType.rollerHockey:
        return 'Roller Hockey';
      case ExerciseType.rowing:
        return 'Rowing';
      case ExerciseType.rowingMachine:
        return 'Rowing Machine';
      case ExerciseType.rugby:
        return 'Rugby';
      case ExerciseType.running:
        return 'Running';
      case ExerciseType.runningTreadmill:
        return 'Treadmill Running';
      case ExerciseType.sailing:
        return 'Sailing';
      case ExerciseType.scubaDiving:
        return 'Scuba Diving';
      case ExerciseType.skating:
        return 'Skating';
      case ExerciseType.skiing:
        return 'Skiing';
      case ExerciseType.snowboarding:
        return 'Snowboarding';
      case ExerciseType.snowshoeing:
        return 'Snowshoeing';
      case ExerciseType.soccer:
        return 'Soccer';
      case ExerciseType.softball:
        return 'Softball';
      case ExerciseType.squash:
        return 'Squash';
      case ExerciseType.stairClimbing:
        return 'Stair Climbing';
      case ExerciseType.stairClimbingMachine:
        return 'Stair Climbing Machine';
      case ExerciseType.strengthTraining:
        return 'Strength Training';
      case ExerciseType.stretching:
        return 'Stretching';
      case ExerciseType.surfing:
        return 'Surfing';
      case ExerciseType.swimmingOpenWater:
        return 'Open Water Swimming';
      case ExerciseType.swimmingPool:
        return 'Pool Swimming';
      case ExerciseType.tableTennis:
        return 'Table Tennis';
      case ExerciseType.tennis:
        return 'Tennis';
      case ExerciseType.volleyball:
        return 'Volleyball';
      case ExerciseType.walking:
        return 'Walking';
      case ExerciseType.waterPolo:
        return 'Water Polo';
      case ExerciseType.weightlifting:
        return 'Weightlifting';
      case ExerciseType.wheelchair:
        return 'Wheelchair';
      case ExerciseType.yoga:
        return 'Yoga';
    }
  }
}
