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
      list.map((e) => ConsumptionModel.fromJson(e)).toList();
}
