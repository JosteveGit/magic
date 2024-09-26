import 'package:flutter/material.dart';

class AppColors {
  final Color alwaysWhite;
  final Color alwaysBlack;
  final Color alwaysdbff54;
  final Color always26292C;
  final Color always1d1a20;
  final Color transparent;

  Color get primary => alwaysdbff54;
  Color get secondary => always1d1a20;

  AppColors({
    this.alwaysWhite = Colors.white,
    this.alwaysBlack = Colors.black,
    this.alwaysdbff54 = const Color(0xffdbff54),
    this.always26292C = const Color(0xff26292C),
    this.always1d1a20 = const Color(0xff1d1a20),
    this.transparent = Colors.transparent,
  });
}
