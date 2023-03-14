import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../style/costraints.dart';
import '../../../style/text_style.dart';
import 'chart.dart';

class AnalysisBox extends StatelessWidget {
  const AnalysisBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: MediaQueryHelper.sizeFromHeight(context, 3.5),
        //  width: MediaQueryHelper.sizeFromWidth(context, 3),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),

        child: Row(
          children: [
            SizedBox(
              width: MediaQueryHelper.sizeFromWidth(context, 5),
              height: 200,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Daily revenue',
                      style: AppTextStyles.analysis_titles),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('45.24', style: AppTextStyles.titles),
                  Text('+12% From week',
                      style: Theme.of(context).textTheme.caption)
                ],
              ),
            ),
            SizedBox(
              width: MediaQueryHelper.sizeFromWidth(context, 5),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Nov 29, 02:29 AM",
                    style: AppTextStyles.date,
                  ),
                  SizedBox(
                      height: 150,
                      child: SfCartesianChart(
                          backgroundColor: Colors.purpleAccent,
                          primaryXAxis: CategoryAxis(),

                          series: <LineSeries<SalesData, String>>[
                            LineSeries<SalesData, String>(
                                // Bind data source
                                dataSource: <SalesData>[
                                  SalesData('Jan', 35),
                                  SalesData('Feb', 28),
                                  SalesData('Mar', 34),
                                  SalesData('Apr', 32),
                                  SalesData('May', 40)
                                ],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales)
                          ]))
                  //   chartToRun()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
