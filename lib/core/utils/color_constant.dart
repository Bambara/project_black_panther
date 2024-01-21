import 'dart:ui';

import 'package:flutter/material.dart';

class ColorConstant {
  static const darkBlack = Color(0xFF000000);
  static const lightBlack = Color(0xFF121212);
  static const blue = Color(0xFF0900FF);
  static const buttonBlue = Color(0xFF6D5FFD);
  static const darkBlue = Color(0xFF0000FF);
  static const lightBlue = Color(0xFF0075ff);
  static const red = Color(0xFFef3d72);

  static const colorPrimary = Color(0xFF3E3E3E);
  static const colorPrimaryDark = Color(0xFF3E3E3E);
  static const colorAccent = Color(0xFF63676D);
  static const appGreen = Color(0xFF5BAA46);
  static const appBlue = Color(0xFF1A55D8);
  static const appBlueDarker = Color(0xFF072CA3);
  static const appOrangeDarker = Color(0xFFFF0000);
  static const appLightBlue = Color(0xFF63D8F7);
  static const appOrange = Color(0xFFF79420);

  static const ashOne = Color(0xFF3e3e3e);
  static const transparentAsh = Color(0x8e3e3e3e);
  static const ashTwo = Color(0xFFb2b2b2);
  static const ashThree = Color(0xFF63676d);
  static const greenOne = Color(0xFFF6921E);
  static const greenTwo = Color(0xFF417b00);
  static const greenThree = Color(0xFF5BA900);
  static const greenFour = Color(0xFF7ADF07);
  static const greenFive = Color(0xFF5AA900);
  static const greenSix = Color(0xFF5BA946);

  static const greenTransparent = Color(0xAA3BC500);
  static const yellowTransparent = Color(0xAAC5FF00);
  static const redTransparent = Color(0xAAD45B15);
  static const redOne = Color(0xFFD4152C);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const errorRed = Color(0xFFFF0000);
  static const blueOne = Color(0xFF0000ff);
  static const blueTwo = Color(0xFF00aaff);
  static const transparent = Color(0x00000000);
  static const semiTransparent = Color(0xCC000000);
  static const orange = Color(0xFFAB5B05);
  static const darkWhiteOne = Color(0xFFF8F8F8);
  static const darkWhiteTwo = Color(0xFFe8e8e8);
  static const yellowOne = Color(0xFFFFF200);
  static const monteCarlo = Color(0xFF8DD2CA);

  static Color green300 = fromHex('#87ad6e');

  static Color red900 = fromHex('#a80000');

  static Color black9009f = fromHex('#9f000000');

  static Color red300 = fromHex('#b27759');

  static Color whiteA70095 = fromHex('#95ffffff');

  static Color deepPurple300 = fromHex('#8875ad');

  static Color green400 = fromHex('#56d384');

  static Color red100 = fromHex('#fddfca');

  static Color greenA400 = fromHex('#0fd890');

  static Color whiteA70071 = fromHex('#71ffffff');

  static Color lightGreen900 = fromHex('#437c00');

  static Color yellow400 = fromHex('#fdf04f');

  static Color whiteA70075 = fromHex('#75ffffff');

  static Color black900 = fromHex('#000000');

  static Color yellow700 = fromHex('#feb935');

  static Color deepOrange900 = fromHex('#a62900');

  static Color gray50001 = fromHex('#989e81');

  static Color teal900 = fromHex('#03373f');

  static Color deepOrangeA700 = fromHex('#f21300');

  static Color blueGray700 = fromHex('#2e635b');

  static Color deepOrange400 = fromHex('#fd764c');

  static Color cyanA700 = fromHex('#1aabcf');

  static Color redA700 = fromHex('#fc000a');

  static Color whiteA7006b = fromHex('#6bffffff');

  static Color deepOrange100 = fromHex('#fecba8');

  static Color redA20001 = fromHex('#f74a53');

  static Color pink200 = fromHex('#ed90c9');

  static Color gray500 = fromHex('#a69c92');

  static Color blueGray400 = fromHex('#8a8a8a');

  static Color blueGray600 = fromHex('#447b77');

  static Color redA200 = fromHex('#fc5e68');

  static Color lime800 = fromHex('#8bb400');

  static Color gray800 = fromHex('#665539');

  static Color lime900 = fromHex('#a05624');

  static Color gray900 = fromHex('#121718');

  static Color gray300 = fromHex('#d9dedf');

  static Color black900A6 = fromHex('#a6000000');

  static Color whiteA70082 = fromHex('#82ffffff');

  static Color tealA400 = fromHex('#2ad78b');

  static Color orange50 = fromHex('#ffebd0');

  static Color bluegray400 = fromHex('#888888');

  static Color whiteA70067 = fromHex('#67ffffff');

  static Color blueGray40001 = fromHex('#8b8b8b');

  static Color whiteA700 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
