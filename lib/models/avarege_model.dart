class AverageModel {
  // {"average_energy_consumption":21.8915228801104,"average_energy_production":33.70640337844594}

  double averageEnergyConsumption;
  double averageEnergyProduction;
  AverageModel({
    required this.averageEnergyConsumption,
    required this.averageEnergyProduction,
  });
  factory AverageModel.fromJson(Map<String, dynamic> json) => AverageModel(
        averageEnergyConsumption: json['average_energy_consumption'],
        averageEnergyProduction: json['average_energy_production'],
      );
}
