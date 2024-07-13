import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/view/utils/colors.dart';
import 'package:scheduler/viewModel/landing_screen_view_model.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenViewModel>(
     builder: (context ,landingScreenViewModel,child){
       return Container(
         width: 375.w,
         height: 100.h,
         decoration: const BoxDecoration(
           borderRadius: BorderRadius.only(
             topLeft: Radius.circular(10),
             topRight: Radius.circular(10),
           ),

         ),
         child: Stack(
           children: [
             Positioned(
               left: 0,
               right: 0,
               bottom: 0,
               child: Container(
                 width: 375.w,
                 height: 75.h,
                 decoration:  const BoxDecoration(
                   color: AppColors.primaryColor,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(25),
                     topRight: Radius.circular(25),
                   ),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     InkWell(
                       onTap: (){
                         landingScreenViewModel.updateIndex(0);
                       },
                       child: Image.asset('assets/bottom_nav_bar_icons/home.png',height: 24.h,width: 24.w,),
                     )
                     ,
                     InkWell(
                       onTap: (){
                         landingScreenViewModel.updateIndex(1);
                       },
                       child: Image.asset('assets/bottom_nav_bar_icons/calendar.png',height: 24.h,width: 24.w,),
                     ),
                     SizedBox(width: 56.w), // Placeholder for the middle button
                     InkWell(
                       onTap: (){
                         landingScreenViewModel.updateIndex(2);
                       },
                       child: Image.asset('assets/bottom_nav_bar_icons/activities.png',height: 24.h,width: 24.w,),
                     ),
                     InkWell(
                       onTap: (){
                         landingScreenViewModel.updateIndex(3);
                       },
                       child: Image.asset('assets/bottom_nav_bar_icons/user.png',height: 24.h,width: 24.w,),
                     ),
                   ],
                 ),
               ),
             ),
             Positioned(
               left: 150.w,
               bottom: 35.h, // Adjusted to align with the container's height
               child: Container(
                 width: 66.sp,
                 height: 66.sp,
                 decoration: BoxDecoration(
                     color: AppColors.colorWhite2,
                     borderRadius: BorderRadius.circular(100),

                 ),
                 child: Padding(
                   padding:  EdgeInsets.symmetric(vertical: 5.h,horizontal:5.w),
                   child: Container(
                     height: 55.sp,width: 55.sp,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       gradient: const LinearGradient(
                         colors: [Color(0xFF86B560), Color(0xFF336F4A)],
                       ),
                       boxShadow: [
                         BoxShadow(
                           color: Colors.black.withOpacity(0.15),
                           offset: const Offset(1, 3),
                           blurRadius: 18,
                         ),
                       ],
                     ),
                     child:    InkWell(
                       onTap: (){
                       },
                       child: Padding(
                         padding:  EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
                         child: Image.asset('assets/bottom_nav_bar_icons/camera.png',height: 24.h,width: 24.w,),
                       ),
                     ),


                   ),
                 ),
               ),
             ),
           ],
         ),
       );
     },

    );
  }
}