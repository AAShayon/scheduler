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
         width: 375,
         height: 99,
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
                 width: 375,
                 height: 75,
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
                     IconButton(
                       icon: const Icon(Icons.home),
                       onPressed: () {
                         landingScreenViewModel.updateIndex(0);

                       },
                     ),
                     IconButton(
                       icon: const Icon(Icons.calendar_today),
                       onPressed: () {
                         landingScreenViewModel.updateIndex(1);

                       },
                     ),
                     SizedBox(width: 56.w), // Placeholder for the middle button
                     IconButton(
                       icon: const Icon(Icons.list),
                       onPressed: () {
                         landingScreenViewModel.updateIndex(2);
                       },
                     ),
                     IconButton(
                       icon: const Icon(Icons.person),
                       onPressed: () {
                         landingScreenViewModel.updateIndex(3);

                       },
                     ),
                   ],
                 ),
               ),
             ),
             Positioned(
               left: 159.w,
               bottom: 28.h, // Adjusted to align with the container's height
               child: Container(
                 width: 58.sp,
                 height: 58.sp,
                 decoration: BoxDecoration(
                     color: AppColors.colorWhite2,
                     borderRadius: BorderRadius.circular(100)
                 ),
                 child: Padding(
                   padding:  EdgeInsets.symmetric(vertical: 4.h,horizontal:4.w),
                   child: Container(
                     height: 56.sp,width: 56.sp,
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
                     child: IconButton(
                       icon: const Icon(Icons.camera_alt, color: Colors.white),
                       onPressed: () {},
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