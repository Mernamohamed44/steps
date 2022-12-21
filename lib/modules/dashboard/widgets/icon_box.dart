import 'package:flutter/material.dart';
import 'package:steps/style/text_style.dart';

import '../../../style/costraints.dart';

class IconBox extends StatelessWidget {
  String image='assets/images/temperature.png';
   IconBox(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQueryHelper.sizeFromWidth(context, 15),
        height: MediaQueryHelper.sizeFromHeight(context, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("$image", height: 45),
           SizedBox(width: 5),
            Text('45°', style: AppTextStyles.box_icons),
          ],
        ));
  }
}
