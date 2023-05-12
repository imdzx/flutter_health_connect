import 'package:flutter_health_connect/src/records/exercise_session_record.dart';

class ExerciseSegment {
  DateTime startTime;
  DateTime endTime;
  ExerciseSegmentType segmentType;
  int repetitions;

  ExerciseSegment({
    required this.startTime,
    required this.endTime,
    required this.segmentType,
    this.repetitions = 0,
  })  : assert(startTime.isBefore(endTime),
            "startTime must not be after endTime."),
        assert(repetitions >= 0,
            "repetitions must be greater than or equal to 0.");

  bool isCompatibleWith(ExerciseType sessionType) {
    if (_universalSessionTypes.contains(sessionType)) {
      return true;
    } else if (_universalSessionTypes.contains(segmentType)) {
      return true;
    }
    return _sessionToSessionMapping[sessionType]!.contains(segmentType);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSegment &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          segmentType == other.segmentType &&
          repetitions == other.repetitions;

  @override
  int get hashCode =>
      startTime.hashCode ^
      endTime.hashCode ^
      segmentType.hashCode ^
      repetitions.hashCode;

  static const Set<ExerciseType> _universalSessionTypes = {
    ExerciseType.bootCamp,
    ExerciseType.highIntensityIntervalTraining,
    ExerciseType.otherWorkout,
  };

  static const Set<ExerciseSegmentType> _universalSegments = {
    ExerciseSegmentType.otherWorkout,
    ExerciseSegmentType.pause,
    ExerciseSegmentType.rest,
    ExerciseSegmentType.stretching,
    ExerciseSegmentType.unknown,
  };

  static const Set<ExerciseSegmentType> _exerciseSegments = {
    ExerciseSegmentType.armCurl,
    ExerciseSegmentType.backExtension,
    ExerciseSegmentType.ballSlam,
    ExerciseSegmentType.barbellShoulderPress,
    ExerciseSegmentType.benchPress,
    ExerciseSegmentType.benchSitUp,
    ExerciseSegmentType.burpee,
    ExerciseSegmentType.crunch,
    ExerciseSegmentType.deadlift,
    ExerciseSegmentType.doubleArmTricepsExtension,
    ExerciseSegmentType.dumbbellCurlLeftArm,
    ExerciseSegmentType.dumbbellCurlRightArm,
    ExerciseSegmentType.dumbbellFrontRaise,
    ExerciseSegmentType.dumbbellLateralRaise,
    ExerciseSegmentType.dumbbellRow,
    ExerciseSegmentType.dumbbellTricepsExtensionLeftArm,
    ExerciseSegmentType.dumbbellTricepsExtensionRightArm,
    ExerciseSegmentType.dumbbellTricepsExtensionTwoArm,
    ExerciseSegmentType.forwardTwist,
    ExerciseSegmentType.frontRaise,
    ExerciseSegmentType.hipThrust,
    ExerciseSegmentType.hulaHoop,
    ExerciseSegmentType.jumpRope,
    ExerciseSegmentType.jumpingJack,
    ExerciseSegmentType.kettlebellSwing,
    ExerciseSegmentType.lateralRaise,
    ExerciseSegmentType.latPullDown,
    ExerciseSegmentType.legCurl,
    ExerciseSegmentType.legExtension,
    ExerciseSegmentType.legPress,
    ExerciseSegmentType.legRaise,
    ExerciseSegmentType.lunge,
    ExerciseSegmentType.mountainClimber,
    ExerciseSegmentType.plank,
    ExerciseSegmentType.pullUp,
    ExerciseSegmentType.punch,
    ExerciseSegmentType.shoulderPress,
    ExerciseSegmentType.singleArmTricepsExtension,
    ExerciseSegmentType.sitUp,
    ExerciseSegmentType.squat,
    ExerciseSegmentType.upperTwist,
    ExerciseSegmentType.weightlifting,
  };

  static const Set<ExerciseSegmentType> _swimmingSegments = {
    ExerciseSegmentType.swimmingBackstroke,
    ExerciseSegmentType.swimmingBreaststroke,
    ExerciseSegmentType.swimmingButterfly,
    ExerciseSegmentType.swimmingFreestyle,
    ExerciseSegmentType.swimmingMixed,
    ExerciseSegmentType.swimmingOther
  };

  static const Map<ExerciseType, Set<ExerciseSegmentType>>
      _sessionToSessionMapping = {
    ExerciseType.biking: {ExerciseSegmentType.biking},
    ExerciseType.bikingStationary: {ExerciseSegmentType.bikingStationary},
    ExerciseType.calisthenics: _exerciseSegments,
    ExerciseType.elliptical: {ExerciseSegmentType.elliptical},
    ExerciseType.exerciseClass: {
      ExerciseSegmentType.yoga,
      ExerciseSegmentType.bikingStationary,
      ExerciseSegmentType.pilates,
      ExerciseSegmentType.highIntensityIntervalTraining
    },
    ExerciseType.gymnastics: _exerciseSegments,
    ExerciseType.hiking: {
      ExerciseSegmentType.walking,
      ExerciseSegmentType.wheelchair
    },
    ExerciseType.pilates: {ExerciseSegmentType.pilates},
    ExerciseType.rowingMachine: {ExerciseSegmentType.rowingMachine},
    ExerciseType.running: {
      ExerciseSegmentType.running,
      ExerciseSegmentType.walking
    },
    ExerciseType.runningTreadmill: {ExerciseSegmentType.runningTreadmill},
    ExerciseType.strengthTraining: _exerciseSegments,
    ExerciseType.stairClimbing: {ExerciseSegmentType.stairClimbing},
    ExerciseType.stairClimbingMachine: {
      ExerciseSegmentType.stairClimbingMachine
    },
    ExerciseType.swimmingOpenWater: {
      ExerciseSegmentType.swimmingOpenWater,
      ..._swimmingSegments
    },
    ExerciseType.swimmingPool: {
      ExerciseSegmentType.swimmingPool,
      ..._swimmingSegments
    },
    ExerciseType.walking: {ExerciseSegmentType.walking},
    ExerciseType.wheelchair: {ExerciseSegmentType.wheelchair},
    ExerciseType.weightlifting: _exerciseSegments,
    ExerciseType.yoga: {ExerciseSegmentType.yoga},
  };
}

enum ExerciseSegmentType {
  unknown(0),
  armCurl(1),
  backExtension(2),
  ballSlam(3),
  barbellShoulderPress(4),
  benchPress(5),
  benchSitUp(6),
  biking(7),
  bikingStationary(8),
  burpee(9),
  crunch(10),
  deadlift(11),
  doubleArmTricepsExtension(12),
  dumbbellCurlLeftArm(13),
  dumbbellCurlRightArm(14),
  dumbbellFrontRaise(15),
  dumbbellLateralRaise(16),
  dumbbellRow(17),
  dumbbellTricepsExtensionLeftArm(18),
  dumbbellTricepsExtensionRightArm(19),
  dumbbellTricepsExtensionTwoArm(20),
  elliptical(21),
  forwardTwist(22),
  frontRaise(23),
  highIntensityIntervalTraining(24),
  hipThrust(25),
  hulaHoop(26),
  jumpingJack(27),
  jumpRope(28),
  kettlebellSwing(29),
  lateralRaise(30),
  latPullDown(31),
  legCurl(32),
  legExtension(33),
  legPress(34),
  legRaise(35),
  lunge(36),
  mountainClimber(37),
  otherWorkout(38),
  pause(39),
  pilates(40),
  plank(41),
  pullUp(42),
  punch(43),
  rest(44),
  rowingMachine(45),
  running(46),
  runningTreadmill(47),
  shoulderPress(48),
  singleArmTricepsExtension(49),
  sitUp(50),
  squat(51),
  stairClimbing(52),
  stairClimbingMachine(53),
  stretching(54),
  swimmingBackstroke(55),
  swimmingBreaststroke(56),
  swimmingButterfly(57),
  swimmingFreestyle(58),
  swimmingMixed(59),
  swimmingOpenWater(60),
  swimmingOther(61),
  swimmingPool(62),
  upperTwist(63),
  walking(64),
  weightlifting(65),
  wheelchair(66),
  yoga(67);

  final int value;

  const ExerciseSegmentType(this.value);
}
