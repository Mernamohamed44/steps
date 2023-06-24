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
import 'package:steps/network/remote/repository.dart';
import 'package:steps/shared/components/components.dart';

import '../../models/average_model.dart';
import '../../models/consumption_model.dart';
import '../../models/prediction_model.dart';
import '../../models/production_model.dart';

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
  Future getDataWeather() async {
    emit(GetWeatherDataLoadingState());
    print('get data weather succefully');
    DioHelper.get(
            'current.json?key=22d8859c874c4f5094a85934230605&q=egypt-mansoura')
        .then((value) {
      weatherModel = WeatherModel.fromJson(value.data);
      final latitude = weatherModel!.location!.lat;
      final longitude = weatherModel!.location!.lat;
      print('lat is :${weatherModel!.location!.lat}');
      final instant = Instant(
          year: DateTime.now().year,
          month: DateTime.now().month,
          day: DateTime.now().day,
          hour: DateTime.now().hour,
          timeZoneOffset: DateTime.now().timeZoneOffset.inHours.toDouble());
      final calc = SolarCalculator(instant, latitude!, longitude!);
      azimuth = calc.sunHorizontalPosition.azimuth.floorToDouble();
      elevation = calc.sunHorizontalPosition.elevation.floorToDouble();
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
///////////////////////////////
  BluetoothConnection? connection;
  static final clientID = 0;
  BluetoothDevice? server;
  final ScrollController listScrollController = ScrollController();
  List<_Message> messages = List<_Message>.empty(growable: true);
  Future<void> sendMessage(
      {required String horizontal, required String vertical}) async {
    if (horizontal.isNotEmpty && vertical.isNotEmpty) {
      String text = _setText(horizontal, "");
      await _sendMessage(text);
      await Future.delayed(const Duration(seconds: 2));
      text = _setText("", vertical);
      await _sendMessage(text);
    } else {
      String text = _setText(horizontal, vertical);
      _sendMessage(text);
    }
  }

  Future<void> _sendMessage(String text) async {
    print(text);
    if (text.isNotEmpty) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode("$text\r\n")));
        await connection!.output.allSent;
        messages.add(_Message(clientID, text));
        emit(SendAngleSuccessState());
      } catch (e) {
        // Ignore error, but notify state
        emit(SendAngleErrorState());
      }
    }
    print("send message");
  }

  String _setText(String horizontal, String vertical) {
    if (horizontal.isNotEmpty) {
      return "h${horizontal.trim()}";
    } else if (vertical.isNotEmpty) {
      return "v${vertical.trim()}";
    }
    return "";
  }

  bool isShowing = true;
  void closeWarning() {
    isShowing = false;
    emit(UnShowWarningState());
  }

  AverageModel? averageModel;
  Future getAverage() async {
    (await Repository.getAverage()).fold((l) => emit(ErrorState(l.message)),
        (r) {
      averageModel = r;
      emit(SuccessState());
    });
  }
//get Consumption >>
  List<ConsumptionModel> consumptionModel = [];
  Future getConsumption() async {
    (await Repository.getConsumption()).fold((l) => emit(ErrorState(l.message)),
        (r) {
      consumptionModel = r;
      emit(SuccessState());
    });
  }
//get production >>
  List<ProductionModel> productionModel = [];
  Future getProduction() async {
    (await Repository.getProduction()).fold((l) {
      print(l.message);
      emit(ErrorState(l.message));
    }, (r) {
      print(r);
      productionModel = r;
      emit(SuccessState());
    });
  }
  //get prediction >>
  List<PredictionModel> predictionModel = [];
  Future getPredictions() async {
    (await Repository.getPredictions()).fold((l) {
      print(l.message);
      emit(ErrorState(l.message));
    }, (r) {
      print(r);
      predictionModel = r;
      emit(SuccessState());
    });
  }
//get prediction average>>
  double _getAveragePredictionModel() {
    double average = 0;
    for (int i = 0; i < predictionModel.length; i++) {
      average += predictionModel[i].predictedPower;
    }
    return average / predictionModel.length;
  }
  //There is a problem with SolarBanel... you may need maintenance or cleaning
  String warningText = "";
  void _setManual() {
    double average = _getAveragePredictionModel();
    if (60 > average - (averageModel?.averageEnergyProduction ?? 0)) {
      warningText = "You are now on the manual control mode";
      isShowing = true;
    }
    if (weatherModel?.current?.condition?.text != "Clear") {
      warningText = "Please adjust the position of the panels to 90 in the horizontal position due to the rainر";
      isShowing = true;
    }
    if (weatherModel?.current?.windKph > 80) {
      warningText = " Please adjust the position of the panels to 90 in vertical mode due to severe storms";
      isShowing = true;
    }
    emit(SuccessState());
  }

  bool isDisconnecting = false;

  void setServer(BluetoothDevice device) async {
    server = device;
    await _initConnection();
  }

  Future<void> _initConnection() async {
    if (connection != null) {
    } else {
      BluetoothConnection.toAddress(server!.address).then((_connection) {
        print('Connected to the device');
        connection = _connection;

        connection!.input!.listen(_onDataReceived).onDone(() {
          print("connected");
        });
      }).catchError((error) {
        print('Cannot connect, exception occurred');
        print(error);
      });
    }
  }

  String _messageBuffer = '';
  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      messages.add(
        _Message(
          1,
          backspacesCounter > 0
              ? _messageBuffer.substring(
                  0, _messageBuffer.length - backspacesCounter)
              : _messageBuffer + dataString.substring(0, index),
        ),
      );
      _messageBuffer = dataString.substring(index);
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void apiData() async {
    await Future.wait([
      getConsumption(),
      getDataWeather(),
      getProduction(),
      getAverage(),
      getPredictions()
    ]);
    _setManual();
  }
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}
