import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps/style/colors.dart';
import 'package:steps/style/images.dart';

import '../../cubit/cubit/cubit.dart';
import '../../cubit/states/states.dart';
import '../../style/text_style.dart';
import 'dialog_widget.dart';

class AnalogUpdateWidget extends StatelessWidget {
  const AnalogUpdateWidget({
    super.key,
    required this.message,
    this.isError = false,
  });

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepsCubit, StepsState>(builder: (context, state) {
      StepsCubit cubit = context.read<StepsCubit>();
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
            color: const Color(0xFFFFE8D0),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFFFF5EB), width: 2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              isError ? "assets/images/error.png" : "assets/images/warning.png",
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Angle update",
                        style: AppTextStyles.titles.copyWith(fontSize: 30)),
                    const SizedBox(height: 15),
                    Text(
                      message,
                      style: AppTextStyles.date.copyWith(
                          fontSize: 23,
                          color: const Color(0xFF787878),
                          fontWeight: FontWeight.w400),
                      softWrap: true,
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => cubit.server != null
                              ? DialogWidget(applyFunction: cubit.sendMessage)
                              : _NoServerDialog()),
                      child: Ink(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border:
                                  Border.all(color: const Color(0xFFD9D9D9))),
                          child: Text("Change angle",
                              style: AppTextStyles.w500
                                  .copyWith(color: const Color(0xFF656464))),
                        ),
                      ),
                    ),
                  ]),
            ),
            IconButton(
                onPressed: cubit.closeWarning, icon: const Icon(Icons.close))
          ],
        ),
      );
    });
  }
}

class _NoServerDialog extends StatelessWidget {
  const _NoServerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //   Icon(Icons.warning,color: AppColor.red,size:30),
            Image.asset('assets/images/warning.png', height: 40),
            const SizedBox(width: 5),

            const Text("Go to settings and connect to bluetooth device",
                style: AppTextStyles.analysis_titles),
          ],
        ),
      ),
    );
  }
}
