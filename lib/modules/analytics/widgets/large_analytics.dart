import 'package:flutter/material.dart';
import 'package:steps/models/production_model.dart';
import 'package:steps/style/constrians.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/prediction_model.dart';
import '../../../style/colors.dart';
import '../../../style/text_style.dart';

class LAnalytics extends StatefulWidget {
  const LAnalytics({Key? key, required this.items}) : super(key: key);
  final List<PredictionModel> items;
  @override
  State<LAnalytics> createState() => _LAnalyticsState();
}

class _LAnalyticsState extends State<LAnalytics> {
  String? selectedValue;

  // List<DropdownMenuItem<String>> get dropdownItems {
  //   List<DropdownMenuItem<String>> menuItems = [
  //     const DropdownMenuItem(
  //       value: "Year",
  //       child: Text("Year"),
  //     ),
  //     const DropdownMenuItem(value: "Month", child: Text("Month")),
  //   ];
  //   return menuItems;
  // }

  SelectionBehavior? _selectionBehavior;

//   late List<_ChartData> data;
  TooltipBehavior? _tooltip;
  List<ChartData> _setList() {
    List<ChartData> result = [];
    for (int i = 0; i < widget.items.length; i++) {
      result.add(ChartData(
          widget.items[i].date.monthDay, widget.items[i].predictedPower, 0));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = _setList();
    _tooltip = TooltipBehavior(enable: true);
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
          height: MediaQueryHelper.sizeFromHeight(context, 1.8),
          //  width: MediaQueryHelper.sizeFromWidth(context, 3),
          decoration: BoxDecoration(
              //  color: Colors.grey,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                          //  style: AppTextStyles.analysis_titles,
                          //    text: "+12%",
                          children: [
                            TextSpan(
                              style: AppTextStyles.analysis_titles.copyWith(
                                  color: AppColor.blackText,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400),
                              text: "Energy prediction\n",
                            ),
                            TextSpan(
                                style: AppTextStyles.box_icons.copyWith(
                                    color: AppColor.blackText,
                                    fontWeight: FontWeight.w300),
                                text: "Updated 40 mins ago"),
                          ]),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: SizedBox(
                    //     height: 30.0,
                    //     width: 115.0,
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //           color: AppColor.accentBlue,
                    //           borderRadius: BorderRadius.circular(10)),
                    //       child: DropdownButton(
                    //           underline: SizedBox(),
                    //           icon: const Icon(Icons.arrow_drop_down,
                    //               color: Colors.black),
                    //           elevation: 16,
                    //           borderRadius: BorderRadius.circular(10),
                    //           value: selectedValue,
                    //           onChanged: (String? value) {
                    //             setState(() {
                    //               selectedValue = value;
                    //             });
                    //           },
                    //           items: dropdownItems),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    selectionType: SelectionType.point,
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries<ChartData, String>>[
                      ColumnSeries<ChartData, String>(
                          //     trackPadding: 0.5,
                          // trackBorderWidth: 0.3,

                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          name: 'energy',
                          color: AppColor.blueColor,
                          selectionBehavior: _selectionBehavior,
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y),
                      ColumnSeries<ChartData, String>(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: AppColor.grayColor,
                          name: "bad energy",
                          selectionBehavior: _selectionBehavior,
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y1),
                    ]),
              ],
            ),
          )),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
    this.y1,
  );

  final String x;
  final double? y;
  final double? y1;
}
