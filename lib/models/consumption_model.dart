import 'package:intl/intl.dart';
import 'package:steps/models/production_model.dart';

class ConsumptionModel {
  String date;
  double energyConsumption;
  ConsumptionModel({
    required this.date,
    required this.energyConsumption,
  });
  factory ConsumptionModel.fromJson(Map<String, dynamic> json) =>
      ConsumptionModel(
        date: json["date"].toString(),
        energyConsumption: double.parse(json["energy_consumption"].toString()),
      );

  static List<ConsumptionModel> fromListJson(List list) {
    List<ConsumptionModel> consumptionList =
        list.map((e) => ConsumptionModel.fromJson(e)).toList();
    List<ConsumptionModel>  sec = consumptionList;
    List<ConsumptionModel> result = [];
    for (int i = 0; i < consumptionList.length; i++) {
      List<ConsumptionModel> temp = [];
      for (int j = i; j < sec.length; j++) {
        if (consumptionList[i]
            .date
            .dateTime
            .sameDay(sec[j].date.dateTime)) {
          temp.add(sec[j]);
          sec.remove(sec[j]);
        }
      }
      double sum = 0;
      for (int k = 0; k < temp.length; k++) {
        sum += temp[k].energyConsumption;
      }
      result.add(ConsumptionModel(
        date: consumptionList[i].date,
        energyConsumption: sum / temp.length,
      ));
      // consumptionList.remove(consumptionList[i]);
    }
    print(result.length);
    return result;
  }

  static List<ConsumptionModel> _formated(List<ConsumptionModel> list) {
    List<ConsumptionModel> result = [];
    for (int i = 0; i < list.length; i++) {
      int number = 1;
      double sum = list[i].energyConsumption;
      for (int j = i + 1; j < list.length; j++) {
        if (_sameDate(list[i].date, list[j].date)) {
          number++;
          sum += list[j].energyConsumption;
          list.remove(list[j]);
        }
      }
      result.add(ConsumptionModel(
          date: list[i].date, energyConsumption: sum / number));
    }
    print(result.length);
    return result;
  }

  static bool _sameDate(String first, String second) {
    DateFormat format = DateFormat("E, d MMM yyyy HH:mm:ss");

    return format
            .parse(first.replaceAll("GMT", ""))
            .difference(format.parse(second.replaceAll("GMT", "")))
            .inDays ==
        0;
  }
}
