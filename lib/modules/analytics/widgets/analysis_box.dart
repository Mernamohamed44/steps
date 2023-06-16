import 'package:flutter/material.dart';
import 'package:steps/style/colors.dart';
import 'package:steps/style/constrians.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/production_model.dart';
import '../../../style/text_style.dart';
import 'chart.dart';

class AnalysisBox extends StatelessWidget {
  AnalysisBox(
      {required this.title,
      required this.imgpath,
      required this.styletxt,
      required this.data,
      Key? key})
      : super(key: key);
  String title;
  String imgpath;
  Color styletxt;
  final List<dynamic> data;
  SelectionBehavior? _selectionBehavior;

//   late List<_ChartData> data;
  TooltipBehavior? _tooltip;

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = <ChartData>[
      ChartData('w1', 128, 129, 90),
      ChartData('w2', 123, 100, 93),
      ChartData('w3', 128, 129, 30),
      ChartData('w4', 87, 95, 71),
    ];
    _tooltip = TooltipBehavior(enable: true);
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
              width: MediaQueryHelper.sizeFromWidth(context, 5.5),
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(title,
                        style: AppTextStyles.analysis_titles
                            .copyWith(color: AppColor.blackText)),
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
                              color: AppColor.blackText,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Image.asset(imgpath, color: styletxt),
                        ),

                        RichText(
                          text: TextSpan(
                              //  style: AppTextStyles.analysis_titles,
                              //    text: "+12%",
                              children: [
                                TextSpan(
                                  style: AppTextStyles.w500
                                      .copyWith(color: styletxt),
                                  text: "+12%",
                                ),
                                TextSpan(
                                    style: AppTextStyles.box_icons.copyWith(
                                        color: AppColor.blackText,
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
                        color: AppColor.blackText, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 150,
                    child: SfCartesianChart(

                        primaryXAxis: CategoryAxis(),
                        selectionType: SelectionType.point,
                        tooltipBehavior: _tooltip,
                        series: [
                          for (int i = 0; i < data.length; i++)
                            ColumnSeries<dynamic, String>(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              name: 'potassium',
                              color: const Color(0xffCFA841),
                              selectionBehavior: _selectionBehavior,
                              dataSource: data,
                              xValueMapper: (item, y) => item.date,
                              yValueMapper: (item, y) =>
                              item.runtimeType == ProductionModel
                                      ? item.energyProduction
                                      : item.energyConsumption,

                            ),
                          // ColumnSeries<ChartData, String>(
                          //     borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(20),
                          //         topRight: Radius.circular(20)),
                          //     color: Color(0xff4BA26A),
                          //     name: "phosphorous",
                          //     selectionBehavior: _selectionBehavior,
                          //     dataSource: chartData,
                          //     xValueMapper: (ChartData data, _) => data.x,
                          //     yValueMapper: (ChartData data, _) => data.y1),
                          // ColumnSeries<ChartData, String>(
                          //     borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(20),
                          //         topRight: Radius.circular(20)),
                          //     selectionBehavior: _selectionBehavior,
                          //     name: "Nitrogen",
                          //     color: Color(0xffF6C602),
                          //     dataSource: chartData,
                          //     xValueMapper: (ChartData data, _) => data.x,
                          //     yValueMapper: (ChartData data, _) => data.y2)
                        ]),
                  )
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

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);

  final String x;
  final double? y;
  final double? y1;
  final double? y2;
}
