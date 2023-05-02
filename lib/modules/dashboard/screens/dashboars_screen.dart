import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_calculator/solar_calculator.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/models/weather_model.dart';
import 'package:steps/style/colors.dart';
import 'package:steps/style/constrians.dart';
import 'package:steps/style/text_style.dart';

import '../../../shared/components/components.dart';
import '../widgets/icon_box.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedValue;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: "Today",
        child: Text("Today"),
      ),
      const DropdownMenuItem(value: "Yesterday", child: Text("Yesterday")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StepsCubit, StepsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var sunPositionInfo=BlocProvider.of<StepsCubit>(context);
        var weatherData = BlocProvider.of<StepsCubit>(context).weatherModel;
        if (state is GetWeatherDataLoadingState) {
          return Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()));
        } else {
          return Expanded(
            child: Container(
                padding: const EdgeInsets.only(top: 44, right: 55, left: 37),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14)),
                  color: Color(0xFFFBFDFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQueryHelper.sizeFromWidth(context, 2.4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Dashboard",
                            style: AppTextStyles.titles,
                          ),
                          const Text(
                            "Status",
                            style: AppTextStyles.w500,
                          ),
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Column(
                                  children: [
                                    IconBox(
                                        'assets/images/temperature.png', '${sunPositionInfo.azimuth}°'),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    IconBox('assets/images/temperature2.png',
                                        '${weatherData!.currentWeather!.temperature}°'),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    IconBox('assets/images/charge.png', '45'),
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
                                  image: Stack(
                                    children: const [
                                      Center(
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/sky.png"),
                                          width: 35,
                                          height: 35,
                                        ),
                                      ),
                                      Center(
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/co2.png"),
                                          width: 15,
                                          height: 15,
                                          alignment: Alignment.bottomCenter,
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: "CO Reduction",
                                  num: "12",
                                  measure_unit: "ton"),
                              SmallStaticsCard(
                                  context: context,
                                  image: const Center(
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/battery.png"),
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  title: "Capacity",
                                  num: "12",
                                  measure_unit: "kW"),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQueryHelper.sizeFromWidth(context, 2.4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            "Summary",
                            style: AppTextStyles.w500,
                          ),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    //color: Colors.grey,

                                    borderRadius: BorderRadius.circular(20),

                                    // color: AppColor.accentblue
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              "assets/images/analysis.png",
                                              height: MediaQueryHelper
                                                  .sizeFromHeight(context, 2.5),
                                              width: MediaQueryHelper
                                                  .sizeFromWidth(context, 7),
                                            ),
                                            const SizedBox(
                                              width: 150,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Text('Daily revenue'),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text('45.24',
                                                    style:
                                                        AppTextStyles.titles),
                                                Text('+12% From week',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall)
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 30.0,
                                  width: 115.0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppColor.accentblue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: DropdownButton(
                                        underline: const SizedBox(),
                                        icon: const Icon(Icons.arrow_drop_down,
                                            color: Colors.black),
                                        elevation: 16,
                                        borderRadius: BorderRadius.circular(10),
                                        value: selectedValue,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedValue = value;
                                          });
                                        },
                                        items: dropdownItems),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SmallStaticsCard(
                                  context: context,
                                  image: const Center(
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/energy 2.png"),
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  title: "CO Reduction",
                                  num: "12",
                                  measure_unit: "ton"),
                              SmallStaticsCard(
                                  context: context,
                                  image: const Center(
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/lightbulb.png"),
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
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
      },
    );
  }
}
