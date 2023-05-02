import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:steps/models/weather_model.dart';
import 'package:steps/shared/components/components.dart';

class DioHelper {
  static const String url =
      'https://api.open-meteo.com/v1/';

  static Dio dioSingleton = Dio()..options.baseUrl = url;
  static Future<Response<dynamic>> get(String path, {dynamic body}) async {
    if (FirebaseAuth.instance.currentUser!=null) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        print('YAY! Free cute dog pics!');
      } else {
        showToast(message: 'You are disconnected from the internet', state: ToastState.error);
      }
      dioSingleton.options.headers = {
        'Authorization': 'Bearer ${FirebaseAuth.instance.currentUser}',
        'Accept': 'application/json',
        'Accept-Language': 'ar',
      };
    } else {
      dioSingleton.options.headers = {
        'Accept': 'application/json',
        'Accept-Language': 'ar',
      };
    }
    print(dioSingleton.options.headers);
    final response = dioSingleton.get(path,
        queryParameters: body,
        options: Options(
          sendTimeout: Duration(minutes: 1), //60 seconds
          receiveTimeout: Duration(minutes: 1), // 60 seconds
        ));
    dioSingleton.options.headers = null;
    return response;
  }
}
