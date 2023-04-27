import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:steps/layout/app_layout.dart';
import 'package:steps/modules/sign_up/screen/sign_up_screen.dart';
import 'package:steps/network/local/shared_pref.dart';

import 'shared/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  print(token);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? SignUpScreen() : const AppLayout(),
    );
  }
}
