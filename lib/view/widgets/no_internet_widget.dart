import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scheduler/view/utils/colors.dart';
import 'package:scheduler/view/utils/text_style.dart';

class NoInternetWidget extends StatelessWidget {
  final dynamic onPressed;
  const NoInternetWidget({super.key,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: Container(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnyImageView(
                      height: 120.h,
                      width: 120.w,
                      imagePath: "assets/no_internet/internet.json",

                      boxFit: BoxFit.cover),

                  SizedBox(height: 30.h,),

                  Text("No internet !!!",style: TextStyle(color: Colors.greenAccent),),
                  SizedBox(height: 5.h,),
                  Text("Please Check your internet connection",style: TextStyle(color: Colors.greenAccent),),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 50.w),
                    child: Container(
                      height: 46.h,
                      decoration:BoxDecoration(
                        gradient: AppColors.linearGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: onPressed,
                        child: Center(child: Text('Try Again', style: TextStyles.myCustomStyle(1.sp, FontWeight.w600, 18.sp, AppColors.colorWhite3))),
                      ),
                    ),
                  )


                ],
              ),
            ],
          ))),
    );
  }
}