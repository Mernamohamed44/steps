import 'package:dio/dio.dart';
import 'package:steps/models/weather_model.dart';
import 'package:steps/shared/constants/constants.dart';

class ApiWeather {
  Dio? dio;
  ApiWeather() {
    BaseOptions baseOptions = BaseOptions(
        receiveTimeout: 20 * 1000,
        sendTimeout: 20 * 1000,
        receiveDataWhenStatusError: false);
    dio = Dio(baseOptions);
  }
  Future<WeatherModel> getWeather() async {
    Response response = await dio!.get(url);
    //  print(response.data);
    WeatherModel weatherModel = WeatherModel.fromJson(response.data);
    // print(weatherModel.longitude);
    return weatherModel;
  }
}
