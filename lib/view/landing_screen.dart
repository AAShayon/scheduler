import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/modules/activities/view/activities.dart';
import 'package:scheduler/modules/home/view/home_screen.dart';
import 'package:scheduler/modules/timeline/view/timeline.dart';
import 'package:scheduler/modules/user/view/user.dart';
import 'package:scheduler/view/utils/colors.dart';
import 'package:scheduler/view/widgets/bottom_nav_bar.dart';
import 'package:scheduler/viewModel/landing_screen_view_model.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});

  final List<Widget> _screens = [
     const HomeScreen(),
    const Timeline(),
    const Activities(),
    const User(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingScreenViewModel>(
      builder: (context,landingScreenViewModel,child){
        return WillPopScope(
          onWillPop: () async {
            // final landingViewModel = Provider.of<LandingViewModel>(context,listen: false);
            if (landingScreenViewModel.currentIndex > 0) {
              landingScreenViewModel.goBackToPreviousIndex();
              return false;
            }
            else {
              bool exit = await _showExitDialog(context);
              return exit;
            }
          },
         child:Scaffold(
          body: _screens[landingScreenViewModel.currentIndex],
          bottomNavigationBar:BottomNavBar(),
        ));
      },

    );
  }
  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.colorBlack,
        title: Text('Exit App',style: TextStyle(color: AppColors.primaryColor)),
        content: Text('Are you sure you want to exit the app?',style: TextStyle(color: AppColors.colorWhite2)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',style: TextStyle(color: AppColors.primaryColor)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes',style: TextStyle(color: AppColors.primaryColor)),
          ),
        ],
      ),
    ) ?? false;
  }
}
