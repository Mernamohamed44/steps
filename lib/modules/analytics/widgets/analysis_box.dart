import 'package:flutter/material.dart';
import 'package:steps/style/colors.dart';
import 'package:steps/style/constrians.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/consumption_model.dart';
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
  final List<ConsumptionModel> data;

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData =
        data.map((e) => ChartData(e.date, e.energyConsumption)).toList();

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: MediaQueryHelper.sizeFromHeight(context, 3.5),
        //  width: MediaQueryHelper.sizeFromWidth(context, 3),
        decoration: BoxDecoration(
            //  color: Colors.grey,
            borderRadius: BorderRadius.circular(20)),

        child: FittedBox(
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
                          color: AppColor.blackText,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 150,
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // selectionType: SelectionType.point,
                          // tooltipBehavior: _tooltip,
                          series: <ChartSeries<ChartData, int>>[
                            ColumnSeries<ChartData, int>(
                              // borderRadius: const BorderRadius.only(
                              //     topLeft: Radius.circular(20),
                              //     topRight: Radius.circular(20)),
                              name: 'potassium',
                              // dataLabelSettings:
                              //     const DataLabelSettings(isVisible: true),
                              // color: const Color(0xffCFA841),
                              // // selectionBehavior: _selectionBehavior,
                              dataSource: chartData,
                              xValueMapper: (item, y) => 2,
                              yValueMapper: (item, y) => item.y!.toInt(),
                            ),
                          ]),
                    )
                    //   chartToRun()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
  );

  final String x;
  final double? y;
}
