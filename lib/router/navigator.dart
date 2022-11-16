import 'package:flutter/material.dart';
import 'package:graduation_project/router/routes.dart';
import 'package:graduation_project/services/disease_detection/pages/input_page.dart';
import 'package:graduation_project/services/disease_detection/pages/output_page.dart';
import 'package:graduation_project/services/onboarding/pages/onboarding_page.dart';
import 'package:graduation_project/services/registration/pages/forget_bassword_screen.dart';
import 'package:graduation_project/services/registration/pages/reset_password_screen.dart';
import 'package:graduation_project/services/registration/pages/sign_in_screen.dart';
import 'package:graduation_project/services/registration/pages/sign_up_screen.dart';
import 'package:graduation_project/services/registration/pages/verfication_screen.dart';
import 'package:graduation_project/services/splash/pages/splash_page.dart';

import '../services/home/pages/home_screen.dart';

const begin = Offset(0.0, 1.0);
const end = Offset.zero;
const curve = Curves.easeInOut;
var tween = Tween(begin: begin, end: end).chain(
  CurveTween(curve: curve),
);

class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SignInScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
        case Routes.diseaseDetection:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const InputPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.splash:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Splash(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.onboarding:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnboardingPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.register:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SingUpScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.forgetPassword:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ForgetPasswordScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.resetPassword:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ResetPasswordScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.result:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OutputPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.verfication:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => VerficationScreen(fromSignUp: settings.arguments as bool),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case Routes.main:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
    }
    return MaterialPageRoute(builder: (_) => Container());
  }

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return navigatorState.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}
