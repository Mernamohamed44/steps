import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/modules/sign_in/screen/login.dart';
import 'package:steps/shared/components/components.dart';
import 'package:steps/style/colors.dart';
import 'package:steps/style/costraints.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({Key? key}) : super(key: key);
 var emailController=TextEditingController();
 var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>StepsCubit(),
    child: BlocConsumer<StepsCubit,StepsState>(
      listener: (context,state){},
      builder: (context,state){
        var cubit= StepsCubit.get(context);
        return Scaffold(
          body: SafeArea(
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
                            const Text(
                              'Welcome Back ',
                              style:
                              TextStyle(fontWeight: FontWeight.w500, fontSize: 50),
                            ),
                            const Text(
                              'Let The sun Work For you',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: MediaQueryHelper.sizeFromHeight(context, 17),
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('First Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, fontSize: 25)),
                                    Container(
                                      width: 300,
                                      child: defaultTextField(txt: 'First Name'),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Last Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, fontSize: 25)),
                                    Container(
                                      width: 300,
                                      child: defaultTextField(txt: 'Last Name'),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 25)),
                            Container(
                              width: 400,
                              child: defaultTextField(txt: 'Enter Your Email',controller: emailController),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 25)),
                            Container(
                              width: 400,
                              child: defaultTextField(isPass: true, txt: 'Password',controller: passwordController),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Confirm Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 25)),
                            Container(
                              width: 400,
                              child: defaultTextField(
                                  isPass: true, txt: 'Confirm Password'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            defaultButton(txt: 'Sign Up', w: 410,
                                onPress: (){
                                cubit.signup(email: passwordController.text , password: passwordController.text);
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 400,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.blueColor),
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: AssetImage("assets/images/google 1.png"),
                                        width: 20,
                                        height: 20,),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Sign up With Google',
                                          style: TextStyle(color: AppColor.grayDrkColor)),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [

                          Text('Already Have account'),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return SignInScreen();
                                    }));
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(color: AppColor.blueColor),
                              )),
                          SizedBox(
                            width: 180,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                logoImage()
              ],
            ),
          ),
        );
      },
    ),);
  }
}
