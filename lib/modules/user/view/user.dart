import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/modules/home/viewModel/home_screen_view_model.dart';
import 'package:scheduler/modules/auth/view/login_page.dart';
import 'package:scheduler/view/utils/colors.dart';
import 'dart:convert';

import 'package:scheduler/view/utils/text_style.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenViewModel = Provider.of<HomeScreenViewModel>(context);

    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
        child: ListView(

          children: [
            Center(child: Text('${homeScreenViewModel.name}',style:TextStyles.myCustomStyle( 1.4.sp, FontWeight.w700, 20.sp,AppColors.colorBlack),)),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SizedBox(
                height: 200.h,width: 200.w,
                child:homeScreenViewModel.profileImage != null ?
                CircleAvatar(
                  backgroundImage: MemoryImage(base64Decode(homeScreenViewModel.profileImage!)),
                ): CircleAvatar(
                  backgroundColor: Colors.grey,
                  child:ClipOval(child: Image.asset('assets/app_bar_icons/user.png')),
                ),
              ),

            ),
            SizedBox(height: 20.h,),

            Center(child: Text('সফটবিডি লিমিটেড',style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w400, 14.sp,AppColors.colorGrey,),)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on,color: Colors.black,size: 16.sp,),
                Text('ঢাকা',style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w400, 14.sp, AppColors.colorGrey,),)
              ],
            ),
           SizedBox(height: 20.h,),
            Container(
              height: 46.h,
              decoration:BoxDecoration(
                gradient: AppColors.linearGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () async {
                  await homeScreenViewModel.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Center(child:  Text('লগ আউট', style: TextStyles.myCustomStyle(1.sp, FontWeight.w600, 18.sp, AppColors.colorWhite3))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
