
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/modules/home/model/core/menu_model.dart';
import 'package:scheduler/modules/home/viewModel/home_screen_view_model.dart';
import 'package:scheduler/modules/timeline/view/timeline.dart';
import 'package:scheduler/view/utils/text_style.dart';
import 'package:scheduler/view/widgets/time_box.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOn=true;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenViewModel>(
      builder: (context,homeScreenViewModel,child) {
        final remainingTime=homeScreenViewModel.remainingTime;
        return Scaffold(
          appBar:
          AppBar(
            title: Image.asset(
              'assets/app_bar_icons/appbarleading.png',
              fit: BoxFit.fill,
              width: 140.sp,
              height: 37.sp,
            ),
            actions: [
              Padding(
                padding:  EdgeInsets.only(right:18.w ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: (){
                    setState(() {
                      isOn=!isOn;});
                  },
                  child: Container(
                    width:35.sp ,height: 35.sp,
                    decoration: BoxDecoration(
                        color: Color(0xffF4F5F6),

                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            top: 10.sp,
                            right: 8.sp,
                            child:isOn ?
                            Container(
                              width: 6.19.sp,
                              height: 6.19.sp,
                              decoration: BoxDecoration(
                                color:Colors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ):SizedBox.shrink()
                        ),
                        Center(
                          child: Image.asset('assets/app_bar_icons/notifications.png',width: 24.sp,height: 24.sp,),
                        ),
                        Positioned(
                            top: 10.sp,
                            right: 8.sp,
                            child:isOn ? Container(
                              width: 6.19.sp,
                              height: 6.19.sp,
                              decoration: BoxDecoration(
                                color:Colors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ):SizedBox.shrink()
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding:  EdgeInsets.symmetric(vertical: 20.h,horizontal: 27.w),
            child: SizedBox(
              height: 552.h,
              width: 327.w,
              child: ListView(
                children: [
                  Container(
                    height: 98.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff000000).withOpacity(.16),
                          blurRadius: 6,
                          offset: const Offset(0, 0)
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: SizedBox(
                        height: 60.h,width: 60.w,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: ClipOval(child: Image.asset('assets/app_bar_icons/user.png')),


                        ),
                      ),

                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('মোঃ মোহাইমেনুল রেজা',style:TextStyles.myCustomStyle( 1.4.sp, FontWeight.w700, 20.sp,const Color(0xff202020)),),
                         SizedBox(
                           height: 38.h,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('সফটবিডি লিমিটেড',style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w400, 14.sp,const Color(0xff6a6a6a),),),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Icon(Icons.location_on,color: Colors.black,size: 16.sp,),
                                   Text('ঢাকা',style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w400, 14.sp, const Color(0xff6a6a6a)),)
                                 ],
                               )
                             ],
                           ),
                         )

                        ],
                      ),
                    ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  SizedBox(
                    height: 138.h,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 108.h,
                              width: 108.w,
                              child: Stack(
                                children: [
                                  CustomPaint(
                                    size: Size(108.w, 108.h),
                                    painter: CircularProgressPainter(homeScreenViewModel.progress),
                                  ),
                                  Positioned(
                                    top: 45.h,
                                    left: 15.w,
                                    child: Text(
                                      homeScreenViewModel.elapsedTimeString,
                                      style: TextStyles.myCustomStyle(1.42.sp, FontWeight.w600, 14.sp, const Color(0xff202020)),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                            SizedBox(height: 5.h,),
                            Text('সময় অতিবাহিত',style: TextStyles.myCustomStyle(1.4, FontWeight.w700, 16.sp, const Color(0xff202020)),)
                          ],
                        ),
                        SizedBox(width: 20.w,),
                        Padding(
                          padding:  EdgeInsets.only(top: 20.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'মেয়াদকাল',
                                style: TextStyles.myCustomStyle(1.2, FontWeight.w700, 16.sp, const Color(0xff202020)),
                              ),
                              SizedBox(height: 3.h,),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month,color: Colors.black,size: 14.sp,),
                                  Text(
                                    '১ই জানুয়ারি ২০২৪ - ৩১ই জানুয়ারি ২০৩০',
                                    style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w500, 11.sp, const Color(0xff202020)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Text('আরও বাকি',style: TextStyles.myCustomStyle(1.4, FontWeight.w700, 16.sp, const Color(0xffff737a)),),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   TimeBoxWidget(timesName: 'বছর',subTimes:remainingTime['years'].toString().length > 1 ? homeScreenViewModel.convertToBanglaDigits(remainingTime['years'].toString().split('').first):homeScreenViewModel.convertToBanglaDigits('0') ,subTimes2: homeScreenViewModel.convertToBanglaDigits(remainingTime['years'].toString().split('').last),),
                                  SizedBox(width: 15.w,),
                                   TimeBoxWidget(timesName: 'মাস',subTimes:remainingTime['months'].toString().length >1 ? homeScreenViewModel.convertToBanglaDigits(remainingTime['months'].toString().split('').first):homeScreenViewModel.convertToBanglaDigits('0') ,subTimes2:homeScreenViewModel.convertToBanglaDigits(remainingTime['months'].toString().split('').last)
                                   // '${remainingTime['months']}',

                                   ),
                                  SizedBox(width: 15.w,),
                                   TimeBoxWidget(timesName: 'দিন',subTimes:remainingTime['days'].toString().length >1 ?  homeScreenViewModel
                                       .convertToBanglaDigits(remainingTime['days']
                                       .toString().split('').first):homeScreenViewModel.convertToBanglaDigits('0'),
                                     subTimes2:homeScreenViewModel
                                         .convertToBanglaDigits(remainingTime['days']
                                         .toString().split('').last)
                                     // '${remainingTime['days']}'
                                     ,
                                   ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                  ),
                  SizedBox(height: 20.h,),
                  Container(

                    height: 272.h,
                    width: 327.w,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: menuImages.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 80/90

                      ),
                      itemBuilder: (context,index) {
                        return Container(
                          height: 124.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.2),
                            color: const Color(0xfff6f6f6),

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(menuImages[index].imageLink,height: 33.6.h,width: 32.7.w,),
                              SizedBox(height: 2.h,),
                              Text('মেনু নং',style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w600, 16.sp, const Color(0xff202020)),),
                              SizedBox(height: 2.h,),
                              Text('০০০০১',style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w600, 16.sp, const Color(0xff202020)),),
                            ],
                          ),
                        );
                      }
                    ),
                  )

                ],
              ),
            ),
          ),
          drawer:  Drawer(
            width: 300.w,
            backgroundColor: Colors.white,
            child: SafeArea(
              child: Column(
                children: [
                  IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Timeline()));}, icon:Icon(Icons.settings)),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}



class CircularProgressPainter extends CustomPainter {
  final double progress;

  CircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = const Color(0xFFF5F5F5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    final Paint progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xff86B560), Color(0xff336F4A)],
        stops: [0.0, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,

      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    const double startAngle = 90 * 3.1415927 / 180;
    final double sweepAngle = 360 * progress * 3.1415927 / 180;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2,
        backgroundPaint);
    canvas.drawArc(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2), startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

