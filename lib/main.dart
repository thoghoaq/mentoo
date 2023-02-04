// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mentoo/screens/book_appointment.dart';
import 'package:mentoo/screens/choose_major.dart';
import 'package:mentoo/screens/dialog.dart';
import 'package:mentoo/screens/edit_education.dart';
import 'package:mentoo/screens/edit_job.dart';
import 'package:mentoo/screens/edit_profile.dart';
import 'package:mentoo/screens/favorite_courses.dart';
import 'package:mentoo/screens/follow_mentors.dart';
import 'package:mentoo/screens/get_started.dart';
import 'package:mentoo/screens/home_page.dart';

import 'package:mentoo/screens/main_home_page.dart';
import 'package:mentoo/screens/meeting_end.dart';
import 'package:mentoo/screens/mentor_detail.dart';
import 'package:mentoo/screens/my_appointments.dart';
import 'package:mentoo/screens/notification.dart';
import 'package:mentoo/screens/profile.dart';
import 'package:mentoo/screens/recommend_courses.dart';

import 'package:mentoo/screens/make_your_schedule.dart';
import 'package:mentoo/screens/mentor_profile.dart';
import 'package:mentoo/screens/settings_page.dart';

import 'package:mentoo/screens/search.dart';
import 'package:mentoo/screens/sign_in.dart';
import 'package:mentoo/screens/sign_up.dart';
import 'package:mentoo/screens/specialist_mentors.dart';
import 'package:mentoo/screens/top_mentor.dart';
import 'package:mentoo/screens/write_review.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/widgets/mentor_profile.dart';

// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => const MyApp(), // Wrap your app
//       ),
//     );

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentoo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: AppColors.mPrimary,
        accentColor: AppColors.mDarkPurple,
        backgroundColor: AppColors.mBackground,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: AppColors.mText),
        ),
      ),
      home: RecommendCourses(),
    );
  }
}
