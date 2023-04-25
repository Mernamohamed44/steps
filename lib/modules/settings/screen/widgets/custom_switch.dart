import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:steps/style/colors.dart';

class CustomSwitchItem extends StatefulWidget {
  const CustomSwitchItem({Key? key}) : super(key: key);
  @override
  State<CustomSwitchItem> createState() => _CustomSwitchItemState();
}

class _CustomSwitchItemState extends State<CustomSwitchItem> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      activeColor: Colors.white,
      toggleColor: AppColor.blueColor,
      inactiveColor: AppColor.grayDrkColor,
      inactiveToggleColor: Colors.white,
      width: 50.0,
      height: 20.0,
      toggleSize: 40.0,
      value: status,
      borderRadius: 30.0,
      padding: 2.0,
      //showOnOff: true,
      onToggle: (val) {
        setState(() {
          status = val;
        });
      },
    );
  }
}
