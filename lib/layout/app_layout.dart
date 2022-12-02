import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/style/colors/colors.dart';
class AppLayout extends StatelessWidget{
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>StepsCubit(),
      child: BlocConsumer<StepsCubit,StepsState>(
        builder: (BuildContext context, state) {
          var cubit =StepsCubit.get(context);
          return Scaffold(
            backgroundColor: scaffoldBackGroundColor ,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16,
                    top: 21
                ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Image(
                              height:80 ,
                              width: 80,
                              image: AssetImage('images/logo.png')),
                          const SizedBox(height: 218,),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                NavigationRail(
                                  backgroundColor:scaffoldBackGroundColor,
                                  selectedIndex: cubit.currentIndex,
                                  onDestinationSelected: (int index) {
                                    cubit.changeBottomNav(index);
                                  },
                                  labelType: NavigationRailLabelType.all,
                                  destinations:  [
                                    NavigationRailDestination(
                                      icon: Image(
                                          height: 20,
                                          width: 16,
                                          image: AssetImage('images/dashboardicon.png')),
                                      selectedIcon: Image(
                                          height: 20,
                                          width: 16,
                                          image: AssetImage('images/dashboardicon.png')),
                                      label: Text('Dashboard',style: TextStyle(color:grayColor),),
                                    ),
                                    NavigationRailDestination(
                                      icon: Image(
                                          height: 20,
                                          width: 16,
                                          image: AssetImage('images/analytics.png')),
                                      selectedIcon: Image(
                                          height: 20,
                                          width: 16,
                                          image: AssetImage('images/analytics.png')),
                                      label: Text('Analytics',style: TextStyle(color:grayColor),),
                                    ),
                                    NavigationRailDestination(
                                      icon: Image(
                                          height: 24,
                                          width: 24,
                                          image: AssetImage('images/settings.png')),
                                      selectedIcon: Image(
                                          height: 24,
                                          width: 24,
                                          image: AssetImage('images/settings.png')),
                                      label: Text('Settings',style: TextStyle(color:grayColor),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      cubit.screen[cubit.currentIndex]
                    ],
                  ),
                ),
              ),
          );  },
        listener: (BuildContext context, Object? state) {  },),);
  }

}
