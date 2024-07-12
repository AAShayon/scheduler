import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
 
import 'package:scheduler/modules/home/viewModel/home_screen_view_model.dart';
import 'package:scheduler/modules/timeline/viewModel/timeline_view_model.dart';
import 'package:scheduler/view/landing_screen.dart';
import 'package:scheduler/view/utils/colors.dart';
import 'package:scheduler/modules/auth/view/login_page.dart';
import 'package:scheduler/viewModel/landing_screen_view_model.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);

    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context ,child){
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=>LandingScreenViewModel()),
            ChangeNotifierProvider(create: (context)=>HomeScreenViewModel()),
            ChangeNotifierProvider(create: (context)=>TimelineViewModel())
          ],
          child: Consumer<HomeScreenViewModel>(
            builder: (context,homeScreenViewModel,child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.colorWhite2,
                primaryTextTheme: GoogleFonts.notoSerifBengaliTextTheme(),
                textTheme: GoogleFonts.notoSerifBengaliTextTheme(),
                appBarTheme: const AppBarTheme(
                  color: AppColors.primaryColor,
                ),

              ),
                home: FutureBuilder(
                  future: homeScreenViewModel.isLoggedIn(),
                  builder: (context, AsyncSnapshot<bool> snapshot){
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return snapshot.data! ? LandingScreen() : LoginPage();
                  },
                ),
              );
            }
          ),
        );
      },
    );
  }
}
