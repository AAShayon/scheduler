import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/view/utils/colors.dart';
import 'package:scheduler/view/utils/custom_textform_field.dart';
import 'package:scheduler/view/utils/text_style.dart';

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final _formKey = GlobalKey<FormState>();
  final List<String> categories = ["অনুচ্ছেদ", "বাক্য", "শব্দ"];
  final List<String> locations = ["ঢাকা, বাংলাদেশ", "চট্টগ্রাম, বাংলাদেশ"];

  final TextEditingController onussedhWriteController = TextEditingController();
  final TextEditingController onussedhDescriptionController = TextEditingController();
   final TextEditingController dateController = TextEditingController();
  String? selectedCategory;
  String? selectedLocation;

  @override
  void dispose() {
    onussedhWriteController.dispose();
    onussedhDescriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }
  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(finalDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'নতুন যোগ করুন',
          style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, const Color(0xff000000)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'অনুচ্ছেদ',
                    style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
                  ),
                  Text(
                    '৪৫ শব্দ',
                    style: TextStyles.myCustomStyle(1.2, FontWeight.w400, 14.sp, AppColors.colorGrey),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              CustomTextFormField(
                height: 35.h,
                hintText: 'অনুচ্ছেদ লিখুন',
                controller: onussedhWriteController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(45),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'অনুচ্ছেদ লিখুন';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              Text(
                'অনুচ্ছেদের বিভাগ',
                style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
              ),
              SizedBox(height: 5.h),
              Center(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorWhite2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.colorWhite2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusColor: Colors.greenAccent,
                  ),
                  value: selectedCategory,
                  hint: Text(
                    'অনুচ্ছেদের বিভাগ নির্বাচন করুন',
                    style: TextStyles.myCustomStyle(1.sp, FontWeight.w400, 13.sp, AppColors.colorGrey),
                  ),
                  icon: Icon(Icons.chevron_right),
                  items: categories
                      .map((category) => DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'অনুচ্ছেদের বিভাগ নির্বাচন করুন';
                    }
                    return null;
                  },
                ),
              ),
              Text(
                'তারিখ ও সময়',
                style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
              ),
              SizedBox(height: 5.h),
              GestureDetector(
                onTap: () async {
                  _selectDateTime(context);
                },
                child: AbsorbPointer(child: CustomTextFormField(controller: dateController, hintText: 'নির্বাচন করুন', textInputTypeKeyboard: TextInputType.name,
                )),
              ),
              SizedBox(height: 5.h),
              Text(
                'স্থান',
                style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
              ),
              SizedBox(height: 5.h),
              DropdownButtonFormField<String>(
                icon: Icon(Icons.chevron_right),
                borderRadius: BorderRadius.circular(8),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.colorWhite2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.colorWhite2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusColor: AppColors.primaryColor,
                ),
                value: selectedLocation,
                hint: Text('নির্বাচন করুন'),
                items: locations
                    .map((location) => DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'স্থান নির্বাচন করুন';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'অনুচ্ছেদের বিবরণ',
                    style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
                  ),
                  Text(
                    '১২০ শব্দ',
                    style: TextStyles.myCustomStyle(1.2, FontWeight.w400, 14.sp, AppColors.colorGrey),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              CustomTextFormField(
                height: 195.h,
                hintText: 'কার্যক্রমের বিবরণ লিখুন',
                controller: onussedhDescriptionController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(120),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'কার্যক্রমের বিবরণ লিখুন';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              Container(
                height: 46.h,
                decoration: BoxDecoration(
                  gradient: AppColors.linearGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _showSuccessDialog(context);
                    } else {
                      log('Error');
                    }
                  },
                  child: Center(
                    child: Text(
                      'সংরক্ষন করুন',
                      style: TextStyles.myCustomStyle(1.sp, FontWeight.w600, 18.sp, AppColors.colorWhite3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/app_icons/successfull.png', // Update the path to your image asset
                  height: 80.h,
                ),
                SizedBox(height: 20.h),
                Text(
                  'নতুন অনুচ্ছেদ সংরক্ষণ',
                  style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
                ),
                SizedBox(height: 10.h),
                Text(
                  'আপনার সময়রেখাতে নতুন অনুচ্ছেদ সংরক্ষণ সম্পূর্ণ হয়েছে',
                  style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w400, 14.sp, AppColors.colorGrey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 46.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppColors.linearGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                      setState(() {
                        onussedhWriteController.clear();
                        onussedhDescriptionController.clear();
                        dateController.clear();
                        selectedCategory = null;
                        selectedLocation = null;
                      });
                    },
                    child: Center(
                      child: Text(
                        'আরও যোগ করুন',
                        style: TextStyles.myCustomStyle(1.sp, FontWeight.w600, 18.sp, AppColors.colorWhite3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
