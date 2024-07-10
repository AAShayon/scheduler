import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static const String fontFamily = 'Noto Serif Bengali';

  static TextStyle myCustomStyle(double? height,FontWeight? fontWeight,double? fontSize,Color? color) {
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        height: height,// Line-height divided by font-size
        fontWeight: fontWeight,
        color: color
    );
  }

}