import 'package:flutter_health_connect/src/records/interval_record.dart';

import 'exercise_lap.dart';
import 'exercise_route.dart';
import 'exercise_segment.dart';
import 'metadata/metadata.dart';

class ExerciseSessionRecord extends IntervalRecord {
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
      'endTime': endTime.millisecondsSinceEpoch,
      'endZoneOffset': endZoneOffset?.inHours,
      'startTime': startTime.millisecondsSinceEpoch,
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
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
      startZoneOffset: map['startZoneOffset'] != null
          ? Duration(hours: map['startZoneOffset'] as int)
          : null,
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
      endZoneOffset: map['endZoneOffset'] != null
          ? Duration(hours: map['endZoneOffset'] as int)
          : null,
      metadata: Metadata.fromMap(map['metadata']),
      exerciseType: ExerciseType.values[map['exerciseType']],
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

  @override
  String toString() {
    switch (this) {
      case ExerciseType.otherWorkout:
        return 'other_workout';
      case ExerciseType.badminton:
        return 'badminton';
      case ExerciseType.baseball:
        return 'baseball';
      case ExerciseType.basketball:
        return 'basketball';
      case ExerciseType.biking:
        return 'biking';
      case ExerciseType.bikingStationary:
        return 'biking_stationary';
      case ExerciseType.bootCamp:
        return 'bootCamp';
      case ExerciseType.boxing:
        return 'boxing';
      case ExerciseType.calisthenics:
        return 'calisthenics';
      case ExerciseType.cricket:
        return 'cricket';
      case ExerciseType.dancing:
        return 'dancing';
      case ExerciseType.elliptical:
        return 'elliptical';
      case ExerciseType.exerciseClass:
        return 'exercise_class';
      case ExerciseType.fencing:
        return 'fencing';
      case ExerciseType.footballAmerican:
        return 'football_american';
      case ExerciseType.footballAustralian:
        return 'football_australian';
      case ExerciseType.frisbeeDisc:
        return 'frisbee_disc';
      case ExerciseType.golf:
        return 'golf';
      case ExerciseType.guidedBreathing:
        return 'guided_breathing';
      case ExerciseType.gymnastics:
        return 'gymnastics';
      case ExerciseType.handball:
        return 'handball';
      case ExerciseType.highIntensityIntervalTraining:
        return 'high_intensity_interval_training';
      case ExerciseType.hiking:
        return 'hiking';
      case ExerciseType.iceHockey:
        return 'ice_hockey';
      case ExerciseType.iceSkating:
        return 'ice_skating';
      case ExerciseType.martialArts:
        return 'martial_arts';
      case ExerciseType.paddling:
        return 'paddling';
      case ExerciseType.paragliding:
        return 'paragliding';
      case ExerciseType.pilates:
        return 'pilates';
      case ExerciseType.racquetball:
        return 'racquetball';
      case ExerciseType.rockClimbing:
        return 'rock_climbing';
      case ExerciseType.rollerHockey:
        return 'roller_hockey';
      case ExerciseType.rowing:
        return 'rowing';
      case ExerciseType.rowingMachine:
        return 'rowing_machine';
      case ExerciseType.rugby:
        return 'rugby';
      case ExerciseType.running:
        return 'running';
      case ExerciseType.runningTreadmill:
        return 'running_treadmill';
      case ExerciseType.sailing:
        return 'sailing';
      case ExerciseType.scubaDiving:
        return 'scuba_diving';
      case ExerciseType.skating:
        return 'skating';
      case ExerciseType.skiing:
        return 'skiing';
      case ExerciseType.snowboarding:
        return 'snowboarding';
      case ExerciseType.snowshoeing:
        return 'snowshoeing';
      case ExerciseType.soccer:
        return 'soccer';
      case ExerciseType.softball:
        return 'softball';
      case ExerciseType.squash:
        return 'squash';
      case ExerciseType.stairClimbing:
        return 'stairClimbing';
      case ExerciseType.stairClimbingMachine:
        return 'stairClimbingMachine';
      case ExerciseType.strengthTraining:
        return 'strengthTraining';
      case ExerciseType.stretching:
        return 'stretching';
      case ExerciseType.surfing:
        return 'surfing';
      case ExerciseType.swimmingOpenWater:
        return 'swimmingOpenWater';
      case ExerciseType.swimmingPool:
        return 'swimmingPool';
      case ExerciseType.tableTennis:
        return 'tableTennis';
      case ExerciseType.tennis:
        return 'tennis';
      case ExerciseType.volleyball:
        return 'volleyball';
      case ExerciseType.walking:
        return 'walking';
      case ExerciseType.waterPolo:
        return 'water_polo';
      case ExerciseType.weightlifting:
        return 'weightlifting';
      case ExerciseType.wheelchair:
        return 'wheelchair';
      case ExerciseType.yoga:
        return 'yoga';
    }
  }
}
