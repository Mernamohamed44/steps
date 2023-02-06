import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
        listener: (BuildContext context, state) {},
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
                          Text(
                            'Welcome Back ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 50),
                          ),
                          Text(
                            'Let The sun Work For you',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 25)),
                          Container(
                            width: 450,
                            child: defaultTextField(
                                txt: 'Enter Your Email',
                                controller: emailController),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 25)),
                          Container(
                            width: 450,
                            child: defaultTextField(
                                isPass: true,
                                txt: 'Password',
                                controller: passwordController),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Confirm Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 25)),
                          Container(
                            width: 450,
                            child: defaultTextField(
                                isPass: true, txt: 'Confirm Password'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                            builder: (BuildContext context) => defaultButton(
                                txt: 'Sign In',
                                w: 460,
                                onPress: () {
                                  cubit.signIn(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AppLayout();
                                  }));
                                }),
                            fallback: (BuildContext context) => Center(
                              child: Container(
                                width: 400,
                                height: 50,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            condition: state is! SignInStateLoadingState,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 450,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.blueColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image:
                                      AssetImage("assets/images/google 1.png"),
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text('Sign in With Google',
                                        style: TextStyle(
                                            color: AppColor.grayDrkColor))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
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
