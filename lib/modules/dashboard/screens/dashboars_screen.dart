import 'package:flutter/material.dart';
import 'package:steps/style/costraints.dart';
import 'package:steps/style/text_style.dart';

import '../../../shared/components/components.dart';
import '../../../style/colors.dart';
import '../widgets/icon_box.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.only(top: 44, right: 55, left: 37),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14), topRight: Radius.circular(14)),
            color: Color(0xFFFBFDFF),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(

                width: MediaQueryHelper.sizeFromWidth(context, 2.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Status",
                      style: AppTextStyles.titles,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.blueGrey),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset("assets/images/solar-cell.png",
                              height: MediaQueryHelper.sizeFromHeight(
                                  context, 2.5)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: const [
                              IconBox(),
                              IconBox(),
                              IconBox(),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmallStaticsCard(
                            context: context,
                            icon: Icon(Icons.cloud_outlined),
                            title: "CO Reduction",
                            num: "12",
                            measure_unit: "ton"),
                        SmallStaticsCard(
                            context: context,
                            icon: Icon(Icons.text_snippet),
                            title: "Capacity",
                            num: "12",
                            measure_unit: "kW"),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,

               // width: MediaQueryHelper.sizeFromWidth(context, 2.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Status",
                      style: AppTextStyles.titles,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.blueGrey),
                      child: Row(
                        children: [
                          Image.asset("assets/images/analytics1.png",
                              height: MediaQueryHelper.sizeFromHeight(
                                  context, 2.5)),
                          Column(
                            children: const [
                              IconBox(),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmallStaticsCard(
                            context: context,
                            icon: Icon(Icons.cloud_outlined),
                            title: "CO Reduction",
                            num: "12",
                            measure_unit: "ton"),
                        SmallStaticsCard(
                            context: context,
                            icon: Icon(Icons.text_snippet),
                            title: "Capacity",
                            num: "12",
                            measure_unit: "kW"),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
/**
 *  Row(
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
 * */
////////////////////////////////////

/**
 *
 * Text(
    'Dashboard',
    style: TextStyle(
    color: textHeadingColor,
    fontSize: 31,
    fontWeight: FontWeight.w500),
    ),
 */
