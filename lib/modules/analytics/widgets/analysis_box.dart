import 'package:flutter/material.dart';

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
            color: Colors.red, borderRadius: BorderRadius.circular(20)),

        child: Row(
          children: [
            SizedBox(
              width: MediaQueryHelper.sizeFromWidth(context, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Daily revenue', style: AppTextStyles.analysis_titles),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Nov 29, 02:29 AM",style: AppTextStyles.date,),
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
