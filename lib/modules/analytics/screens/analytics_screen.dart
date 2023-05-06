import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/modules/analytics/widgets/degree_box.dart';
import 'package:steps/style/colors.dart';
import 'package:steps/style/constrians.dart';
import 'package:steps/style/images.dart';

import '../../../style/text_style.dart';
import '../widgets/analysis_box.dart';
import '../widgets/large_analytics.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepsCubit,StepsState>(
      builder: (BuildContext context, state) {
        var weatherData = BlocProvider.of<StepsCubit>(context).weatherModel;
        if (state is GetWeatherDataLoadingState) {
          return Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()));
        }
        else {
          return Expanded(
            child: Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 44, right: 55, left: 37),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14)),
                      color: Color(0xFFFBFDFF),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQueryHelper.sizeFromWidth(context, 2.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnalysisBox(
                                  title: 'Daily revenue',
                                  imgpath: AppImages.up,
                                  styletxt: AppColor.blueColor),
                              LAnalytics()
                            ],
                          ),
                        ),

                        ///tttttttttttt
                        Container(
                          width: MediaQueryHelper.sizeFromWidth(context, 2.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AnalysisBox(
                                  title: 'Consumption',
                                  imgpath: AppImages.down,
                                  styletxt: AppColor.red),
                              AnalysisBox(
                                  title: 'Estimated saving',
                                  imgpath: AppImages.up,
                                  styletxt: AppColor.blueColor),
                              Card(
                                color: AppColor.blueColor,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(

                                    margin: EdgeInsets.all(10),
                                    height:
                                    MediaQueryHelper.sizeFromHeight(context, 3.5),
                                    //  width: MediaQueryHelper.sizeFromWidth(context, 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                //  style: AppTextStyles.analysis_titles,
                                                //    text: "+12%",
                                                  children: [
                                                    TextSpan(
                                                      style: AppTextStyles
                                                          .analysis_titles
                                                          .copyWith(
                                                          color:
                                                          AppColor.blacktext,
                                                          fontSize: 24,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                      text: "Weather\n",
                                                    ),
                                                    TextSpan(
                                                        style: AppTextStyles.box_icons
                                                            .copyWith(
                                                            color: AppColor
                                                                .blacktext,
                                                            fontWeight:
                                                            FontWeight.w300),
                                                        text: "Updated 40 mins ago"),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            DegreeBox(
                                                txt: 'Temprature',
                                                imgpath: AppImages.cloudy,
                                                degree: '${weatherData!.current!.tempC}°'),
                                            DegreeBox(
                                                txt: 'Irradiation',
                                                imgpath: AppImages.sunny,
                                                degree: '20 J/mm2'),
                                          ],
                                        ),
                                        DegreeBox(
                                            txt: 'Wind',
                                            imgpath: AppImages.wind,
                                            degree: '${weatherData.current!.windKph} m/s'),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Analytics",
                    style: AppTextStyles.titles,
                  ),
                )
              ],
            ),
          );
        }
        },

    );
  }
}
