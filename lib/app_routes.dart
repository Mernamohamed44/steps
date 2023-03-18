import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/layout/app_layout.dart';
import 'package:steps/modules/sign_in/screen/login.dart';
import 'package:steps/modules/sign_up/screen/sign_up_screen.dart';

import 'shared/constants/constants.dart';

class AppRoutes {
  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => StepsCubit(), child: SignUpScreen()));
      case signIn:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => StepsCubit(), child: SignInScreen()));
      case dashboard:
        return MaterialPageRoute(builder: (_) => AppLayout());
    }
  }
}
