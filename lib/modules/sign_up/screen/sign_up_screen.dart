import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/modules/sign_in/screen/login.dart';
import 'package:steps/shared/components/components.dart';
import 'package:steps/style/colors.dart';
import 'package:steps/style/constrians.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  var fKey = GlobalKey<FormState>();
  Future<void> _register(BuildContext context) async {
    if (!fKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      fKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StepsCubit(),
      child: BlocConsumer<StepsCubit, StepsState>(
        listener: (context, state) {
          if (state is SignUpStateLoadingState) {
            Center(
              child: Container(
                width: 400,
                height: 50,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: AppColor.accentblue,
                ),
              ),
            );
          }

          if (state is SignUpStateSuccessState) {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SignInScreen()));
          }

          if (state is SignUpStateErrorState) {
            print((state).errorMsg);
            showToast(message: (state).errorMsg, state: ToastState.error);
          }
        },
        builder: (context, state) {
          var cubit = StepsCubit.get(context);
          return Scaffold(
            body: Form(
              key: fKey,
              child: SafeArea(
                child: Row(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 70.0,
                              left: 50,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headingText(),
                                SizedBox(
                                  height: MediaQueryHelper.sizeFromHeight(
                                      context, 19),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('First Name',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25)),
                                        SizedBox(
                                          width: 300,
                                          child: defaultTextField(
                                            txt: 'First Name',
                                            controller: cubit.fNameController,
                                            validate: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'The First name Field is not allowed to be empty ';
                                              }
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Last Name',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25)),
                                        SizedBox(
                                          width: 300,
                                          child: defaultTextField(
                                            txt: 'Last Name',
                                            controller: cubit.lNameController,
                                            validate: (value) {
                                              if (value != null &&
                                                  value.isEmpty) {
                                                return 'The Last name Field is not allowed to be empty ';
                                              }
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Email',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25)),
                                SizedBox(
                                  width: 400,
                                  child: defaultTextField(
                                    txt: 'Enter Your Email',
                                    controller: cubit.emailController,
                                    validate: (value) {
                                      if (value != null && value.isEmpty) {
                                        return 'Email Field is not allowed to be empty ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Password',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25)),
                                SizedBox(
                                  width: 400,
                                  child: defaultTextField(
                                    isPass: true,
                                    txt: 'Password',
                                    controller: cubit.passwordController,
                                    validate: (value) {
                                      if (value != null && value.isEmpty) {
                                        return 'Password Field is not allowed to be empty ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Confirm Password',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25)),
                                SizedBox(
                                  width: 400,
                                  child: defaultTextField(
                                      isPass: true, txt: 'Confirm Password'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultButton(
                                    txt: 'Sign Up',
                                    w: 400,
                                    onPress: () {
                                      _register(context);
                                      cubit.signup(
                                          fName: cubit.fNameController.text,
                                          lName: cubit.lNameController.text,
                                          email: cubit.emailController.text,
                                          password:
                                              cubit.passwordController.text);
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Text('Already Have account'),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SignInScreen()));
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(color: AppColor.blueColor),
                                  )),
                              const SizedBox(
                                width: 180,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    logoImage()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
