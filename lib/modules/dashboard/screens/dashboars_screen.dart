import 'dart:math';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
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
        var cubitInfo = BlocProvider.of<StepsCubit>(context);
        if (state is GetWeatherDataLoadingState &&
            cubitInfo.consumptionModel.isEmpty) {
          return Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()));
        } else {
          return FutureBuilder<AndroidBatteryInfo?>(
              future: BatteryInfoPlugin().androidBatteryInfo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var batteryLevel = snapshot.data!.batteryLevel;
                  var batteryCapacity = snapshot.data!.batteryCapacity;
                  //Load Current (in amperes) = Power Consumption (in watts) / Operating Voltage (in volts)
                  Random rnd;
                  double min = 0;
                  double max = 10000;
                  rnd = Random();
                  var r = rnd.nextDouble() * (max - min) + min;
                  var loadCurrent = r;
                  var remainingTimeInMinutes =
                      ((batteryLevel! * batteryCapacity! / 100) / loadCurrent) *
                          60;
                  var remainingTimeInHours = remainingTimeInMinutes / 60;
                  ///co2 reduction equation//////
                  double co2Reduction = 0;
                  for (int i = 0; i < cubitInfo.consumptionModel.length; i++) {
                    var co2EmissionsFactor = 0.4;
                    var solarPanelCO2Emissions =
                        cubitInfo.consumptionModel[i].energyConsumption * 0;
                    var fossilFuelCO2Emissions =
                        cubitInfo.consumptionModel[i].energyConsumption *
                            co2EmissionsFactor;
                    co2Reduction =
                        fossilFuelCO2Emissions - solarPanelCO2Emissions;
                  }
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 44, right: 55, left: 37, bottom: 50),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            color: Color(0xFFFBFDFF),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Dashboard",
                                style: AppTextStyles.titles,
                              ),
                              if (cubitInfo.isShowing)
                                const AnalogUpdateWidget(
                                  message:
                                      "The angle need to be adjusted to 45° for the vertical and 60° for the horizontal due to the rainy weather.",
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Column(
                                                children: [
                                                  IconBox(
                                                      'assets/images/temperature.png',
                                                      '${cubitInfo.azimuth}°h'),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  IconBox(
                                                      'assets/images/temperature.png',
                                                      '${cubitInfo.elevation}°v'),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  IconBox(
                                                      'assets/images/temperature2.png',
                                                      '${cubitInfo.weatherModel!.current!.tempC!}°c'),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  IconBox(
                                                      'assets/images/charge.png',
                                                      '${remainingTimeInHours.toInt()} h')
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Container(
                                                height: 380,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  //color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                                                    context,
                                                                    2.5),
                                                            width: MediaQueryHelper
                                                                .sizeFromWidth(
                                                                    context, 7),
                                                          ),
                                                          const SizedBox(
                                                            width: 150,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              const Text(
                                                                  'Daily revenue'),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              const Text(
                                                                  '45.24',
                                                                  style: AppTextStyles
                                                                      .titles),
                                                              Text(
                                                                  '+12% From week',
                                                                  style: Theme.of(
                                                                          context)
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
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
                                          title: "CO₂ Reduction",
                                          num: '$co2Reduction',
                                          measure_unit: "Kwh"),
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
                                          num:
                                              "${(snapshot.data!.batteryCapacity)! / 1000}",
                                          measure_unit: "mAh"),
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
                                          title: "Total yield",
                                          num: "12",
                                          measure_unit: "kWh"),
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
                                          title: "Consumption",
                                          num: "12",
                                          measure_unit: "kW"),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  );
                }
                return const CircularProgressIndicator(
                  backgroundColor: Colors.red,
                );
              });
        }
      },
    );
  }
}
