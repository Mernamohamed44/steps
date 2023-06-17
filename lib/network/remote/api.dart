import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../models/avarege_model.dart';
import '../../models/consumption_model.dart';
import '../../models/production_model.dart';

class Api {
  static final Dio _dio = DioFactory.getDio;
  Future<AverageModel> getAverage(
      {DateTime? startDate, DateTime? endDate}) async {
    final queryParameters = <String, dynamic>{
      "start_date":
          startDate ?? DateTime.now().subtract(const Duration(days: 14)).format,
      "end_date": endDate ?? DateTime.now().format,
    };
    Response result = await _fetch(
        method: "GET", path: "/average", queryParameters: queryParameters);

    return AverageModel.fromJson(result.data);
  }

  Future<List<ConsumptionModel>> getConsumption(
      {DateTime? startDate, DateTime? endDate}) async {
    final queryParameters = <String, dynamic>{
      "start_date": startDate ??
          DateTime.now().subtract(const Duration(days: 365)).format,
      "end_date": endDate ?? DateTime.now().format,
    };
    Response result = await _fetch(
        method: "GET", path: "/consumption", queryParameters: queryParameters);
    return ConsumptionModel.fromListJson(result.data);
  }

  Future<List<ProductionModel>> getProduction(
      {DateTime? startDate, DateTime? endDate}) async {
    final queryParameters = <String, dynamic>{
      "start_date":
          startDate ?? DateTime.now().subtract(const Duration(days: 88)).format,
      "end_date": endDate ?? DateTime.now().format,
    };

    Response result = await _fetch(
        method: "GET", path: "/production", queryParameters: queryParameters);

    return ProductionModel.fromListJson(result.data);
  }

  Future<Response<T>> _fetch<T>(
          {Map<String, dynamic>? headers,
          required String path,
          required String method,
          Map<String, dynamic>? queryParameters,
          Map<String, dynamic>? extra,
          Map<String, dynamic>? data}) async =>
      _dio.fetch(_setStreamType(Options(
        method: method,
        headers: headers,
        extra: extra,
      ).compose(
        _dio.options,
        path,
        queryParameters: queryParameters,
        data: data,
      )));
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
      receiveTimeout: const Duration(minutes: 5),
      connectTimeout: const Duration(minutes: 1),

      followRedirects: false,
    );
    if (!kReleaseMode) {
      // its debug mode so print app logs
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
    }
    return dio;
  }
}

extension DateFormate on DateTime {
  String get format {
    return "${month.toString().padLeft(2, "0")}/${day.toString().padLeft(2, "0")}/$year"
        .toString();
  }
}
