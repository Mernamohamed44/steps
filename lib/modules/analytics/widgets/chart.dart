import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

import '../models/chart_model.dart';

class ChartView extends StatelessWidget {
   ChartView({Key? key}) : super(key: key);
  final List<BarChartModel> data = [
    BarChartModel(
      year: "2014",
      financial: 250,
      color: Colors.blueGrey,
    ),
    BarChartModel(
      year: "2015",
      financial: 300,
      color: Colors.red,
    ),
    BarChartModel(
      year: "2016",
      financial: 100,
      color: (Colors.green),
    ),
    BarChartModel(
      year: "2017",
      financial: 450,
      color: Colors.yellow,
    ),
    BarChartModel(
      year: "2018",
      financial: 630,
      color: Colors.lightBlueAccent,
    ),
    BarChartModel(
      year: "2019",
      financial: 950,
      color: (Colors.pink),
    ),
    BarChartModel(
      year: "2020",
      financial: 400,
      color:(Colors.purple),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // List<charts.Series<BarChartModel, String>> series = [
    //   charts.Series(
    //     id: "financial",
    //     data: data,
    //     domainFn: (BarChartModel series, _) => series.year,
    //     measureFn: (BarChartModel series, _) => series.financial,
    //     colorFn: (BarChartModel series, _) => series.color,
    //   ),
    // ];
    return  Scaffold(

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        // child: VerticalBarChart(painter: null,
        //
        // ),
      ),
    );
  }
}
// series,
// animate: true,

Widget chartToRun() {
  LabelLayoutStrategy? xContainerLabelLayoutStrategy;
  ChartData chartData;
  ChartOptions chartOptions = const ChartOptions();
  // Example shows an explicit use of the DefaultIterativeLabelLayoutStrategy.
  // The xContainerLabelLayoutStrategy, if set to null or not set at all,
  //   defaults to DefaultIterativeLabelLayoutStrategy
  // Clients can also create their own LayoutStrategy.
  xContainerLabelLayoutStrategy = DefaultIterativeLabelLayoutStrategy(
    options: chartOptions,
  );
  chartData = ChartData(
    dataRows: const [
      [10.0, 20.0, 5.0, 30.0, 5.0, 20.0],
      [30.0, 60.0, 16.0, 100.0, 12.0, 120.0],
      [25.0, 40.0, 20.0, 80.0, 12.0, 90.0],
      [12.0, 30.0, 18.0, 40.0, 10.0, 30.0],
    ],
    xUserLabels: const ['Wolf', 'Deer', 'Owl', 'Mouse', 'Hawk', 'Vole'],
    dataRowsLegends: const [
      'Spring',
      'Summer',
      'Fall',
      'Winter',
    ],
    chartOptions: chartOptions,
  );
  // chartData.dataRowsDefaultColors(); // if not set, called in constructor
  var verticalBarChartContainer = VerticalBarChartTopContainer(
    chartData: chartData,
    xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
  );

  var verticalBarChart = VerticalBarChart(
    painter: VerticalBarChartPainter(
      verticalBarChartContainer: verticalBarChartContainer,
    ),
  );
  return verticalBarChart;
}