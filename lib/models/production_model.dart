class ProductionModel {
  // {date: 9/11/2017 8:00, energy_production: 1.13}
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
  static List<ProductionModel> fromListJson(List list) =>
      list.map((e) => ProductionModel.fromJson(e)).toList();
}
