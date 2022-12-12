import 'package:flutter/material.dart';
import 'package:steps/style/text_style.dart';

import '../../../style/costraints.dart';

class IconBox extends StatelessWidget {
  const IconBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQueryHelper.sizeFromWidth(context, 10),
        height: MediaQueryHelper.sizeFromHeight(context, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/temperature.png", height: 45),
           SizedBox(width: 5),
            Text('45°', style: AppTextStyles.box_icons),
          ],
        ));
  }
}
