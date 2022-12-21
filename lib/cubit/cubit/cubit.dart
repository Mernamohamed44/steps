import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/models/user_model.dart';
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
  signup({
    required String fName, required String lName,
    required String email, required String password}) {
    emit(SignUpStateLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password).then((value)
    {
      createUser(fName: fName,lName: lName,email: email,uId:value.user!.uid );
      emit(SignUpStateSuccessState());
    }).catchError((error){
      print("error is ${error.toString()}");
      emit(SignUpStateErrorState());
    });
  }
  UserModel? model;

  createUser({
    required String email,
    required String fName,
    required String lName,
    required String uId
  }) {
    model = UserModel(
        email: email,
        fName: fName,
        lName: lName,
        uId: uId,

    );
    FirebaseFirestore.instance.collection('users').doc(uId).
    set(model!.toMap()).then((value) =>
    {
      print(uId),
      emit(CreateUserSuccessState())
    }).catchError((error){
      print(error.toString());
    });
  }
  signIn({required String email,required password}){
    emit(SignInStateLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password).then((value)
    {
      emit(SignInStateSuccessState());
    }).catchError((error){
      print("error is ${error.toString()}");
      emit(SignInStateErrorState());
    });
  }
}
