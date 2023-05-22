import 'package:flutter/material.dart';

import '../../style/text_style.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({super.key});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  final List<String> list = const <String>[
    '1 Day',
    '1 Week',
    '1 Month',
    'Always'
  ];
  String dropdownValue = "";
  @override
  void initState() {
    dropdownValue = list.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/tap.png",
                      height: 38,
                      width: 38,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Manual Control",
                      style: AppTextStyles.titles.copyWith(
                          fontSize: 30, color: const Color(0xFF3C394D)),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                Text(
                  "Panel angle",
                  style: AppTextStyles.date
                      .copyWith(color: const Color(0xFF778289), fontSize: 20),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: BorderedContainer(
                      child: Text("Horizontal",
                          style: AppTextStyles.date.copyWith(
                              color: const Color(0xFF778289), fontSize: 20))),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: BorderedContainer(
                    child: Text("Vertical",
                        style: AppTextStyles.date.copyWith(
                            color: const Color(0xFF778289), fontSize: 20)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  "Panel angle",
                  style: AppTextStyles.date
                      .copyWith(color: const Color(0xFF778289), fontSize: 20),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(8),
                    
                    isExpanded: true,
                    value: dropdownValue,
                    elevation: 16,
                    style: AppTextStyles.date
                        .copyWith(color: const Color(0xFF778289), fontSize: 20),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
                    ),
                    child: Text(
                      "Cancel",
                      style: AppTextStyles.date
                          .copyWith(color: Colors.black, fontSize: 20),
                    )),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF10BAD2))),
                    child: Text(
                      "Apply",
                      style: AppTextStyles.date
                          .copyWith(color: Colors.white, fontSize: 20),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.3,
            color: const Color(0xFFB8BBC2),
          ),
          borderRadius: BorderRadius.circular(7)),
      child: child,
    );
  }
}
