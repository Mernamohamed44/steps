import 'package:flutter/material.dart';
import 'package:steps/style/colors.dart';
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
          //  color: Colors.grey,
            borderRadius: BorderRadius.circular(20)),

        child: Row(
          children: [
            SizedBox(
              width: MediaQueryHelper.sizeFromWidth(context, 5),
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Daily revenue',
                        style: AppTextStyles.analysis_titles
                            .copyWith(color: AppColor.blacktext)),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('45.24',
                            style: AppTextStyles.titles.copyWith(
                                fontSize: 40, fontWeight: FontWeight.bold)),
                        Text(
                          'kWh',
                          style: AppTextStyles.box_icons.copyWith(
                              color: AppColor.blacktext,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Image.asset('assets/images/up.png',
                              color: AppColor.blueColor),
                        ),

                        RichText(
                          text: TextSpan(
                              //  style: AppTextStyles.analysis_titles,
                              //    text: "+12%",
                              children: [
                                TextSpan(
                                  style: AppTextStyles.w500
                                      .copyWith(color: AppColor.blueColor),
                                  text: "+12%",
                                ),
                                TextSpan(
                                    style: AppTextStyles.box_icons.copyWith(
                                        color: AppColor.blacktext,
                                        fontWeight: FontWeight.w300),
                                    text: " Today"),
                              ]),
                        ),

                        // Text('+12% Today',
                        //     style: Theme.of(context).textTheme.caption),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              // color: Colors.red,
              width: MediaQueryHelper.sizeFromWidth(context, 5),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Nov 29, 02:29 AM",
                    style: AppTextStyles.box_icons.copyWith(
                        color: AppColor.blacktext, fontWeight: FontWeight.w300),
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
