class PredictionModel {
  String date;
  double predictedPower;
  PredictionModel({required this.date, required this.predictedPower});
  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      PredictionModel(
        date: json["date"],
        predictedPower: double.parse(json["predicted_power"].toString()),
      );
  static List<PredictionModel> fromListedJson(List list) =>
      list.map((e) => PredictionModel.fromJson(e)).toList();
}
