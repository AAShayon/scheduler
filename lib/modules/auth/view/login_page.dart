import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/modules/home/viewModel/home_screen_view_model.dart';
import 'package:scheduler/view/landing_screen.dart';
import 'package:scheduler/view/utils/colors.dart';
import 'package:scheduler/view/utils/custom_textform_field.dart';
import 'package:scheduler/view/utils/text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDateTime(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toIso8601String().split('T')[0];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
          child: Form(
            key: _formKey,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:40.h),
                Center(
                  child: Text(
                    'Login',
                    style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
                  ),
                ),
                SizedBox(height: 10.h,),
                Text(
                  'নাম',
                  style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
                ),
                SizedBox(height: 5.h),
                CustomTextFormField(
                  hintText: 'নাম লিখুন ', height: 35.h, controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'নাম লিখুন ';
                    }
                    return null;
                  },
                ),
                Text(
                  'যোগদান তারিখ',
                  style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
                ),
                SizedBox(height: 5.h),
                GestureDetector(
                  onTap: () async {
                    _selectDateTime(context, _startDateController);
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: _startDateController,
                      hintText: 'নির্বাচন করুন',
                      textInputTypeKeyboard: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'যোগদান তারিখ নির্বাচন করুন';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Text(
                  'শেষ তারিখ',
                  style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
                ),
                SizedBox(height: 5.h),
                GestureDetector(
                  onTap: () async {
                    _selectDateTime(context, _endDateController);
                  },
                  child: AbsorbPointer(
                    child: CustomTextFormField(
                      controller: _endDateController,
                      hintText: 'নির্বাচন করুন',
                      textInputTypeKeyboard: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'শেষ তারিখ নির্বাচন করুন';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _showPicker(context),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null ? Icon(Icons.camera_alt, size: 40) : null,
                  ),
                ),
                SizedBox(height: 10),
                if (_profileImage == null)
                  Text(
                    'ছবি নির্বাচন করুন',
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 20),
                Container(
                  height: 46.h,
                  decoration:BoxDecoration(
                    gradient: AppColors.linearGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final startDate = DateTime.parse(_startDateController.text);
                        final endDate = DateTime.parse(_endDateController.text);
                        if (startDate.isAfter(endDate)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Center(child: Text('শেষ তারিখ যোগদান তারিখের পর হওয়া উচিত')))
                          );
                        } else if (_profileImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Center(child: Text('ছবি নির্বাচন করুন')))
                          );
                        } else {
                          await Provider.of<HomeScreenViewModel>(context, listen: false).login(
                            name: _nameController.text,
                            startDate: _startDateController.text,
                            endDate: _endDateController.text,
                            profileImage: _profileImage,
                          ).then((isTrue) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LandingScreen()),
                            );
                          });
                        }
                      }
                    },
                    child: Center(child: Text('Login', style: TextStyles.myCustomStyle(1.sp, FontWeight.w600, 18.sp, AppColors.colorWhite3))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
