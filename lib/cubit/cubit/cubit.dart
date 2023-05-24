import 'dart:convert';

import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solar_calculator/solar_calculator.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/models/user_model.dart';
import 'package:steps/models/weather_model.dart';
import 'package:steps/modules/analytics/screens/analytics_screen.dart';
import 'package:steps/modules/dashboard/screens/dashboars_screen.dart';
import 'package:steps/modules/settings/screen/settings_screen.dart';
import 'package:steps/network/remote/dio_helper.dart';
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
  signup({
    required String fName,
    required String lName,
    required String email,
    required String password,
  }) {
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
      print("error is $error");
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
        emit(SignInWithGoogleStateErrorState(e.toString()));
      }
    }

    return user;
  }

  WeatherModel? weatherModel;
  var azimuth;
  var elevation;
  getDataWeather() async {
    emit(GetWeatherDataLoadingState());
    DioHelper.get(
            'current.json?key=22d8859c874c4f5094a85934230605&q=egypt-mansoura')
        .then((value) {
      weatherModel = WeatherModel.fromJson(value.data);
      final latitude = weatherModel!.location!.lat;
      final longitude = weatherModel!.location!.lat;
      print(weatherModel!.location!.lat);
      final instant = Instant(
          year: DateTime.now().year,
          month: DateTime.now().month,
          day: DateTime.now().day,
          hour: DateTime.now().hour,
          timeZoneOffset: DateTime.now().timeZoneOffset.inHours.toDouble());
      final calc = SolarCalculator(instant, latitude!, longitude!);
      azimuth = calc.sunHorizontalPosition.azimuth.floorToDouble();
      elevation = calc.sunHorizontalPosition.elevation;
      if (calc.isHoursOfDarkness) print('===> IS DARK <===');
      emit(GetWeatherDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetWeatherDataStateErrorState(error.toString()));
    });
  }

  bool statusWIfi = false;
  bool statusBluetooth = false;
  bool statusServer = false;
  bool statusOptimization = false;

  Future turnOffBluetooth(val) async {
    await FlutterBluetoothSerial.instance.requestDisable();
    statusBluetooth = val;
    emit(EnableBluetoothState());
  }

  Future<void> enableBT(val) async {
    BluetoothEnable.enableBluetooth;
    statusBluetooth = val;
    emit(UnEnableBluetoothState());
  }

  angleConstrains() {
    if (weatherModel!.current!.windKph! >= 80) {
      //  azimuth=0;
      elevation = 0;
      if ((weatherModel!.current!.condition == 'overcast') ||
          (weatherModel!.current!.condition == 'cloudly') ||
          (weatherModel!.current!.condition == 'minst')) {
        azimuth = 0;
        elevation = 0;

        if ((weatherModel!.current!.condition == 'Patchy rain possible') ||
            (weatherModel!.current!.condition == 'Patchy light rain') ||
            (weatherModel!.current!.condition == 'Light rain') ||
            (weatherModel!.current!.condition == 'Moderate rain at times') ||
            (weatherModel!.current!.condition == 'Moderate rain') ||
            (weatherModel!.current!.condition == 'Heavy rain at times') ||
            (weatherModel!.current!.condition == 'Heavy rain') ||
            (weatherModel!.current!.condition == 'Light rain shower') ||
            (weatherModel!.current!.condition ==
                'Moderate or heavy rain shower') ||
            (weatherModel!.current!.condition == 'Torrential rain shower') ||
            (weatherModel!.current!.condition ==
                'Patchy light rain with thunder') ||
            (weatherModel!.current!.condition ==
                'Moderate or heavy rain with thunder')) {
          azimuth = 0;
          elevation = 90;
        }
      }
    }
    emit(AngleConstrainsState());
  }

  BluetoothConnection? connection;
  static final clientID = 0;
  final ScrollController listScrollController = ScrollController();
  List<_Message> messages = List<_Message>.empty(growable: true);

   sendMessage(String text) async {
    text = text.trim();
    // textEditingController.clear();

    if (text.isNotEmpty) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode("$text\r\n")));
        await connection!.output.allSent;

        messages.add(_Message(clientID, text));

        Future.delayed(const Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
        emit(SendAngleSuccessState());
      } catch (e) {
        // Ignore error, but notify state
        emit(SendAngleErrorState());
      }
    }
  }
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}
