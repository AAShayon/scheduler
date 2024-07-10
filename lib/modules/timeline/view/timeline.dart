import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/modules/timeline/viewModel/timeline_view_model.dart';
import 'package:scheduler/view/utils/text_style.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  bool isOn = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<TimelineViewModel>(
        builder: (context, timelineViewModel, child) {
          int currentIndex = timelineViewModel.dateRange.indexWhere((date) =>
          date.day == DateTime.now().day &&
              date.month == DateTime.now().month &&
              date.year == DateTime.now().year);

          return Scaffold(
            appBar:
            AppBar(
              title: Text('সময়রেখা', style: TextStyles.myCustomStyle(
                  1.4.sp, FontWeight.w700, 16.sp, const Color(0xff000000)),),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 18.w),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        isOn = !isOn;
                      });
                    },
                    child: Container(
                      width: 35.sp, height: 35.sp,
                      decoration: BoxDecoration(
                          color: Color(0xffF4F5F6),

                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                              top: 10.sp,
                              right: 8.sp,
                              child: isOn ?
                              Container(
                                width: 6.19.sp,
                                height: 6.19.sp,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ) : SizedBox.shrink()
                          ),
                          Center(
                            child: Image.asset(
                              'assets/app_bar_icons/notifications.png',
                              width: 24.sp, height: 24.sp,),
                          ),
                          Positioned(
                              top: 10.sp,
                              right: 8.sp,
                              child: isOn ? Container(
                                width: 6.19.sp,
                                height: 6.19.sp,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ) : SizedBox.shrink()
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 27.w),
              child: SizedBox(
                height: 552.h,
                width: 327.w,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 29.h, width: 327.w,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(timelineViewModel.todayDateInBangla,
                            style: TextStyles.myCustomStyle(
                                1.4.sp, FontWeight.w700, 16.sp,
                                const Color(0xff202020)),),
                          InkWell(
                            onTap: () {},
                            child: Container(
                                height: 29.h, width: 100.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff86B560),
                                        Color(0xff336F4A)
                                      ],
                                      stops: [0.0, 1.0],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomRight,
                                    )
                                ),
                                child: Center(
                                  child: Text('নতুন যোগ করুন',
                                    style: TextStyles.myCustomStyle(
                                        1.38.sp, FontWeight.w700, 12.sp,
                                        const Color(0xffFDFDFD)),),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Container(
                        height: 98.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,

                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0xff000000).withOpacity(
                                      .16),
                                  blurRadius: 6,
                                  offset: const Offset(0, 0)
                              )
                            ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: GridView.builder(
                              controller: ScrollController(
                                initialScrollOffset: currentIndex * (100 + 10).toDouble(),
                                keepScrollOffset: true,
                              ),
                              itemCount:  timelineViewModel.dateRange.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10.w,
                                crossAxisCount: 1,
                                childAspectRatio: 100 / 62.69,

                              ),
                              itemBuilder: (context, index) {
                                final date = timelineViewModel.dateRange[index];
                                final dayName = timelineViewModel.banglaDays[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.w)
                                  , child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color:  date.day == DateTime.now().day
                                              ? Colors.green
                                              : Colors.transparent,
                                      )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(dayName,style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w400, 14.sp, const Color(0xff6a6a6a)),),
                                    Text(timelineViewModel.getDayNumber(date),style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w600, 16.sp, const Color(0xff202020)),)

                                  ],
                                  ),
                                ),

                                );
                              }),
                        )

                    ),


                  ],
                ),
              ),
            ),
            drawer: const Drawer(

            ),
          );
        }
    );
  }
}
