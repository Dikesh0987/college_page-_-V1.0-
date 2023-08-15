
import 'package:college_page/screens/auth/login_screen.dart';
import 'package:college_page/screens/auth/signup_screen.dart';
import 'package:college_page/screens/college_profile/college_profile.dart';
import 'package:college_page/screens/colleges/colleges.dart';
import 'package:college_page/screens/profile/profile.dart';
import 'package:college_page/screens/user_profile/user_profile.dart';
import 'package:college_page/widget/colleges/colleges_widget.dart';
import 'package:flutter/material.dart';
import 'package:college_page/screens/home/home_screen.dart';

import '/core/route/app_route_name.dart';

class AppRoute {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
    }
    switch (settings.name) {
      case AppRouteName.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
    }
    switch (settings.name) {
      case AppRouteName.signup:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
          settings: settings,
        );
    }
  
    switch (settings.name) {
      case AppRouteName.userprofile:
        return MaterialPageRoute(
          builder: (_) => const UserProfile(),
          settings: settings,
        );
    }
    switch (settings.name) {
      case AppRouteName.colleges:
        return MaterialPageRoute(
          builder: (_) => const CollegesScreen(),
          settings: settings,
        );
    }
    switch (settings.name) {
      case AppRouteName.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );
    }

    return null;
  }
}
