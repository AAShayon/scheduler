
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scheduler/view/utils/text_style.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOn=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/app_icons/appbarleading.png',
          fit: BoxFit.fill,
          width: 140.sp,
          height: 37.sp,
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right:18.w ),
            child: Container(
              width:35.sp ,height: 35.sp,
              decoration: BoxDecoration(
                color: Color(0xffF4F5F6),
                borderRadius: BorderRadius.circular(100)
              ),
              child: Stack(
                children: [
                  Center(
                    child: InkWell(
                    onTap: (){
                                setState(() {
                                  isOn=!isOn;});},
                        child: Image.asset('assets/app_icons/notifications.png',width: 24.sp,height: 24.sp,)),
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
                      child: ClipOval(child: Image.asset('assets/app_icons/user.png')),


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
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Container(
                  height: 434.h,
                  decoration: BoxDecoration(
                    color: Colors.red
                  ),
                ),
              )

            ],
          ),
        ),
      ),
      drawer: const Drawer(),
    );
  }
}
