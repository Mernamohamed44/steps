import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/modules/analytics_screen.dart';
import 'package:steps/modules/dashboard/screens/dashboars_screen.dart';
import 'package:steps/modules/settings/screen/settings_screen.dart';

class StepsCubit extends Cubit<StepsState> {
  StepsCubit() : super(InitialState());

  static StepsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeNavBottomState());
  }

  List screen = [
    DashboardScreen(),
    const AnalyticsScreen(),
    const SettingsScreen()
  ];
  signup({required String email, required String password}) {
    emit(SignUpStateLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password).then((value)
    {
      emit(SignUpStateSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SignUpStateErrorState());
    });
  }
}
