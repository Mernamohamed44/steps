import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:steps/cubit/cubit/cubit.dart';
import 'package:steps/cubit/states/states.dart';
import 'package:steps/modules/chat_screen/chat_screen.dart';
import 'package:steps/modules/devices_nearby_screen/devices_nearby_screen.dart';
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
    return BlocBuilder<StepsCubit, StepsState>(builder: (context, state) {
      var cubit = BlocProvider.of<StepsCubit>(context);
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
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    settingsElements(
                        warning: '',
                        warningColor: cubit.statusWIfi
                            ? Colors.white
                            : AppColor.grayDrkColor,
                        status: cubit.statusBluetooth ? 'On' : 'off',
                        txtColor: cubit.statusBluetooth
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
                              await cubit.turnOffBluetooth(val);
                            }
                          },
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    // settingsElements(
                    //     warningColor: cubit.statusOptimization
                    //         ? Colors.white
                    //         : AppColor.grayDrkColor,
                    //     warning: 'assets/images/info 4.png',
                    //     status: cubit.statusOptimization ? 'On' : 'off',
                    //     txtColor: cubit.statusOptimization
                    //         ? Colors.white
                    //         : AppColor.grayDrkColor,
                    //     color: cubit.statusOptimization
                    //         ? AppColor.blueColor
                    //         : AppColor.grayAccentColor,
                    //     icon: Image.asset('assets/images/paper-plane 1.png',
                    //         color: cubit.statusOptimization
                    //             ? Colors.white
                    //             : AppColor.grayDrkColor),
                    //     txt: 'Optimization',
                    //     customSwitch: FlutterSwitch(
                    //       activeColor: Colors.white,
                    //       toggleColor: AppColor.blueColor,
                    //       inactiveColor: AppColor.grayDrkColor,
                    //       inactiveToggleColor: Colors.white,
                    //       width: 50.0,
                    //       height: 20.0,
                    //       toggleSize: 40.0,
                    //       value: cubit.statusOptimization,
                    //       borderRadius: 30.0,
                    //       padding: 2.0,
                    //       //showOnOff: true,
                    //       onToggle: (val) {
                    //         setState(() {
                    //           cubit.statusOptimization = val;
                    //         });
                    //       },
                    //     ),
                    //     msg:
                    //         "A message which appears when a cursor is positioned over an icon, image, hyperlink, or other element in a graphical user interface."),
                    // SizedBox(
                    //   width: 30,
                    // ),
                    settingsElements(
                        warningColor: cubit.statusWIfi
                            ? Colors.white
                            : AppColor.grayDrkColor,
                        warning: 'assets/images/info 4.png',
                        status: cubit.statusWIfi ? 'On' : 'off',
                        txtColor: cubit.statusWIfi
                            ? Colors.white
                            : AppColor.grayDrkColor,
                        color: cubit.statusWIfi
                            ? AppColor.blueColor
                            : AppColor.grayAccentColor,
                        icon: Image.asset(
                          cubit.statusWIfi
                              ? 'assets/images/tap.png'
                              : 'assets/images/paper-plane 1.png',
                          color: cubit.statusWIfi
                              ? Colors.white
                              : AppColor.grayDrkColor,
                          height: 24,
                          width: 24,
                        ),
                        txt: cubit.statusWIfi
                            ? 'Manual Control'
                            : 'Optimization',
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
                              cubit.statusWIfi = val;
                            });
                          },
                        ),
                        msg:
                            "A message which appears when a cursor is positioned over an icon, image, hyperlink, or other element in a graphical user interface."),

                    // SvgPicture.asset('assets/images/opt.svg'),
                    //  SettingsElements(
                    //      warning: 'assets/images/info 4.png',
                    //      warningColor:cubit.statusServer ? Colors.white : AppColor.grayDrkColor,
                    //
                    //      txtcolor:
                    //      cubit.statusServer ? Colors.white : AppColor.grayDrkColor,
                    //      color: cubit.statusServer
                    //          ? AppColor.blueColor
                    //          : AppColor.grayAccentColor,
                    //      icon:Image.asset('assets/images/tap 1.png',color: cubit.statusServer ? Colors.white : AppColor.grayDrkColor),
                    //      txt: 'Manual Control',
                    //      status: cubit.statusServer ? 'on' : 'off',
                    //      customSwitch: FlutterSwitch(
                    //        activeColor: Colors.white,
                    //        toggleColor: AppColor.blueColor,
                    //        inactiveColor: AppColor.grayDrkColor,
                    //        inactiveToggleColor: Colors.white,
                    //        width: 50.0,
                    //        height: 20.0,
                    //        toggleSize: 40.0,
                    //        value: cubit.statusServer,
                    //        borderRadius: 30.0,
                    //        padding: 2.0,
                    //        //showOnOff: true,
                    //        onToggle: (val) {
                    //          setState(() {
                    //            cubit.statusServer = val;
                    //          });
                    //        },
                    //      )),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: defaultButton(
                      w: 150,
                      onPress: () async {
                        final BluetoothDevice? selectedDevice =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const SelectBondedDevicePage(
                                  checkAvailability: false);
                            },
                          ),
                        );

                        if (selectedDevice != null) {
                          print(
                              'Connect -> selected ' + selectedDevice.address);
                          cubit.setServer(selectedDevice);
                          // _startChat(context, selectedDevice);
                        } else {
                          print('Connect -> no device selected');
                        }
                      },
                      txt: 'Scan Devices to connect'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
//
// void _startChat(BuildContext context, BluetoothDevice server) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) {
//         return ChatPage(server: server);
//       },
//     ),
//   );
// }
