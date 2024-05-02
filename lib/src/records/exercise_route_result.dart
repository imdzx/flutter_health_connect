import 'package:flutter_health_connect/flutter_health_connect.dart';

abstract class ExerciseRouteResult {
  ExerciseRoute? exerciseRoute;

  ExerciseRouteResult({this.exerciseRoute});

  @override
  bool operator ==(Object other) {
    if (other is Data) {
      return exerciseRoute == other.exerciseRoute;
    } else if (other is ConsentRequired) {
      return true;
    } else if (other is NoData) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode {
    return 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseRoute': exerciseRoute?.toMap(),
    };
  }

  factory ExerciseRouteResult.fromMap(Map<String, dynamic> map) {
    if (map['exerciseRoute'] == null) {
      return NoData();
    }
    return Data(
      ExerciseRoute.fromMap(Map<String, dynamic>.from(map['exerciseRoute'])),
    );
  }

  @override
  String toString() => 'ExerciseRouteResult(exerciseRoute: $exerciseRoute)';
}

class Data extends ExerciseRouteResult {
  Data(ExerciseRoute exerciseRoute) : super(exerciseRoute: exerciseRoute);
}

class ConsentRequired extends ExerciseRouteResult {
  ConsentRequired() : super();
}

class NoData extends ExerciseRouteResult {
  NoData() : super();
}
