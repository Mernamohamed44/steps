import 'package:flutter/material.dart';
import 'package:steps/style/costraints.dart';

import '../../../style/text_style.dart';
import '../widgets/analysis_box.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
              padding: EdgeInsets.only(top: 44, right: 55, left: 37),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14)),
                color: Color(0xFFFBFDFF),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQueryHelper.sizeFromWidth(context, 2.3),
                    color: Colors.greenAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        AnalysisBox(),
                        AnalysisBox(),
                        AnalysisBox(),
                      ],
                    ),
                  ),

                  ///tttttttttttt
                  Container(
                    width: MediaQueryHelper.sizeFromWidth(context, 2.8),
                    color: Colors.greenAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("data"),
                        Text("data"),
                        Text("data"),
                      ],
                    ),
                  ),
                ],
              )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Analytics",
              style: AppTextStyles.titles,
            ),
          )
        ],
      ),
    );
  }
}
