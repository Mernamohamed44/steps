import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:steps/app_routes.dart';
import 'package:steps/network/local/shared_pref.dart';

import 'shared/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  runApp(MyApp(
    appRoutes: AppRoutes(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRoutes}) : super(key: key);
  final AppRoutes appRoutes;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoutes.generateRoutes,
    );
  }
}
