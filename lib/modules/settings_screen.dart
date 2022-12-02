import 'package:flutter/material.dart';
import 'package:steps/shared/components/components.dart';
import 'package:steps/style/colors/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 103,
        left: 19,
        right: 16),
        child: Container(
          padding: EdgeInsets.only(top: 44,
          right: 55,
          left: 37),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14)
            ),
            color: const Color(0xFFFBFDFF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Settings',style: TextStyle(color: textHeadingColor,fontSize:31,fontWeight: FontWeight.w500 ),)
            ,SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SettingsElements(color:blueColor,icon: Icon(Icons.wifi_outlined,color: Colors.white,), txt: 'Wifi',),
                  SettingsElements(color:blueColor,icon: Icon(Icons.bluetooth_audio,color: Colors.white),txt: 'Bluetooth'),
                  SettingsElements(color:grayAccentColor,icon:Icon(Icons.sensors_rounded,color: grayDrkColor),txt: 'Server',status: 'disconnect',txtcolor: Color(0xFF656464)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
