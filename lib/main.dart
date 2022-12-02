import 'package:flutter/material.dart';
import 'package:steps/layout/app_layout.dart';
import 'package:steps/modules/login.dart';
import 'package:steps/modules/sign_up_screen.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}
class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SignUpScreen(),
    );
  }

}