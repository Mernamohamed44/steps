import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/layout/app_layout.dart';
import 'package:steps/shared/components/components.dart';

import 'package:steps/style/colors.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StepsCubit(),
      child: BlocConsumer<StepsCubit, StepsState>(
        listener: (BuildContext context, state) {
          if (state is SignInStateLoadingState) {
            Center(
              child: Container(
                width: 400,
                height: 50,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: AppColor.accentBlue,
                ),
              ),
            );
          }
          if (state is SignInStateSuccessState) {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AppLayout()));
          }

          if (state is SignInStateErrorState) {
            print((state).errorMsg);
            showToast(message: (state).errorMsg, state: ToastState.error);
          }
          if (state is SignInWithGoogleStateSuccessState) {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AppLayout()));
          }

          if (state is SignInWithGoogleStateLoadingState) {
            Center(
              child: Container(
                width: 400,
                height: 50,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: AppColor.accentBlue,
                ),
              ),
            );
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = StepsCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Row(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 70.0,
                        left: 50,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headingText(),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text('Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 25)),
                          SizedBox(
                            width: 450,
                            child: defaultTextField(
                                txt: 'Enter Your Email',
                                controller: emailController),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 25)),
                          SizedBox(
                            width: 450,
                            child: defaultTextField(
                                isPass: true,
                                txt: 'Password',
                                controller: passwordController),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultButton(
                              txt: 'Sign In',
                              w: 450,
                              onPress: () {
                                cubit.signIn(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 450,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.blueColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                  image:
                                      AssetImage("assets/images/google 1.png"),
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                    onPressed: () {
                                      cubit.signInWithGoogle(context: context);
                                    },
                                    child: const Text('Sign in With Google',
                                        style: TextStyle(
                                            color: AppColor.grayDrkColor))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 200,
                  ),
                  logoImage()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
