import 'package:flutter/material.dart';
import 'package:steps/style/text_style.dart';

import '../../../style/constrians.dart';

class IconBox extends StatelessWidget {
  String image = 'assets/images/temperature.png';
  var txt;
  IconBox(this.image, this.txt, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQueryHelper.sizeFromWidth(context, 11),
        height: MediaQueryHelper.sizeFromHeight(context, 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("$image", height: 45),
            SizedBox(width: 5),
            Text('$txt', style: AppTextStyles.box_icons),
          ],
        ));
  }
}
