import 'package:flutter/material.dart';
import 'package:steps/style/colors.dart';
import 'package:steps/style/costraints.dart';
import 'package:steps/style/images.dart';

import '../../../style/text_style.dart';
import '../widgets/analysis_box.dart';
import '../widgets/large_analytics.dart';

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
                    width: MediaQueryHelper.sizeFromWidth(context, 2.5),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                         AnalysisBox(title: 'Daily revenue',imgpath: AppImages.up,styletxt: AppColor.blueColor),
                        LAnalytics()
                      ],
                    ),
                  ),

                  ///tttttttttttt
                  Container(
                    width: MediaQueryHelper.sizeFromWidth(context, 2.5),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         AnalysisBox(title: 'Consumption',imgpath: AppImages.down,styletxt: AppColor.red),
                         AnalysisBox(title: 'Estimated saving',imgpath: AppImages.up,styletxt: AppColor.blueColor),

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
