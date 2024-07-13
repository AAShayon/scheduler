
import 'dart:developer';
import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/modules/timeline/view/widgets/add_new.dart';
import 'package:scheduler/modules/timeline/viewModel/timeline_view_model.dart';
import 'package:scheduler/view/utils/colors.dart';
import 'package:scheduler/view/utils/text_style.dart';
import 'package:scheduler/view/widgets/fade_in_animation.dart';
import 'package:scheduler/view/widgets/no_internet_widget.dart';

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
     _loadData(context);
    });
  }
  Future<void> _loadData(BuildContext context) async {
    final timelineViewModel = Provider.of<TimelineViewModel>(
        context, listen: false);
    timelineViewModel.updateDate();
    timelineViewModel.setTodayDateInBangla();
    timelineViewModel.generateDateRange();
    timelineViewModel.generateBanglaDays();
    timelineViewModel.getAllData(context);
  }

    @override
  Widget build(BuildContext context) {
    return Consumer<TimelineViewModel>(builder: (context, timelineViewModel, child) {

      return RefreshIndicator(
        onRefresh: ()async{
          await _loadData(context);
        },
        child: Scaffold(
          backgroundColor: AppColors.colorWhite2,
          appBar: AppBar(
            title: Text(
              'সময়রেখা',
              style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp, AppColors.colorBlack2),
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
                        color: AppColors.containerBoxDecoration,
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
                                color: AppColors.colorPink,
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
                                color: AppColors.colorPink,
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
          body: Provider.of<InternetConnectionStatus>(context) ==
              InternetConnectionStatus.disconnected
              ?NoInternetWidget(
            onPressed: ()async{
              await _loadData(context);
            },
          ) :Padding(
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
                        style: TextStyles.myCustomStyle(1.4.sp, FontWeight.w700, 16.sp,  AppColors.colorBlack),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNew()));
                        },
                        child: Container(
                            height: 29.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: AppColors.linearGradient,
                            ),
                            child: Center(
                              child: Text(
                                'নতুন যোগ করুন',
                                style: TextStyles.myCustomStyle(1.38.sp, FontWeight.w700, 12.sp, AppColors.colorWhite3),
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
                        color: AppColors.colorWhite3,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.colorBlack2.withOpacity(.16),
                              blurRadius: 6,
                              offset: const Offset(0, 0))
                        ]),
                    child:  timelineViewModel.isLoading
                        ? Center(child: CircularProgressIndicator(backgroundColor: AppColors.colorBlack,)): Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      child: GridView.builder(
                          itemCount: timelineViewModel.dateRange.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10.w,
                            crossAxisCount: 1,
                            childAspectRatio: 130 / 62.69,
                          ),
                          itemBuilder: (context, index) {
                            DateTime date = DateTime.now().subtract(Duration(days: 7 - index));
                            final dayName = timelineViewModel.banglaDays[index];
                            return FadeInAnimation(
                              direction: FadeInDirection.rtl,
                              delay: .2 + index,
                              fadeOffset: index == 0 ? 80 : 80.0 * index,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: GestureDetector(
                                  onTap: () => timelineViewModel.setDate(date),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: date.day == timelineViewModel.selectedDate.day ? Colors.green : Colors.transparent,
                                        )),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(dayName,
                                            style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w400, 14.sp, AppColors.colorGrey)),
                                        Text(timelineViewModel.getDayNumber(date),
                                            style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w600, 16.sp,  AppColors.colorBlack)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )),

                SizedBox(height: 20.h),
                !timelineViewModel.isLoading && timelineViewModel.allData != null
                    ? timelineViewModel.allData.isNotEmpty ? Expanded(child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: AppColors.colorWhite3),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.colorBlack2.withOpacity(.16),
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
                            style: TextStyles.myCustomStyle(1.4, FontWeight.w700, 16.sp,  AppColors.colorBlack),
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
                                  return FadeInAnimation(
                                    direction: FadeInDirection.btt,
                                    delay: .5 + index,
                                    fadeOffset: index == 0 ? 80 : 80.0 * index,
                                    child: Container(
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
                                                    style: TextStyles.myCustomStyle(.9.sp, FontWeight.w500, 12.sp,index % 2 == 0 ?  AppColors.colorBlack : AppColors.textColorBlue),
                                                  ),
                                                  SizedBox(height: 2.h,),
                                                  Text(
                                                    "${ timelineViewModel.greeting(data.date.toString(), context)['formattedTime'] ?? 'Unknown time'} মি.",
                                                    style: TextStyles.myCustomStyle(.9.sp, FontWeight.w500, 12.sp,index % 2 == 0 ?  AppColors.colorBlack : AppColors.textColorBlue),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Container(
                                            height: 150.h,
                                              width:207.w ,
                                              decoration: BoxDecoration(
                                                color: index % 2 == 0 ?  AppColors.colorBlack : null,
                                                gradient: index % 2 == 0
                                                    ? null
                                                    : AppColors.linearGradient,
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                         const Icon(Icons.access_time, color: AppColors.primaryColor),
                                                        SizedBox(width: 8.w),
                                                        Text(
                                                         "${ timelineViewModel.greeting(data.date.toString(), context)['formattedTime'] ?? 'Unknown time'}মি.",
                                                          style: TextStyles.myCustomStyle(.9.sp, FontWeight.w500, 12.sp, AppColors.colorWhite3),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    Expanded(
                                                      child: Text(
                                                        "${data.name}",
                                                          style: TextStyles.myCustomStyle(1.sp, FontWeight.w600, 14.sp, AppColors.colorWhite3),
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    Text(
                                                      '${data.category}',
                                                      style: TextStyles.myCustomStyle(.9.sp, FontWeight.w500, 12.sp, AppColors.colorWhite3),
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.location_on, color: Colors.white),
                                                        SizedBox(width: 8.w),
                                                        Text(
                                                          '${data.location}',
                                                          style: TextStyles.myCustomStyle(.9.sp, FontWeight.w500, 12.sp, AppColors.colorWhite3),
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
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ):Center(child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 70.h),
                  child: Column(
                    children: [
                     Center(child: AnyImageView(imagePath: 'assets/app_icons/sad.json',height: 250.h,width: 250.w,)),
                      SizedBox(height: 20.h,),
                      Text('কোনো কার্যক্রম লিপিবদ্ধ নেই',style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w400, 14.sp, AppColors.colorGrey))
                    ],
                  ),
                )):Center(child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 70.h),
                  child: Column(
                    children: [
                       CircularProgressIndicator(color: Colors.black,),
                      SizedBox(height: 20.h,),
                      Text('Data Is Loading.......',style: TextStyles.myCustomStyle(1.2.sp, FontWeight.w400, 14.sp, AppColors.colorGrey))
                    ],
                  ),
                ))
              ],
            ),
          ),
          drawer: const Drawer(),
        ),
      );
    });
  }
}