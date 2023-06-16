import 'package:intl/intl.dart';
import 'package:steps/network/remote/api.dart';

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

  static List<ConsumptionModel> fromListJson(List list) =>
      _formated(list.map((e) => ConsumptionModel.fromJson(e)).toList());

  static List<ConsumptionModel> _formated(List<ConsumptionModel> list) {
    List<ConsumptionModel> result=[];
    for(int i=0;i<list.length;i++){
      int number=1;
      double sum=list[i].energyConsumption;
      for(int j=i+1;j<list.length;j++){
        if(_sameDate(list[i].date,list[j].date)) {
          number++;
          sum += list[j].energyConsumption;
          list.remove(list[j]);
        }
      }
      result.add(ConsumptionModel(date: list[i].date, energyConsumption: sum/number));

    }
    print(result.length);
    return result;
  }
static  bool _sameDate(String first,String second) {
DateFormat format=DateFormat("E, d MMM yyyy HH:mm:ss");

  return format.parse(first.replaceAll("GMT", "")).difference(format.parse(second.replaceAll("GMT", ""))).inDays==0;

}}
