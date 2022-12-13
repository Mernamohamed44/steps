import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/modules/analytics_screen.dart';
import 'package:steps/modules/dashboard/screens/dashboars_screen.dart';
import 'package:steps/modules/settings/screens/settings_screen.dart';

class StepsCubit extends Cubit<StepsState>{
  StepsCubit(): super(InitialState());

  static StepsCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeNavBottomState());
  }
  List screen = [
    const DashboardScreen(),
    const AnalyticsScreen(),
    const SettingsScreen()
  ];
}