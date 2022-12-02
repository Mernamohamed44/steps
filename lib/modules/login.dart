import 'package:flutter/material.dart';
import 'package:steps/layout/app_layout.dart';
import 'package:steps/shared/components/components.dart';
import 'package:steps/style/colors/colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 70.0,
                  left: 50,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome Back ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 50),),
                    Text('Let The sun Work For you',style: TextStyle(fontSize: 20),),
                    SizedBox(height: 10,),
                    Text('Email',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25)),
                    Container(
                      width: 450,
                      child: defaultTextField(
                          txt: 'Enter Your Email'
                      ),),
                    SizedBox(height: 10,),
                    Text('Password',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25)),
                    Container(
                      width: 450,
                      child: defaultTextField(
                          isPass: true,
                          txt: 'Password'
                      ),),
                    SizedBox(height: 10,),
                    Text('Confirm Password',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25)),
                    Container(
                      width: 450,
                      child: defaultTextField(
                          isPass:  true,
                          txt: 'Confirm Password'
                      ),),
                    SizedBox(height: 10,),
                    defaultButton(txt: 'Sign In',w:460,onPress: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context){return AppLayout();}));
                    }),
                    SizedBox(height: 10,),
                    Container(
                      width: 450,
                      decoration: BoxDecoration(
                        border: Border.all(color: blueColor),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: TextButton(
                          onPressed: (){},
                          child: Text('Sign in With Google',style: TextStyle(color: grayDrkColor))
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 200,),
            logoImage()
          ],
        ),
      ),
    );
  }
}
