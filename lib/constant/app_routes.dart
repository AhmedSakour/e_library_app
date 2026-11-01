import 'package:flutter/material.dart';
import 'package:homework/pages/login_screen.dart';
import 'package:homework/pages/onboarding_screen.dart';
import 'package:homework/pages/serach_result_screen.dart';
import 'package:homework/pages/sign_up_screen.dart';
import 'package:homework/pages/splash_screen.dart';

class AppRoutes {
  static const login = '/LoginScreen';
  static const signUp = '/SignUpScreen';

  static const splash = '/splashView';

  static const search = '/searchView';
  static const onboarding = '/onboardingScreen';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginScreen(),
      signUp: (context) => SignUpScreen(),
      splash: (context) => const SplashScreen(),
      search: (context) => const SearchResultsScreen(),
      onboarding: (context) => const OnboardingScreen(),
    };
  }
}
