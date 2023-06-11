import 'package:dartz/dartz.dart';

import '../../models/avarege_model.dart';
import '../../models/consumption_model.dart';
import '../../models/production_model.dart';
import 'api.dart';

abstract class Repository {
  static final Api _api = Api();
  static Future<Either<Failure, AverageModel>> getAverage(
      {DateTime? start, DateTime? end}) async {
    try {
      var result = await _api.getAverage(startDate: start, endDate: end);
      return Right(result);
    } catch (error) {
      return Left(Failure(error.toString()));
    }
  }

  static Future<Either<Failure, List<ConsumptionModel>>> getConsumption(
      {DateTime? start, DateTime? end}) async {
    try {
      var result = await _api.getConsumption(startDate: start, endDate: end);
      return Right(result);
    } catch (error) {
      print(error.toString());

      return Left(Failure(error.toString()));
    }
  }

  static Future<Either<Failure, List<ProductionModel>>> getProduction(
      {DateTime? start, DateTime? end}) async {
    try {
      var result = await _api.getProduction(startDate: start, endDate: end);
      return Right(result);
    } catch (error) {
      print(error.toString());
      return Left(Failure(error.toString()));
    }
  }
}

class Failure {
  String message;
  Failure(this.message);
}
