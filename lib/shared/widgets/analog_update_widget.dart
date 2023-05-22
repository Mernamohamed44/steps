import 'package:flutter/material.dart';

import '../../style/text_style.dart';
import 'dialog_widget.dart';

class AnalogUpdateWidget extends StatelessWidget {
  const AnalogUpdateWidget(
      {super.key, required this.message, this.isError = false});
  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
          color: const Color(0xFFFFE8D0),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFFF5EB), width: 2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            isError ? "assets/images/error.png" : "assets/images/warning.png",
            height: 30,
            width: 30,
          ),
          SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Angle update",
                style: AppTextStyles.titles.copyWith(fontSize: 30)),
            SizedBox(height: 15),
            Text(
              message,
              style: AppTextStyles.date.copyWith(
                  fontSize: 23,
                  color: Color(0xFF787878),
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () => showDialog(
                  context: context, builder: (context) => DialogWidget()),
              child: Ink(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFD9D9D9))),
                  child: Text("Change angle",
                      style: AppTextStyles.w500
                          .copyWith(color: Color(0xFF656464))),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

// class LinedText extends StatelessWidget {
//   const LinedText(this.text, {super.key, this.style});
//   final TextStyle? style;
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     List<String> words = text.split(" ");
//     return Wrap(
//       crossAxisAlignment: WrapCrossAlignment.start,
//       children: words
//           .map((e) => Text(
//                 "$e ",
//                 style: style,
//               ))
//           .toList(),
//     );
//   }
// }
