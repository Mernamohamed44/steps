import 'package:flutter/material.dart';

import 'package:steps/style/colors.dart';

abstract class AppTextStyles {
  /// - weight: w300
  /// - family: cairo
  static const TextStyle titles =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 31, letterSpacing: 1);

  /// - weight: w400
  /// - family: cairo
  static const TextStyle box_icons =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 18, letterSpacing: 1);

  /// - weight: w500
  /// - family: cairo

  static const TextStyle w500 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 20);

  static const TextStyle date = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 18, color: AppColor.grayColor);

  /// - weight: w600
  /// - family: cairo
  static const TextStyle analysis_titles = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 20, color: AppColor.grayColor);

  /// - weight: w700
  /// - family: cairo
  static const TextStyle w700 = TextStyle(fontWeight: FontWeight.w700);

  /// - weight: w800
  /// - family: cairo
  static const TextStyle w800 = TextStyle(fontWeight: FontWeight.w800);

  /// - weight: w900
  /// - family: cairo
  static const TextStyle w900 = TextStyle(fontWeight: FontWeight.w900);

  static const TextStyle largefont =
      TextStyle(fontWeight: FontWeight.w800, fontSize: 25);
}
