import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:steps/layout/app_layout.dart';
import 'package:steps/modules/sign_up/screen/sign_up_screen.dart';

import 'cubit/cubit/cubit.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,

  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(),
    // WorkManagerHelper.initialize(),
  ]);

  // await WorkManagerHelper.register();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = _auth.currentUser;
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(
    user: user,
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  final User? user;
  const MyApp({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StepsCubit()..apiData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: user == null ? SignUpScreen() : const AppLayout(),
      ),
    );
  }
}
