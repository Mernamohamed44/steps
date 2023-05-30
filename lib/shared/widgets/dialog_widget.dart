import 'package:flutter/material.dart';

import '../../style/text_style.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({super.key, this.applyFunction});
  final void Function()? applyFunction;
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
  late String dropdownValue;
  @override
  void initState() {
    dropdownValue = list.first;
    super.initState();
  }
  TextEditingController horizontal = TextEditingController();
  TextEditingController vertical = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
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
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      controller: horizontal,
                      style: AppTextStyles.date.copyWith(
                          color: const Color(0xFF778289), fontSize: 20),
                      decoration: InputDecoration(
                          hintText: "Horizontal",
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(
                                width: 1.3,
                                color: const Color(0xFFB8BBC2),
                              ))),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      controller:vertical ,
                      style: AppTextStyles.date.copyWith(
                          color: const Color(0xFF778289), fontSize: 20),
                      decoration: InputDecoration(
                          hintText: "Vertical",
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(
                                width: 1.3,
                                color: const Color(0xFFB8BBC2),
                              ))),
                    ),
                  ),
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
                  const SizedBox(width: 15),
                  Expanded(
                    child: BorderedContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(8),
                        isExpanded: true,
                        value: dropdownValue,
                        elevation: 16,
                        style: AppTextStyles.date.copyWith(
                            color: const Color(0xFF778289), fontSize: 20),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
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
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10)),
                      ),
                      child: Text(
                        "Cancel",
                        style: AppTextStyles.date
                            .copyWith(color: Colors.black, fontSize: 20),
                      )),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: widget.applyFunction,
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF10BAD2))),
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
      ),
    );
  }
}

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
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
