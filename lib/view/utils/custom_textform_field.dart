import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scheduler/view/utils/colors.dart';
import 'package:scheduler/view/utils/text_style.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final String hintText;

  final TextInputType? textInputTypeKeyboard;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final double height;
  final List<TextInputFormatter>? inputFormatters;// Add a readOnly flag

  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    required this.hintText,

    this.textInputTypeKeyboard,
    this.controller,
    this.validator,
    this.readOnly = false, this.onTap, this.inputFormatters, this.height=35,  // Initialize readOnly
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,width: 327.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(color: AppColors.colorWhite3),
        color: AppColors.colorWhite2.withOpacity(.4)
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: controller,
        keyboardType: textInputTypeKeyboard,
        validator: validator,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 10.w),
          errorMaxLines: 100,
          fillColor: AppColors.colorBlack,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hoverColor: AppColors.primaryColor,
          hintStyle: TextStyles.myCustomStyle(1.4.sp, FontWeight.w400, 14.sp, AppColors.colorGrey),
          hintText: hintText,
        ),
        obscureText: obscureText,
        readOnly: readOnly,  // Set the readOnly property
      ),
    );
  }
}
