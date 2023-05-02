import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/shared/components/components.dart';
import 'package:steps/style/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepsCubit,StepsState>(builder: (context,state){
      var cubit=BlocProvider.of<StepsCubit>(context);
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 103, left: 19, right: 16),
          child: Container(
            padding: const EdgeInsets.only(top: 44, right: 55, left: 37),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14), topRight: Radius.circular(14)),
              color: Color(0xFFFBFDFF),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                      color: AppColor.textHeadingColor,
                      fontSize: 31,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SettingsElements(
                        status: cubit.statusWIfi ? 'On' : 'off',
                        txtcolor:
                        cubit.statusWIfi ? Colors.white : AppColor.grayDrkColor,
                        color: cubit.statusWIfi
                            ? AppColor.blueColor
                            : AppColor.grayAccentColor,
                        icon: Icon(
                          Icons.wifi_outlined,
                          color:
                          cubit. statusWIfi ? Colors.white : AppColor.grayDrkColor,
                        ),
                        txt: 'Wifi',
                        customSwitch: FlutterSwitch(
                          activeColor: Colors.white,
                          toggleColor: AppColor.blueColor,
                          inactiveColor: AppColor.grayDrkColor,
                          inactiveToggleColor: Colors.white,
                          width: 50.0,
                          height: 20.0,
                          toggleSize: 40.0,
                          value: cubit.statusWIfi,
                          borderRadius: 30.0,
                          padding: 2.0,
                          //showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              cubit. statusWIfi = val;
                            });
                          },
                        )),
                    SettingsElements(
                        status:cubit. statusBluetooth ? 'On' : 'off',
                        txtcolor: cubit.statusBluetooth
                            ? Colors.white
                            : AppColor.grayDrkColor,
                        color: cubit.statusBluetooth
                            ? AppColor.blueColor
                            : AppColor.grayAccentColor,
                        icon: Icon(Icons.bluetooth_audio,
                            color: cubit.statusBluetooth
                                ? Colors.white
                                : AppColor.grayDrkColor),
                        txt: 'Bluetooth',
                        customSwitch: FlutterSwitch(
                          activeColor: Colors.white,
                          toggleColor: AppColor.blueColor,
                          inactiveColor: AppColor.grayDrkColor,
                          inactiveToggleColor: Colors.white,
                          width: 50.0,
                          height: 20.0,
                          toggleSize: 40.0,
                          value: cubit.statusBluetooth,
                          borderRadius: 30.0,
                          padding: 2.0,
                          //showOnOff: true,
                          onToggle: (val) async {
                            if (cubit.statusBluetooth == false) {
                              cubit.enableBT(val);
                            } else {
                              await cubit. turnOffBluetooth(val);
                            }
                          },
                        )),
                    SettingsElements(
                        txtcolor:
                        cubit.statusServer ? Colors.white : AppColor.grayDrkColor,
                        color: cubit.statusServer
                            ? AppColor.blueColor
                            : AppColor.grayAccentColor,
                        icon: const Icon(Icons.sensors_rounded,
                            color: AppColor.grayDrkColor),
                        txt: 'Server',
                        status: cubit.statusServer ? 'connect' : 'disconnect',
                        // txtcolor: const Color(0xFF656464),
                        customSwitch: FlutterSwitch(
                          activeColor: Colors.white,
                          toggleColor: AppColor.blueColor,
                          inactiveColor: AppColor.grayDrkColor,
                          inactiveToggleColor: Colors.white,
                          width: 50.0,
                          height: 20.0,
                          toggleSize: 40.0,
                          value: cubit.statusServer,
                          borderRadius: 30.0,
                          padding: 2.0,
                          //showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              cubit.statusServer = val;
                            });
                          },
                        )),
                  ],
                ),
                SizedBox(height: 100,),
                Align(
                  alignment: Alignment.bottomRight,
                  child: defaultButton(w: 150,onPress: (){},
                    txt: 'Scan Devices to connect'
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
