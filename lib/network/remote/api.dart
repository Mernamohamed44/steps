import 'package:dio/dio.dart';

import '../../models/avarege_model.dart';
import '../../models/consumption_model.dart';
import '../../models/production_model.dart';

class Api {
  Future<AverageModel> getAverage(
      {DateTime? startDate, DateTime? endDate}) async {
    Dio dio = DioFactory.getDio;
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      "start_date": startDate,
      "end_date": startDate,
    };
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await dio.fetch(_setStreamType(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    ).compose(
      dio.options,
      "/average",
      queryParameters: endDate != null ? queryParameters : {},
      data: data,
    )));
    return AverageModel.fromJson(result.data);
  }

  Future<List<ConsumptionModel>> getConsumption(
      {DateTime? startDate, DateTime? endDate}) async {
    Dio dio = DioFactory.getDio;
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      "start_date": startDate,
      "end_date": startDate,
    };
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await dio.fetch(_setStreamType(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    ).compose(
      dio.options,
      "/consumption?start_date=01/01/2020&end_date=1/02/2020",
      queryParameters: endDate != null ? queryParameters : {},
      data: data,
    )));
    return ConsumptionModel.fromListJson(result.data);
  }

  Future<List<ProductionModel>> getProduction(
      {DateTime? startDate, DateTime? endDate}) async {
    Dio dio = DioFactory.getDio;
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      "start_date": startDate,
      "end_date": startDate,
    };
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await dio.fetch(_setStreamType(Options(
      method: 'GET',
      headers: headers,
      extra: extra,
    ).compose(
      dio.options,
      "/production",
      queryParameters: endDate != null ? queryParameters : {},
      data: data,
    )));
    return ProductionModel.fromListJson(result.data);
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

abstract class DioFactory {
  static Dio get getDio {
    String url = "https://steps-api.onrender.com/energy-data";

    Dio dio = Dio();
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Accept-Language': 'ar',
    };
    dio.options = BaseOptions(
      baseUrl: url,
      headers: headers,
      sendTimeout: const Duration(minutes: 1), //60 seconds
      receiveTimeout: const Duration(minutes: 1),
      followRedirects: false,
    );

    return dio;
  }
}
