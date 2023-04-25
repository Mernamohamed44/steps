import 'package:flutter/material.dart';

import '../../../style/colors.dart';
import '../../../style/images.dart';
import '../../../style/text_style.dart';

class DegreeBox extends StatelessWidget {
   DegreeBox(
      {required this.txt,
      required this.imgpath,
      required this.degree,
      Key? key})
      : super(key: key);
  String txt;
  String degree;
  String imgpath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.all(10),
            height: 60,
            decoration: BoxDecoration(
                color: AppColor.blueColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100)),
            child: Image.asset(imgpath)),
        RichText(
          text: TextSpan(
              //  style: AppTextStyles.analysis_titles,
              //    text: "+12%",
              children: [
                TextSpan(
                  style: AppTextStyles.analysis_titles.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400),
                  text: "$degree\n",
                ),
                TextSpan(
                    style: AppTextStyles.box_icons.copyWith(
                         color: Colors.white, fontWeight: FontWeight.w300),
                    text: txt),
              ]),
        ),
      ],
    );
  }
}
