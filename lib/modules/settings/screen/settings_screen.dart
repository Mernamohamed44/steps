import 'package:flutter/material.dart';
import 'package:steps/shared/components/components.dart';
import 'package:steps/style/colors.dart';

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
          padding: const EdgeInsets.only(top: 44,
          right: 55,
          left: 37),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14)
            ),
            color: Color(0xFFFBFDFF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Settings',style: TextStyle(color: AppColor.textHeadingColor,fontSize:31,fontWeight: FontWeight.w500 ),)
            ,const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SettingsElements(color:AppColor.blueColor,icon: const Icon(Icons.wifi_outlined,color: Colors.white,), txt: 'Wifi',),
                  SettingsElements(color:AppColor.blueColor,icon: const Icon(Icons.bluetooth_audio,color: Colors.white),txt: 'Bluetooth'),
                  SettingsElements(color:AppColor.grayAccentColor,icon:const Icon(Icons.sensors_rounded,color: AppColor.grayDrkColor),txt: 'Server',status: 'disconnect',txtcolor: const Color(0xFF656464)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
