# Flutter Health Connect
![pub package](https://img.shields.io/badge/1.2.0-flutter__health__connect-blue)

Flutter plugin for Google Health Connect integration. Health Connect gives you a simple way to store and connect the data between your health and fitness apps.


## Requirements

### Android

- minSdkVersion: `26` (Recommend 28)
- compileSdkVersion: `33`
- This package requires Flutter `2.5.0` or higher.

## How to install

### Android
To interact with Health Connect within the app, declare the Health Connect package name in your `AndroidManifest.xml` file:
```
<!-- Check whether Health Connect is installed or not -->
<queries>
    <package android:name="com.google.android.apps.healthdata" />
</queries>
```

Every data type your app reads or writes needs to be declared using a permission in your manifest. For the full list of permissions and their corresponding data types, see [List of data types](https://developer.android.com/guide/health-and-fitness/health-connect/data-and-data-types/data-types).

To create the declaration, add to  regular permissions any of.
```
<uses-permission android:name="android.permission.health.READ_ACTIVE_CALORIES_BURNED"/>
<uses-permission android:name="android.permission.health.WRITE_ACTIVE_CALORIES_BURNED"/>
<uses-permission android:name="android.permission.health.READ_BASAL_BODY_TEMPERATURE"/>
<uses-permission android:name="android.permission.health.WRITE_BASAL_BODY_TEMPERATURE"/>
<uses-permission android:name="android.permission.health.READ_BASAL_METABOLIC_RATE"/>
<uses-permission android:name="android.permission.health.WRITE_BASAL_METABOLIC_RATE"/>
<uses-permission android:name="android.permission.health.READ_BLOOD_GLUCOSE"/>
<uses-permission android:name="android.permission.health.WRITE_BLOOD_GLUCOSE"/>
<uses-permission android:name="android.permission.health.READ_BLOOD_PRESSURE"/>
<uses-permission android:name="android.permission.health.WRITE_BLOOD_PRESSURE"/>
<uses-permission android:name="android.permission.health.READ_BODY_FAT"/>
<uses-permission android:name="android.permission.health.WRITE_BODY_FAT"/>
<uses-permission android:name="android.permission.health.READ_BODY_TEMPERATURE"/>
<uses-permission android:name="android.permission.health.WRITE_BODY_TEMPERATURE"/>
<uses-permission android:name="android.permission.health.READ_BONE_MASS"/>
<uses-permission android:name="android.permission.health.WRITE_BONE_MASS"/>
<uses-permission android:name="android.permission.health.READ_CERVICAL_MUCUS"/>
<uses-permission android:name="android.permission.health.WRITE_CERVICAL_MUCUS"/>
<uses-permission android:name="android.permission.health.READ_EXERCISE"/>
<uses-permission android:name="android.permission.health.WRITE_EXERCISE"/>
<uses-permission android:name="android.permission.health.READ_DISTANCE"/>
<uses-permission android:name="android.permission.health.WRITE_DISTANCE"/>
<uses-permission android:name="android.permission.health.READ_ELEVATION_GAINED"/>
<uses-permission android:name="android.permission.health.WRITE_ELEVATION_GAINED"/>
<uses-permission android:name="android.permission.health.READ_EXERCISE"/>
<uses-permission android:name="android.permission.health.WRITE_EXERCISE"/>
<uses-permission android:name="android.permission.health.READ_FLOORS_CLIMBED"/>
<uses-permission android:name="android.permission.health.WRITE_FLOORS_CLIMBED"/>
<uses-permission android:name="android.permission.health.READ_HEART_RATE"/>
<uses-permission android:name="android.permission.health.WRITE_HEART_RATE"/>
<uses-permission android:name="android.permission.health.READ_HEIGHT"/>
<uses-permission android:name="android.permission.health.WRITE_HEIGHT"/>
<uses-permission android:name="android.permission.health.READ_HYDRATION"/>
<uses-permission android:name="android.permission.health.WRITE_HYDRATION"/>
<uses-permission android:name="android.permission.health.READ_LEAN_BODY_MASS"/>
<uses-permission android:name="android.permission.health.WRITE_LEAN_BODY_MASS"/>
<uses-permission android:name="android.permission.health.READ_MENSTRUATION"/>
<uses-permission android:name="android.permission.health.WRITE_MENSTRUATION"/>
<uses-permission android:name="android.permission.health.READ_MENSTRUATION"/>
<uses-permission android:name="android.permission.health.WRITE_MENSTRUATION"/>
<uses-permission android:name="android.permission.health.READ_NUTRITION"/>
<uses-permission android:name="android.permission.health.WRITE_NUTRITION"/>
<uses-permission android:name="android.permission.health.READ_OVULATION_TEST"/>
<uses-permission android:name="android.permission.health.WRITE_OVULATION_TEST"/>
<uses-permission android:name="android.permission.health.READ_OXYGEN_SATURATION"/>
<uses-permission android:name="android.permission.health.WRITE_OXYGEN_SATURATION"/>
<uses-permission android:name="android.permission.health.READ_POWER"/>
<uses-permission android:name="android.permission.health.WRITE_POWER"/>
<uses-permission android:name="android.permission.health.READ_RESPIRATORY_RATE"/>
<uses-permission android:name="android.permission.health.WRITE_RESPIRATORY_RATE"/>
<uses-permission android:name="android.permission.health.READ_RESTING_HEART_RATE"/>
<uses-permission android:name="android.permission.health.WRITE_RESTING_HEART_RATE"/>
<uses-permission android:name="android.permission.health.READ_SEXUAL_ACTIVITY"/>
<uses-permission android:name="android.permission.health.WRITE_SEXUAL_ACTIVITY"/>
<uses-permission android:name="android.permission.health.READ_SLEEP"/>
<uses-permission android:name="android.permission.health.WRITE_SLEEP"/>
<uses-permission android:name="android.permission.health.READ_SLEEP"/>
<uses-permission android:name="android.permission.health.WRITE_SLEEP"/>
<uses-permission android:name="android.permission.health.READ_SPEED"/>
<uses-permission android:name="android.permission.health.WRITE_SPEED"/>
<uses-permission android:name="android.permission.health.READ_STEPS"/>
<uses-permission android:name="android.permission.health.WRITE_STEPS"/>
<uses-permission android:name="android.permission.health.READ_STEPS"/>
<uses-permission android:name="android.permission.health.WRITE_STEPS"/>
<uses-permission android:name="android.permission.health.READ_TOTAL_CALORIES_BURNED"/>
<uses-permission android:name="android.permission.health.WRITE_TOTAL_CALORIES_BURNED"/>
<uses-permission android:name="android.permission.health.READ_VO2_MAX"/>
<uses-permission android:name="android.permission.health.WRITE_VO2_MAX"/>
<uses-permission android:name="android.permission.health.READ_WEIGHT"/>
<uses-permission android:name="android.permission.health.WRITE_WEIGHT"/>
<uses-permission android:name="android.permission.health.READ_WHEELCHAIR_PUSHES"/>
<uses-permission android:name="android.permission.health.WRITE_WHEELCHAIR_PUSHES"/>
```
Inside your MainActivity declaration add a reference to `health_permissions` and an intent filter for the Health Connect permissions action
```
<activity android:name=".MainActivity">
    <meta-data android:name="health_permissions" android:resource="@array/health_permissions" />

    <intent-filter>
        <action android:name="androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE" />
    </intent-filter>
</activity>
```

Health connect developer toolbox: http://goo.gle/health-connect-toolbox

## Usage
```dart
import 'package:flutter_health_connect/flutter_health_connect.dart';
```

## Example

````dart
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
  //   HealthConnectDataType.BoneMass,
  //   HealthConnectDataType.CervicalMucus,
  //   HealthConnectDataType.CyclingPedalingCadence,
  //   HealthConnectDataType.Distance,
  //   HealthConnectDataType.ElevationGained,
  //   HealthConnectDataType.ExerciseEvent,
  //   HealthConnectDataType.ExerciseLap,
  //   HealthConnectDataType.ExerciseRepetitions,
  //   HealthConnectDataType.ExerciseSession,
  //   HealthConnectDataType.FloorsClimbed,
  //   HealthConnectDataType.HeartRate,
  //   HealthConnectDataType.Height,
  //   HealthConnectDataType.HipCircumference,
  //   HealthConnectDataType.Hydration,
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
  //   HealthConnectDataType.SwimmingStrokes,
  //   HealthConnectDataType.TotalCaloriesBurned,
  //   HealthConnectDataType.Vo2Max,
  //   HealthConnectDataType.WaistCircumference,
  //   HealthConnectDataType.Weight,
  //   HealthConnectDataType.WheelchairPushes,
  // ];

  List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    HealthConnectDataType.HeartRate,
    HealthConnectDataType.SleepSession,
    HealthConnectDataType.OxygenSaturation,
    HealthConnectDataType.RespiratoryRate,
  ];

  bool readOnly = false;
  String resultText = '';

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
                await HealthConnectFactory.installHealthConnect();
              },
              child: const Text('Install Health Connect'),
            ),
            ElevatedButton(
              onPressed: () async {
                await HealthConnectFactory.openHealthConnectSettings();
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
                var result = await HealthConnectFactory.requestPermissions(
                  types,
                  readOnly: readOnly,
                );
                resultText = 'requestPermissions: $result';
                _updateResultText();
              },
              child: const Text('Request Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                var startTime =
                DateTime.now().subtract(const Duration(days: 4));
                var endTime = DateTime.now();
                var results = await HealthConnectFactory.getRecord(
                  types: types,
                  startTime: startTime,
                  endTime: endTime,
                );
                // results.forEach((key, value) {
                //   if (key == HealthConnectDataType.Steps.name) {
                //     print(value);
                //   }
                // });
                resultText = '\ntype: $types\n\n$results';
                _updateResultText();
              },
              child: const Text('Get Record'),
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
````

