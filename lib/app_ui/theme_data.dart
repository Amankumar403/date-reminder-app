import 'package:flutter/material.dart';

const Color bluishCls = Color(0xFF4e5ae9);
const Color yellowCls = Color(0xFFFFB746);
const Color pinkCls = Color(0xFFff4667);
const Color white = Colors.white;

const primaryCls = bluishCls;

const Color darkGrayCls = Color(0xFF121212);
const Color darkHeaderCls = Color(0xFF424242);


class Themes{

  static final light = ThemeData(
      primaryColor: primaryCls,
      brightness: Brightness.light
  );

  static final dark = ThemeData(
      primaryColor: darkGrayCls,
      brightness: Brightness.dark
  );


}