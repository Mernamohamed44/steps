import 'package:intl/intl.dart';

class ProductionModel {
  String date;
  double energyProduction;
  ProductionModel({
    required this.date,
    required this.energyProduction,
  });
  factory ProductionModel.fromJson(Map<String, dynamic> json) =>
      ProductionModel(
        date: json["date"].toString(),
        energyProduction: double.parse(json["energy_production"].toString()),
      );
  static List<ProductionModel> fromListJson(List list) {
    List<ProductionModel> productionList =
        list.map((e) => ProductionModel.fromJson(e)).toList();
    List<ProductionModel> result = [];
    for (int i = 0; i < productionList.length; i++) {
      List<ProductionModel> temp = [];
      for (int j = i ; j < productionList.length; j++) {
        if (productionList[i]
            .date
            .dateTime
            .sameDay(productionList[j].date.dateTime)) {
          temp.add(productionList[j]);
          productionList.removeAt(j);
        }
      }
      double sum = 0;
      for (int k = 0; k < temp.length; k++) {
        sum += temp[k].energyProduction;
      }
      result.add(ProductionModel(
        date: productionList[i].date,
        energyProduction: sum / temp.length,
      ));
    }

    result.forEach((element) {
      print(element.toString());
    });
    return result;
  }

  @override
  String toString() {
    return "$date:    $energyProduction";
  }
}

extension DateTimeExtension on String {
  DateTime get dateTime {
    final formatter = DateFormat('EEE, d MMM yyyy HH:mm:ss');
    return formatter.parse(this);
  }
}

extension DateTimeCompareExtension on DateTime {
  bool sameDay(DateTime date) =>
      year == date.year && month == date.month && day == date.day;
}

extension IntNotZeroExtension on int {
  int get notZero => this + 1;
}
