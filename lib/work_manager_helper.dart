import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:workmanager/workmanager.dart';

import 'models/avarege_model.dart';
import 'models/weather_model.dart';
import 'network/remote/api.dart';

abstract class WorkManagerHelper {
  @pragma('vm:entry-point')
  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      await WorkManagerHelper.task();
      return Future.value(true);
    });
  }

  static Future<void> initialize() => Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  static Future<void> register() async {
    // Periodic task registration
    await Workmanager().registerPeriodicTask(
      "periodic-task-identifier",
      "simplePeriodicTask",
      frequency: const Duration(hours: 2),
    );
  }

  static Future<void> task() async {
    final sharedPreference = await SharedPreferences.getInstance();
    try {
      //add code execution
      String? dated = sharedPreference.getString("date");
      if (dated != null) {
        DateTime date = DateTime.parse(dated);
        if (date.difference(DateTime.now()).inDays == 0 ||
            await _taskPerDay()) {
          var weather = await _taskPer2Hours();
          if (weather?.current?.windKph > 50) {
            _move(horizontal: "0", vertical: "90");
          }
          //todo: when it's raining
        } else {
          var weather = await _taskPer2Hours();
          if (weather?.current?.windKph > 50) {
            _move(horizontal: "0", vertical: "90");
          }
          //todo: when it's raining
          //todo: get the move value from the api and move around it _move(horizontal: "", vertical: "")
          sharedPreference.setBool("movement", await _taskPerDay());
          sharedPreference.setString("date", DateTime.now().toString());
        }
      }
    } catch (err) {
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

  static Future<WeatherModel?> _taskPer2Hours() async {
    StepsCubit cubit = StepsCubit();
    await cubit.getDataWeather();
    return cubit.weatherModel;
  }

  static Future<void> _move({String? horizontal, String? vertical}) =>
      StepsCubit()
          .sendMessage(horizontal: horizontal ?? "", vertical: vertical ?? "");
}
