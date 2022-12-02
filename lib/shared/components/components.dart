import 'package:flutter/material.dart';
import 'package:steps/style/colors/colors.dart';

Widget SettingsElements({required color,required icon ,required txt, Color txtcolor=Colors.white,String status='on'}){
  return Container(
    padding: EdgeInsets.all(30),
    width: 200,
    height: 160,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all( Radius.circular(14)),
        color: color
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
                child: icon,
                backgroundColor: Colors.white.withOpacity(.5)),
            Spacer(),

          ],
        ),
        Spacer(),
        Text(txt,style: TextStyle(color: txtcolor,fontSize:20,fontWeight: FontWeight.w500 )),
        Text(status,style: TextStyle(color: txtcolor,fontSize:15, ))
      ],
    ),
  );
}
Widget defaultTextField(
    {  String? txt,
      IconData? prefixIcon,
      IconData? suffixIcon,
      Function? validate,
      Function? suffixOnPress,
      bool isPass = false,
      TextInputType? type,
      TextEditingController? controller,
      onSubmit}) {
  return TextFormField(
  controller: controller,
  onFieldSubmitted:onSubmit,
  keyboardType: type,
  obscureText: isPass ? true : false,
  validator: (value) => validate!(value),
  decoration: InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF34C4D8), width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF34C4D8), width: 2.0),
    ),
    prefixIcon: Icon(prefixIcon),
    suffixIcon: IconButton(
      icon: Icon(suffixIcon),
      onPressed: () {
        if (suffixIcon != null) {
          suffixOnPress!();
        }
      },
    ),
    hintText: txt,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
    ),
  ),
    );
}
Widget defaultButton({String? txt, Function? onPress,w}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      minWidth: w,
      height: 40,
      color: blueColor,
      child: Text('$txt',style:TextStyle(color: Colors.white)),
      onPressed: () => onPress!());
}
Widget logoImage(){
  return Expanded(
      child: Container(
          height: double.infinity,
          color:  Color.fromRGBO(16, 186, 210, 0.1),
          child: Image(image: AssetImage('images/logo.png'))));
}