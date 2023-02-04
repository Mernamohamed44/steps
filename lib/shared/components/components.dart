
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:steps/modules/settings/screen/widgets/custom_switch.dart';
import 'package:steps/style/colors.dart';
import 'package:steps/style/costraints.dart';
Widget SettingsElements(
    {required color,
    required icon,
    required txt,
    Color txtcolor = Colors.white,
    String status = 'on'}) {
  return Container(
    padding: const EdgeInsets.all(15),
    width: 230,
    height: 160,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)), color: color),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
                child: icon, backgroundColor: Colors.white.withOpacity(.5)),
            Spacer(),
            const CustomSwitchItem(),

          ],
        ),
        const Spacer(),
        Text(txt,
            style: TextStyle(
                color: txtcolor, fontSize: 20, fontWeight: FontWeight.w500)),
        Text(status,
            style: TextStyle(
              color: txtcolor,
              fontSize: 15,
            ))
      ],
    ),
  );
}
Widget headingText(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        'Welcome Back ',
        style:
        TextStyle(fontWeight: FontWeight.w500, fontSize: 50),
      ),
      Text(
        'Let The sun Work For you',
        style: TextStyle(fontSize: 20),
      ),
    ],
  );
}

Widget defaultTextField(
    {String? txt,
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
    onFieldSubmitted: onSubmit,
    keyboardType: type,
    obscureText: isPass ? true : false,
    validator: (value) => validate!(value),
    decoration: InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF34C4D8), width: 2.0),
      ),
      enabledBorder: const OutlineInputBorder(
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

Widget defaultButton({String? txt, Function? onPress, required double w}) {
  return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      minWidth: w,
      height: 40,
      color: AppColor.blueColor,
      child: Text('$txt', style: const TextStyle(color: Colors.white)),
      onPressed: () => onPress!());
}

Widget logoImage() {
  return Expanded(
      child: Container(
          height: double.infinity,
          color: const Color.fromRGBO(16, 186, 210, 0.1),
          child: const Image(image: AssetImage('assets/images/logo.png'))));
}

Widget SmallStaticsCard(
    {required BuildContext context,
    required image,
    required title,
    required num,
    required measure_unit}) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(30),
    width: MediaQueryHelper.sizeFromWidth(context, 5),
    height: MediaQueryHelper.sizeFromHeight(context, 4),
    decoration:  const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        //color: AppColor.grayAccentColor
        color: AppColor.scaffoldBackGroundColor),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
              child: image, backgroundColor: Colors.white.withOpacity(.5)),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(title, style: const TextStyle(color: AppColor.grayColor)),
            RichText(
                text: TextSpan(
                    style: const TextStyle(color: AppColor.blacktext),
                    children: [
                  TextSpan(text: num, style: const TextStyle(fontSize: 25)),
                  TextSpan(
                    text: measure_unit,
                  ),
                ]))
          ]),
        ]),
  );
}
void showToast({
  @required message,
  @required ToastState ?state
}){
  Fluttertoast.showToast(
      msg: message ,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state!),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastState{success,error,warning}
Color chooseToastColor(ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.success:
      color=Colors.green;
      break;
    case ToastState.error:
      color=Colors.red;
      break;
    case ToastState.warning:
      color=Colors.amber;
      break;
  }
  return color;
}
