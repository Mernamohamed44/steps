import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../../style/colors/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 44, right: 55, left: 37),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14)),
          color: const Color(0xFFFBFDFF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                  color: textHeadingColor,
                  fontSize: 31,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallStaticsCard(
                    icon: Icon(Icons.cloud_outlined),
                    title: "CO Reduction",
                    num: "12",
                    measure_unit: "ton"),
                SmallStaticsCard(
                    icon: Icon(Icons.text_snippet),
                    title: "Capacity",
                    num: "12",
                    measure_unit: "kW"),
                SmallStaticsCard(
                    icon: Icon(Icons.electric_bolt_rounded),
                    title: "Total yield",
                    num: "12",
                    measure_unit: "kWh"),
                SmallStaticsCard(
                    icon: Icon(Icons.lightbulb),
                    title: "Consumption",
                    num: "12",
                    measure_unit: "kWh"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
