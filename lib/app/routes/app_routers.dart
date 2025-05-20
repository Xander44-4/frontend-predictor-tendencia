import 'package:app_movil_pta/app/ui/screens/home.dart';
import 'package:app_movil_pta/app/ui/screens/login_screen.dart';
import 'package:app_movil_pta/app/ui/screens/signup_screen.dart';
import 'package:flutter/material.dart';


class AppRouters {
  static const String homeScreen = "/home";
  static const String loginScreen = "/login";
  static const String signUpScreen = "/SignUp";

  static Map<String, WidgetBuilder> getRouters() {
    return {
      loginScreen: (context) => const LoginScreen(),
      signUpScreen: (context) => const SignupScreen(),
      homeScreen: (context) => const HomeScreen()
    };
  }
}
