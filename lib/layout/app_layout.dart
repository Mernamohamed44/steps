import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/style/colors.dart';

import '../work_manager_helper.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  void initState() {
    WorkManagerHelper.foregroundTask(context.read());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StepsCubit, StepsState>(
      builder: (BuildContext context, state) {
        final cubit = StepsCubit.get(context);
        return Scaffold(
          backgroundColor: AppColor.scaffoldBackGroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 21),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(
                          height: 80,
                          width: 80,
                          image: AssetImage('assets/images/logo.png')),
                      const SizedBox(
                        height: 218,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: 250,
                            child: NavigationRail(
                              backgroundColor:
                                  AppColor.scaffoldBackGroundColor,
                              indicatorColor: Colors.red,
                              selectedIndex: cubit.currentIndex,
                              onDestinationSelected: cubit.changeBottomNav,
                              labelType: NavigationRailLabelType.all,
                              destinations: const [
                                NavigationRailDestination(
                                  icon: Image(
                                      height: 20,
                                      width: 16,
                                      image: AssetImage(
                                          'assets/images/dashboardicon.png')),
                                  selectedIcon: Image(
                                      height: 20,
                                      width: 16,
                                      image: AssetImage(
                                          'assets/images/dashboard1.png')),
                                  label: Text(
                                    'Dashboard',
                                    style:
                                        TextStyle(color: AppColor.grayColor),
                                  ),
                                ),
                                NavigationRailDestination(
                                  icon: Image(
                                      height: 20,
                                      width: 16,
                                      image: AssetImage(
                                          'assets/images/analytics.png')),
                                  selectedIcon: Image(
                                      height: 20,
                                      width: 16,
                                      image: AssetImage(
                                          'assets/images/analytics2.png')),
                                  label: Text(
                                    'Analytics',
                                    style:
                                        TextStyle(color: AppColor.grayColor),
                                  ),
                                ),
                                NavigationRailDestination(
                                  icon: Image(
                                      height: 24,
                                      width: 24,
                                      image: AssetImage(
                                          'assets/images/setting1.png')),
                                  selectedIcon: Image(
                                      height: 24,
                                      width: 24,
                                      image: AssetImage(
                                          'assets/images/settings.png')),
                                  label: Text(
                                    'Settings',
                                    style:
                                        TextStyle(color: AppColor.grayColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  cubit.screen[cubit.currentIndex]
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
