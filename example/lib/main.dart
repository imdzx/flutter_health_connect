import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // List<HealthConnectDataType> types = [
  //   HealthConnectDataType.ActiveCaloriesBurned,
  //   HealthConnectDataType.BasalBodyTemperature,
  //   HealthConnectDataType.BasalMetabolicRate,
  //   HealthConnectDataType.BloodGlucose,
  //   HealthConnectDataType.BloodPressure,
  //   HealthConnectDataType.BodyFat,
  //   HealthConnectDataType.BodyTemperature,
  //   HealthConnectDataType.BodyWaterMass,
  //   HealthConnectDataType.BoneMass,
  //   HealthConnectDataType.CervicalMucus,
  //   HealthConnectDataType.CyclingPedalingCadence,
  //   HealthConnectDataType.Distance,
  //   HealthConnectDataType.ElevationGained,
  //   HealthConnectDataType.ExerciseSession,
  //   HealthConnectDataType.FloorsClimbed,
  //   HealthConnectDataType.HeartRate,
  //   HealthConnectDataType.HeartRateVariabilityRmssd,
  //   HealthConnectDataType.Height,
  //   HealthConnectDataType.Hydration,
  //   HealthConnectDataType.IntermenstrualBleeding,
  //   HealthConnectDataType.LeanBodyMass,
  //   HealthConnectDataType.MenstruationFlow,
  //   HealthConnectDataType.Nutrition,
  //   HealthConnectDataType.OvulationTest,
  //   HealthConnectDataType.OxygenSaturation,
  //   HealthConnectDataType.Power,
  //   HealthConnectDataType.RespiratoryRate,
  //   HealthConnectDataType.RestingHeartRate,
  //   HealthConnectDataType.SexualActivity,
  //   HealthConnectDataType.SleepSession,
  //   HealthConnectDataType.SleepStage,
  //   HealthConnectDataType.Speed,
  //   HealthConnectDataType.StepsCadence,
  //   HealthConnectDataType.Steps,
  //   HealthConnectDataType.TotalCaloriesBurned,
  //   HealthConnectDataType.Vo2Max,
  //   HealthConnectDataType.Weight,
  //   HealthConnectDataType.WheelchairPushes,
  // ];

  List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    HealthConnectDataType.ExerciseSession,
    // HealthConnectDataType.HeartRate,
    // HealthConnectDataType.SleepSession,
    // HealthConnectDataType.OxygenSaturation,
    // HealthConnectDataType.RespiratoryRate,
  ];

  bool readOnly = true;
  String resultText = '';

  String token = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Health Connect'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.isApiSupported();
                resultText = 'isApiSupported: $result';
                _updateResultText();
              },
              child: const Text('isApiSupported'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.isAvailable();
                resultText = 'isAvailable: $result';
                _updateResultText();
              },
              child: const Text('Check installed'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await HealthConnectFactory.installHealthConnect();
                  resultText = 'Install activity started';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();
              },
              child: const Text('Install Health Connect'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await HealthConnectFactory.openHealthConnectSettings();
                  resultText = 'Settings activity started';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();
              },
              child: const Text('Open Health Connect Settings'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.hasPermissions(
                  types,
                  readOnly: readOnly,
                );
                resultText = 'hasPermissions: $result';
                _updateResultText();
              },
              child: const Text('Has Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  token = await HealthConnectFactory.getChangesToken(types);
                  resultText = 'token: $token';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();
              },
              child: const Text('Get Changes Token'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var result = await HealthConnectFactory.getChanges(token);
                  resultText = 'token: $result';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();
              },
              child: const Text('Get Changes'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var result = await HealthConnectFactory.requestPermissions(
                    types,
                    //readOnly: readOnly,
                  );
                  resultText = 'requestPermissions: $result';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();
              },
              child: const Text('Request Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                var startTime =
                    DateTime.now().subtract(const Duration(days: 4));
                var endTime = DateTime.now();
                try {
                  final requests = <Future>[];
                  Map<String, dynamic> typePoints = {};
                  for (var type in types) {
                    requests.add(HealthConnectFactory.getRecords(
                      type: type,
                      startTime: startTime,
                      endTime: endTime,
                    ).then((value) => typePoints.addAll({type.name: value})));
                  }
                  await Future.wait(requests);
                  resultText = '$typePoints';
                } catch (e, s) {
                  resultText = '$e:$s'.toString();
                }
                _updateResultText();
              },
              child: const Text('Get Record'),
            ),
            ElevatedButton(
              onPressed: () async {
                var startTime =
                    DateTime.now().subtract(const Duration(seconds: 5));
                var endTime = DateTime.now();
                StepsRecord stepsRecord = StepsRecord(
                  startTime: startTime,
                  endTime: endTime,
                  count: 5,
                );
                ExerciseSessionRecord exerciseSessionRecord =
                    ExerciseSessionRecord(
                  startTime: startTime,
                  endTime: endTime,
                  exerciseType: ExerciseType.walking,
                );
                try {
                  final requests = <Future>[];
                  Map<String, dynamic> typePoints = {};
                  requests.add(HealthConnectFactory.writeData(
                    type: HealthConnectDataType.Steps,
                    data: [stepsRecord],
                  ).then((value) => typePoints.addAll(
                      {HealthConnectDataType.Steps.name: stepsRecord})));

                  requests.add(HealthConnectFactory.writeData(
                    type: HealthConnectDataType.ExerciseSession,
                    data: [exerciseSessionRecord],
                  ).then((value) => typePoints.addAll({
                        HealthConnectDataType.ExerciseSession.name:
                            exerciseSessionRecord
                      })));
                  await Future.wait(requests);
                  resultText = '$typePoints';
                } catch (e, s) {
                  resultText = '$e:$s'.toString();
                }
                _updateResultText();
              },
              child: const Text('Send Record'),
            ),
            ElevatedButton(
              onPressed: () async {
                var startTime =
                    DateTime.now().subtract(const Duration(days: 1));
                var endTime = DateTime.now();
                try {
                  var result = await HealthConnectFactory.aggregate(
                    aggregationKeys: [
                      StepsRecord.aggregationKeyCountTotal,
                      ExerciseSessionRecord.aggregationKeyExerciseDurationTotal,
                    ],
                    startTime: startTime,
                    endTime: endTime,
                  );
                  resultText = '$result';
                } catch (e, s) {
                  resultText = '$e:$s'.toString();
                }
                _updateResultText();
              },
              child: const Text('Get aggregated data'),
            ),
            Text(resultText),
          ],
        ),
      ),
    );
  }

  void _updateResultText() {
    setState(() {});
  }
}
