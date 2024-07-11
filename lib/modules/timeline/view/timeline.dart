
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final timelineViewModel = Provider.of<TimelineViewModel>(context, listen: false);
      timelineViewModel.updateDate();
      timelineViewModel.setTodayDateInBangla();
      timelineViewModel.generateDateRange();
      timelineViewModel.generateBanglaDays();
      timelineViewModel.getAllData(context);
    });
  }


  // String greeting(String? timestamp, BuildContext context) {
  //   if (timestamp == null) {
  //     return 'Unknown time';
  //   }
  //   final dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
  //   final timeOfDay = TimeOfDay.fromDateTime(dateTime);
  //   final period = timeOfDay.period == DayPeriod.am
  //       ? 'সকাল'
  //       : (timeOfDay.hour < 16 ? 'দুপুর' : (timeOfDay.hour < 20 ? 'বিকেল' : (timeOfDay.hour < 22 ? 'সন্ধা' : 'রাত')));
  //   final formattedTime = timeOfDay.format(context);
  //   return '$period  $formattedTime'; //$formattedTime
  // }



  @override
  Widget build(BuildContext context) {
    return Consumer<TimelineViewModel>(builder: (context, timelineViewModel, child) {
      int currentIndex = timelineViewModel.dateRange.indexWhere((date) =>
      date.day == DateTime.now().day &&
          date.month == DateTime.now().month &&
          date.year == DateTime.now().year);

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'সময়রেখা',
            style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, const Color(0xff000000)),
          ),
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
                  width: 35.sp,
                  height: 35.sp,
                  decoration: BoxDecoration(
                      color: const Color(0xffF4F5F6),
                      borderRadius: BorderRadius.circular(100)),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 10.sp,
                          right: 8.sp,
                          child: isOn
                              ? Container(
                            width: 6.19.sp,
                            height: 6.19.sp,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          )
                              : const SizedBox.shrink()),
                      Center(
                        child: Image.asset(
                          'assets/app_bar_icons/notifications.png',
                          width: 24.sp,
                          height: 24.sp,
                        ),
                      ),
                      Positioned(
                          top: 10.sp,
                          right: 8.sp,
                          child: isOn
                              ? Container(
                            width: 6.19.sp,
                            height: 6.19.sp,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          )
                              : const SizedBox.shrink())
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric( horizontal: 27.w),
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              SizedBox(
                height: 29.h,
                width: 327.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      timelineViewModel.todayDateInBangla,
                      style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, const Color(0xff202020)),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          height: 29.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [Color(0xff86B560), Color(0xff336F4A)],
                                stops: [0.0, 1.0],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomRight,
                              )),
                          child: Center(
                            child: Text(
                              'নতুন যোগ করুন',
                              style: TextStyles.myCustomStyle(1.38.sp, FontWeight.w700, 12.sp, const Color(0xffFDFDFD)),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                  height: 98.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffFDFDFD),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff000000).withOpacity(.16),
                            blurRadius: 6,
                            offset: const Offset(0, 0))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                    child: GridView.builder(
                        controller: ScrollController(
                          initialScrollOffset: currentIndex * (100 + 10).toDouble(),
                          keepScrollOffset: true,
                        ),
                        itemCount: timelineViewModel.dateRange.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10.w,
                          crossAxisCount: 1,
                          childAspectRatio: 130 / 62.69,
                        ),
                        itemBuilder: (context, index) {
                          final date = timelineViewModel.dateRange[index];
                          final dayName = timelineViewModel.banglaDays[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: date.day == DateTime.now().day
                                        ? Colors.green
                                        : Colors.transparent,
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(dayName,
                                      style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w400, 14.sp, const Color(0xff6a6a6a))),
                                  Text(timelineViewModel.getDayNumber(date),
                                      style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w600, 16.sp, const Color(0xff202020))),
                                ],
                              ),
                            ),
                          );
                        }),
                  )),

              SizedBox(height: 20.h),
              timelineViewModel.isLoading && timelineViewModel.allData == null
                  ? const CircularProgressIndicator()
                  : Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: const Color(0xffFDFDFD)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff000000).withOpacity(.16),
                          blurRadius: 6,
                          offset: const Offset(1, 1),
                          spreadRadius: 0,
                        )
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          'আজকের কার্যক্রম',
                          style: TextStyles.myCustomStyle(1.4, FontWeight.w700, 16.sp, const Color(0xff202020)),
                        ),
                        SizedBox(height: 10.h),
                        Expanded(
                          child: ListView.builder(
                              itemCount: timelineViewModel.allData!.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                final allData = timelineViewModel.allData!;
                                allData.sort((a, b) => a.date!.compareTo(b.date!));
                                final data=allData[index];
                                log('total allData ${timelineViewModel.allData!.length}');
                                return Container(
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(vertical: 10.h),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        SizedBox(
                                          width: 80.w,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                timelineViewModel.greeting(data.date.toString(), context)['period'] ?? 'Unknown time',
                                                style: TextStyles.myCustomStyle(.9.sp, FontWeight.w500, 12.sp, const Color(0xff2A61EE)),
                                              ),
                                              SizedBox(height: 2.h,),
                                              Text(
                                                "${ timelineViewModel.greeting(data.date.toString(), context)['formattedTime'] ?? 'Unknown time'} মি.",
                                                style: TextStyles.myCustomStyle(.9.sp, FontWeight.w500, 12.sp, const Color(0xff2A61EE)),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Container(
                                        height: 150.h,
                                          width:207.w ,
                                          // margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                          decoration: BoxDecoration(
                                            color: index % 2 == 0 ? const Color(0xff202020) : null,
                                            gradient: index % 2 == 0
                                                ? null
                                                : const LinearGradient(
                                              colors: [Color(0xff86B560), Color(0xff336F4A)],
                                              stops: [0.0, 1.0],
                                            ),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Padding(
                                            // padding: const EdgeInsets.all(8.0),
                                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(Icons.access_time, color: Colors.white),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                     "${ timelineViewModel.greeting(data.date.toString(), context)['formattedTime'] ?? 'Unknown time'}মি.",
                                                      style: TextStyles.myCustomStyle(.9.sp, FontWeight.w500, 12.sp, const Color(0xffFDFDFD)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 8.h),
                                                Expanded(
                                                  child: Text(
                                                    "${data.name}",
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(height: 8.h),
                                                Text(
                                                  '${data.category}',
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                                SizedBox(height: 8.h),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.location_on, color: Colors.white),
                                                    SizedBox(width: 8.w),
                                                    Text(
                                                      '${data.location}',
                                                      style: const TextStyle(color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        drawer: const Drawer(),
        bottomNavigationBar: const BottomAppBar(),
      );
    });
  }
}