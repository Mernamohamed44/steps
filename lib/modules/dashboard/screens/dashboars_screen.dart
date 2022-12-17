import 'package:flutter/material.dart';
import 'package:steps/style/costraints.dart';
import 'package:steps/style/text_style.dart';

import '../../../shared/components/components.dart';
import '../widgets/icon_box.dart';

class DashboardScreen extends StatefulWidget {
   DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedValue ;
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Today"),value: "Today",),
      DropdownMenuItem(child: Text("Yesterday"),value: "Yesterday"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.only(top: 44, right: 55, left: 37),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14), topRight: Radius.circular(14)),
            color: Color(0xFFFBFDFF),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Colors.blue,
                width: MediaQueryHelper.sizeFromWidth(context, 2.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Status",
                      style: AppTextStyles.titles,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.blueGrey),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset("assets/images/solar-cell.png",
                              height: MediaQueryHelper.sizeFromHeight(
                                  context, 2.5)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: const [
                              IconBox(),
                              IconBox(),
                              IconBox(),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmallStaticsCard(
                            context: context,
                            icon: Icon(Icons.cloud_outlined),
                            title: "CO Reduction",
                            num: "12",
                            measure_unit: "ton"),
                        SmallStaticsCard(
                            context: context,
                            icon: Icon(Icons.text_snippet),
                            title: "Capacity",
                            num: "12",
                            measure_unit: "kW"),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.blue,
                width: MediaQueryHelper.sizeFromWidth(context, 2.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Status",
                      style: AppTextStyles.titles,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.blueGrey),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                        Container(
                          height: 30.0,
                          width: 115.0,
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                filled: true,
                                enabled: false,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                hintText: "Name",
                                fillColor: Colors.blue[200]),
                            value: selectedValue,
                            onChanged: (String? Value) {
                              setState(() {
                                selectedValue = Value;
                              });
                            },
                            items: dropdownItems
                          ),
                        ),
                            Row(
                             // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset("assets/images/solar-cell.png",
                                    height: MediaQueryHelper.sizeFromHeight(
                                        context, 2.5)),
                                SizedBox(width: 150,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end ,
                                  children:  [
                                   Text('Daily revenue'),
                                    SizedBox(height: 20,),
                                    Text('45.24',style: AppTextStyles.titles),
                                    Text('+12% From week',style:Theme.of(context).textTheme.caption)
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmallStaticsCard(
                            context: context,
                            icon: Icon(Icons.cloud_outlined),
                            title: "CO Reduction",
                            num: "12",
                            measure_unit: "ton"),
                        SmallStaticsCard(
                            context: context,
                            icon: Icon(Icons.lightbulb),
                            title: "Capacity",
                            num: "12",
                            measure_unit: "kW"),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

//////////////
