import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
 var  fNameController=TextEditingController();
 var lNameController=TextEditingController();
 var fKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>StepsCubit(),
    child: BlocConsumer<StepsCubit,StepsState>(
      listener: (context,state){},
      builder: (context,state){
        var cubit= StepsCubit.get(context);
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
                                        child: defaultTextField(txt: 'First Name',controller: fNameController,validate:
                                            (String? value) {
                                          if (value!.isEmpty) {
                                            return 'The First name Field is not allowed to be empty ';
                                          }
                                          return null;
                                        },),
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
                                        child: defaultTextField(txt: 'Last Name',controller: lNameController,
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'The Last name Field is not allowed to be empty ';
                                            }
                                            return null;
                                          },),
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
                                child: defaultTextField(txt: 'Enter Your Email',controller: emailController,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Email Field is not allowed to be empty ';
                                    }
                                    return null;
                                  },),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Password',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 25)),
                              Container(
                                width: 400,
                                child: defaultTextField(isPass: true, txt: 'Password',controller: passwordController,validate:
                                    (String value) {
                                  if (value.isEmpty) {
                                    return 'Password Field is not allowed to be empty ';
                                  }
                                  return null;
                                },),
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
                              ConditionalBuilder(
                                condition: state is! SignUpStateLoadingState,
                                fallback: (BuildContext context) => Center(
                                  child: Container(
                                    width: 400,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),),
                                ),
                                builder: (BuildContext context) =>defaultButton(txt: 'Sign Up', w: 410,
                                    onPress: (){
                                      cubit.signup(
                                        fName: fNameController.text,
                                        lName: lNameController.text,
                                          email: emailController.text, password: passwordController.text);
                                    }),

                              ),
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
          ),
        );
      },
    ),);
  }
}
