import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/style/colors.dart';
import 'package:steps/style/constrians.dart';
import 'package:steps/style/text_style.dart';

import '../../../shared/components/components.dart';
import '../../../shared/widgets/analog_update_widget.dart';
import '../widgets/icon_box.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StepsCubit, StepsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var sunPositionInfo = BlocProvider.of<StepsCubit>(context);
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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Dashboard",
                        style: AppTextStyles.titles,
                      ),
                      if (sunPositionInfo.isShowing)
                        const AnalogUpdateWidget(
                          message:
                              "The angle need to be adjusted to 45° for the vertical and 60° for the horizontal due to the rainy weather.",
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Text(
                                  "Status",
                                  style: AppTextStyles.w500,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 380,
                                  decoration: const BoxDecoration(
                                      color: AppColor.accentBlue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/solar-cell.png',
                                        width: 350,
                                        height: 250,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Column(
                                          children: [
                                            IconBox(
                                                'assets/images/temperature.png',
                                                '${sunPositionInfo.azimuth}°h'),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            IconBox(
                                                'assets/images/temperature.png',
                                                '${sunPositionInfo.elevation.floorToDouble()}°v'),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            IconBox(
                                                'assets/images/temperature2.png',
                                                '${weatherData!.current!.tempC!}°c'),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            IconBox('assets/images/charge.png',
                                                '2h'),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                                alignment:
                                                    Alignment.bottomCenter,
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
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Text(
                                  "Summary",
                                  style: AppTextStyles.w500,
                                ),
                                const SizedBox(height: 10),
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Container(
                                        height: 380,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          //color: Colors.grey,

                                          borderRadius:
                                              BorderRadius.circular(20),

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
                                                        .sizeFromHeight(
                                                            context, 2.5),
                                                    width: MediaQueryHelper
                                                        .sizeFromWidth(
                                                            context, 7),
                                                  ),
                                                  const SizedBox(
                                                    width: 150,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      const Text(
                                                          'Daily revenue'),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      const Text('45.24',
                                                          style: AppTextStyles
                                                              .titles),
                                                      Text('+12% From week',
                                                          style:
                                                              Theme.of(context)
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
                                  ],
                                ),
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                      ),
                    ],
                  ),
                )),
          );
        }
      },
    );
  }
}
