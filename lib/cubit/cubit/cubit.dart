import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/models/user_model.dart';
import 'package:steps/models/weather_model.dart';
import 'package:steps/modules/analytics/screens/analytics_screen.dart';
import 'package:steps/modules/dashboard/screens/dashboars_screen.dart';
import 'package:steps/modules/settings/screen/settings_screen.dart';
import 'package:steps/network/remote/weather_api.dart';
import 'package:steps/shared/components/components.dart';

class StepsCubit extends Cubit<StepsState> {
  StepsCubit() : super(InitialState());
  static StepsCubit get(context) => BlocProvider.of(context);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fNameController = TextEditingController();
  var lNameController = TextEditingController();

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
  signup(
      {required String fName,
      required String lName,
      required String email,
      required String password}) {
    emit(SignUpStateLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          fName: fName, lName: lName, email: email, uId: value.user!.uid);
      emit(SignUpStateSuccessState());
    }).catchError((error) {
      print("error is ${error.toString()}");
      emit(SignUpStateErrorState(error.toString()));
    });
  }

  UserModel? model;

  createUser(
      {required String email,
      required String fName,
      required String lName,
      required String uId}) {
    model = UserModel(
      email: email,
      fName: fName,
      lName: lName,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model!.toMap())
        .then((value) => {print(uId), emit(CreateUserSuccessState())})
        .catchError((error) {
      print(error.toString());
    });
  }

  signIn({required String email, required password}) {
    emit(SignInStateLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SignInStateSuccessState());
    }).catchError((error) {
      print("error is ${error.toString()}");
      emit(SignInStateErrorState(error.toString()));
    });
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    emit(SignInWithGoogleStateLoadingState());
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      emit(SignInWithGoogleStateSuccessState());
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        emit(SignInWithGoogleStateErrorState(e.toString()));
        if (e.code == 'account-exists-with-different-credential') {
          showToast(
              message: 'This account already in use', state: ToastState.error);
        } else if (e.code == 'invalid-credential') {
          showToast(message: 'Try again', state: ToastState.error);
        }
      } catch (e) {
        showToast(
            message: 'Error occurred using Google Sign-In. Try again.',
            state: ToastState.error);
      }
    }

    return user;
  }

  WeatherModel? weatherModel;
  WeatherModel? weather;
  getDataWeather() async {
    emit(GetWeatherDataStateLoadingState());
    weatherModel = await ApiWeather().getWeather().then((value) {
      weather = value;
      emit(GetWeatherDataSuccessState(weather!));
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(CreateUserErrorState());
    });
  }
}
