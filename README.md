# Schedule Manager App
Scheduler is a schedule manager application designed to help users manage their everyday tasks efficiently.

![intro](intro.mp4)

# Description
Scheduler is designed to keep track of daily tasks. The app categorizes tasks and provides a user-friendly interface to manage them. Below are the main features:

## Features 
     Splash Screen: The app opens with a splash screen, giving it a professional look and improving the user experience.
   
     App Icons: Custom app icons are used to give the app a unique identity.

     User Authentication: Secure login where the user must enter their name, job start date, and end date. For identification, the user must also provide an image, which can be captured using the camera or selected from the gallery.

    Landing Screen: After login, the user is directed to the landing screen, which features a bottom navigation bar. The home page is auto-selected, showing the user's information, time spent in the office, remaining time until the contract or job end date, validity, and future menu options.

    Timeline Page: Displays the user's past 7 days and next 7 days work schedule (fully implemented in the future when API is available). Currently, one API shows all plans or schedules.

   Add New Schedule: Users can add their schedules by clicking the "Add New" button. The entered fields are saved using shared preferences, and the data is displayed in the third index.

  Future Features: The camera icon on the fourth index will work in the future.

  User Page: Contains user information and a logout button.

# File Structure
      scheduler
      ├── .dart_tool/
      ├── .idea/
      ├── android/
      │   └── scheduler_android/
      │       ├── assets/
      │       │   ├── app_bar_icons/
      │       │   ├── app_icons/
      │       │   ├── app_launcher_icon/
      │       │   │   └── applaunchericon.png
      │       │   ├── bottom_nav_bar_icons/
      │       │   ├── menu_icons/
      │       │   └── no_internet/
      ├── build/
      ├── lib/
      │   ├── model/
      │   │   ├── core/
      │   │   │   └── api_urls.dart
      │   │   ├── service/
      │   │   │   └── local/
      │   │   │       └── shared_preferences.dart
      │   │   └── remote/
      │   ├── modules/
      │   │   ├── activities/
      │   │   │   └── activities.dart
      │   │   ├── auth/
      │   │   │   └── view/
      │   │   │       └── login_page.dart
      │   │   ├── home/
      │   │   │   ├── model/
      │   │   │   │   └── core/
      │   │   │   │       └── menu_model.dart
      │   │   │   ├── view/
      │   │   │   │   └── home_screen.dart
      │   │   │   └── viewModel/
      │   │   │       └── home_screen_view_model.dart
      │   │   ├── timeline/
      │   │   │   ├── model/
      │   │   │   │   └── response/
      │   │   │   │       └── all_data_response_model.dart
      │   │   │   │   └── service/
      │   │   │   │       └── timeline_data_service.dart
      │   │   │   ├── view/
      │   │   │   │   └── widgets/
      │   │   │   │       ├── add_new.dart
      │   │   │   │       └── timeline.dart
      │   │   │   └── viewModel/
      │   │   │       └── timeline_view_model.dart
      │   │   ├── user/
      │   │   │   ├── model/
      │   │   │   ├── view/
      │   │   │   │   └── user.dart
      │   │   │   └── viewModel/
      │   └── view/
      │       ├── utils/
      │       │   ├── colors.dart
      │       │   ├── custom_textform_field.dart
      │       │   └── text_style.dart
      │       ├── widgets/
      │       │   ├── bottom_nav_bar.dart
      │       │   ├── custom_clippath.dart
      │       │   ├── fade_in_animation.dart
      │       │   ├── no_internet_widget.dart
      │       │   ├── time_box.dart
      │       │   └── landing_screen.dart
      │       └── viewModel/
      │           └── landing_screen_view_model.dart
      │           └── main.dart
      ├── test/
      ├── .flutter-plugins
      ├── .flutter-plugins-dependencies
      ├── .gitignore
      ├── .metadata
      ├── analysis_options.yaml
      ├── pubspec.lock
      ├── pubspec.yaml
      ├── README.md
      └── scheduler.iml


APK 
Download [Schedule Manager APK](https://drive.google.com/file/d/14771TUuCsPHb-Q4RX-9vtq6NqJ3fvW0d/view?usp=sharing)
