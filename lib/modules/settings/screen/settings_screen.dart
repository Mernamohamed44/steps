import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:steps/shared/components/components.dart';
import 'package:steps/style/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  bool statusWIfi = false;
  bool statusBluetooth = false;
  bool statusServer = false;
  @override
  void initState() {
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });
    super.initState();
  }
  Future turnOffBluetooth() async {
    await FlutterBluetoothSerial.instance.requestDisable();
  }
  Future<void> enableBT() async {
    BluetoothEnable.enableBluetooth.then((value) {
      print(value);
    });
  }

  Future<void> customEnableBT(BuildContext context) async {
    String dialogTitle = "Hey! Please give me permission to use Bluetooth!";
    bool displayDialogContent = true;
    String dialogContent = "This app requires Bluetooth to connect to device.";
    String cancelBtnText = "Nope";
    String acceptBtnText = "Sure";
    double dialogRadius = 10.0;
    bool barrierDismissible = true;
    BluetoothEnable.customBluetoothRequest(
            context,
            dialogTitle,
            displayDialogContent,
            dialogContent,
            cancelBtnText,
            acceptBtnText,
            dialogRadius,
            barrierDismissible)
        .then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      status: statusWIfi ? 'On' : 'off',
                      txtcolor:
                          statusWIfi ? Colors.white : AppColor.grayDrkColor,
                      color: statusWIfi
                          ? AppColor.blueColor
                          : AppColor.grayAccentColor,
                      icon: Icon(
                        Icons.wifi_outlined,
                        color:
                            statusWIfi ? Colors.white : AppColor.grayDrkColor,
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
                        value: statusWIfi,
                        borderRadius: 30.0,
                        padding: 2.0,
                        //showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            statusWIfi = val;
                          });
                        },
                      )),
                  SettingsElements(
                      status: statusBluetooth ? 'On' : 'off',
                      txtcolor: statusBluetooth
                          ? Colors.white
                          : AppColor.grayDrkColor,
                      color: statusBluetooth
                          ? AppColor.blueColor
                          : AppColor.grayAccentColor,
                      icon: Icon(Icons.bluetooth_audio,
                          color: statusBluetooth
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
                        value:  _bluetoothState.isEnabled,
                        borderRadius: 30.0,
                        padding: 2.0,
                        //showOnOff: true,
                        onToggle: (val) {
                          future() async {
                            // async lambda seems to not working
                            if (val)
                              await FlutterBluetoothSerial.instance.requestEnable();
                            else
                              await FlutterBluetoothSerial.instance.requestDisable();
                          }

                          future().then((_) {
                            setState(() {});
                          });
                        //  turnOffBluetooth();
                        // statusBluetooth?enableBT().then((value) => { setState(() {
                        // statusBluetooth=val;
                        // })}):turnOffBluetooth().then((value){setState(() {
                        //   statusBluetooth=val;
                        // });});
                        },
                      )),
                  SettingsElements(
                      txtcolor:
                          statusServer ? Colors.white : AppColor.grayDrkColor,
                      color: statusServer
                          ? AppColor.blueColor
                          : AppColor.grayAccentColor,
                      icon: const Icon(Icons.sensors_rounded,
                          color: AppColor.grayDrkColor),
                      txt: 'Server',
                      status: statusServer ? 'connect' : 'disconnect',
                      // txtcolor: const Color(0xFF656464),
                      customSwitch: FlutterSwitch(
                        activeColor: Colors.white,
                        toggleColor: AppColor.blueColor,
                        inactiveColor: AppColor.grayDrkColor,
                        inactiveToggleColor: Colors.white,
                        width: 50.0,
                        height: 20.0,
                        toggleSize: 40.0,
                        value: statusServer,
                        borderRadius: 30.0,
                        padding: 2.0,
                        //showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            statusServer = val;
                          });
                        },
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
