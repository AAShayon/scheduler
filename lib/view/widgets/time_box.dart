import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scheduler/view/utils/text_style.dart';
class TimeBoxWidget extends StatelessWidget {
  final String timesName;
  final String subTimes;
  final String subTimes2;
  const TimeBoxWidget({
    super.key, required this.timesName, required this.subTimes, required this.subTimes2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.h,
      width: 52.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Color(0xffFF737A)
                    )
                ),
                child: Center(child: Text(subTimes,style: TextStyles.myCustomStyle(.9, FontWeight.w500, 12.sp, Colors.black),)),
              ),
              SizedBox(width: 4.w,),
              Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: Color(0xffFF737A)
                    )
                ),
                child: Center(child: Text(subTimes2,style: TextStyles.myCustomStyle(.9, FontWeight.w500, 12.sp, Colors.black),)),
              ),
            ],
          ),

          Text(timesName,)

        ],
      ),
    );
  }
}