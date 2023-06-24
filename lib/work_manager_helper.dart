import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_calculator/solar_calculator.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:workmanager/workmanager.dart';

import 'models/average_model.dart';
import 'models/weather_model.dart';
import 'network/remote/api.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await WorkManagerHelper.task();
    return Future.value(true);
  });
}

abstract class WorkManagerHelper {
  static void foregroundTask(StepsCubit cubit) async {
    while (true) {
      await Future.delayed(const Duration(hours: 2));

      await task(cubit: cubit);
    }
  }

  static Future<void> initialize() => Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running.
      // Handy for debugging tasks
      );

  static Future<void> register() async {
    // Periodic task registration
    await Workmanager().registerPeriodicTask(
      "periodic-task-identifier",
      "simplePeriodicTask",
      frequency: const Duration(hours: 2),
    );
  }

  static Future<void> task({StepsCubit? cubit}) async {
    final sharedPreference = await SharedPreferences.getInstance();
    try {
      //add code execution
      String? dated = sharedPreference.getString("date");
      if (dated != null) {
        DateTime date = DateTime.parse(dated);
        if (date.difference(DateTime.now()).inDays == 0 ||
            await _taskPerDay()) {
          var weather = await _taskPer2Hours(cubit: cubit);

          if (weather?.current?.windKph > 80) {
            _move(horizontal: "0", vertical: "90", cubit: cubit);
          } else if (weather?.current?.condition?.text != "Clear") {
            _move(horizontal: "0", vertical: "0", cubit: cubit);
          } else {
            _move(horizontal: "45", vertical: "0");
          }
        } else {
          var weather = await _taskPer2Hours(cubit: cubit);
          if (weather?.current?.windKph > 80) {
            _move(horizontal: "0", vertical: "90", cubit: cubit);
          }
          if (weather?.current?.condition?.text != "Clear") {
            _move(horizontal: "0", vertical: "0", cubit: cubit);
          }
          if (!(weather?.current?.condition?.text != "Clear" ||
              weather?.current?.windKph > 80)) {
            _move(
              horizontal: azimuth.toString(),
              vertical: elevation.toString(),
              cubit: cubit,
            );
          }
        }
      }
      sharedPreference.setBool("movement", await _taskPerDay());
      sharedPreference.setString("date", DateTime.now().toString());
      print("task completed");
    } catch (err) {
      print("error: $err ");
      throw Exception(err);
    }
  }

  static Future<bool> _taskPerDay() async {
    AverageModel averageModel = await Api().getAverage();
    if (averageModel.averageEnergyConsumption <
        averageModel.averageEnergyProduction) {
      return true;
    } else {
      return false;
    }
  }

  static Future<WeatherModel?> _taskPer2Hours({StepsCubit? cubit}) async {
    await cubit?.getDataWeather();
    _aa(cubit?.weatherModel);
    return cubit?.weatherModel;
  }

  static var azimuth;
  static var elevation;

  static _aa(WeatherModel? weatherModel) {
    final latitude = weatherModel!.location!.lat;
    final longitude = weatherModel.location!.lat;
    final instant = Instant(
        year: DateTime.now().year,
        month: DateTime.now().month,
        day: DateTime.now().day,
        hour: DateTime.now().hour,
        timeZoneOffset: DateTime.now().timeZoneOffset.inHours.toDouble());
    final calc = SolarCalculator(instant, latitude!, longitude!);
    azimuth = calc.sunHorizontalPosition.azimuth.floorToDouble();
    elevation = calc.sunHorizontalPosition.elevation.floorToDouble();
  }

  static Future<void> _move(
          {String? horizontal, String? vertical, StepsCubit? cubit}) =>
      cubit != null
          ? cubit.sendMessage(
              horizontal: horizontal ?? "", vertical: vertical ?? "")
          : StepsCubit().sendMessage(
              horizontal: horizontal ?? "", vertical: vertical ?? "");

}
