import 'package:flutter/material.dart';
import 'package:steps/modules/login.dart';
import 'package:steps/shared/components/components.dart';
import 'package:steps/style/colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                    const SizedBox(
                      height: 10,
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
                      child: defaultTextField(txt: 'Enter Your Email'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Password',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25)),
                    Container(
                      width: 400,
                      child: defaultTextField(isPass: true, txt: 'Password'),
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
                    defaultButton(txt: 'Sign Up', w: 410),
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
                          child: Text('Sign up With Google',
                              style: TextStyle(color: AppColor.grayDrkColor))),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                      ],
                    )
                  ],
                ),
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
  }
}
