import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/config/bloc_providers.dart';
import 'package:graduation_project/router/routes.dart';
import 'package:graduation_project/services/disease_detection/bloc/uploader_bloc.dart';
import 'package:graduation_project/services/disease_detection/pages/input_page.dart';
import 'package:graduation_project/services/disease_detection/pages/output_page.dart';
import 'package:graduation_project/services/home/widgets/search_bar.dart';
import 'package:graduation_project/services/main_pages/main_page.dart';
import 'package:graduation_project/services/more/pages/policies_screen.dart';
import 'package:graduation_project/services/onboarding/pages/onboarding_page.dart';
import 'package:graduation_project/services/registration/bloc/register_bloc.dart';
import 'package:graduation_project/services/registration/pages/forget_bassword_screen.dart';
import 'package:graduation_project/services/registration/pages/reset_password_screen.dart';
import 'package:graduation_project/services/registration/pages/sign_in_screen.dart';
import 'package:graduation_project/services/registration/pages/sign_up_screen.dart';
import 'package:graduation_project/services/registration/pages/verfication_screen.dart';
import 'package:graduation_project/services/search/blocs/recent_keyword_cubit.dart';
import 'package:graduation_project/services/search/blocs/search_bloc.dart';
import 'package:graduation_project/services/search/pages/search_screen.dart';
import 'package:graduation_project/services/splash/pages/splash_page.dart';

import '../services/home/pages/home_screen.dart';
import '../services/registration/bloc/signIn_bloc.dart';
import '../services/splash/bloc/splash_bloc.dart';

const begin = Offset(0.0, 1.0);
const end = Offset.zero;
const curve = Curves.easeInOut;
var tween = Tween(begin: begin, end: end).chain(
  CurveTween(curve: curve),
);

class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState = GlobalKey<ScaffoldMessengerState>();

  static _routeTo(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return _routeTo(
          BlocProvider(
            create: (context) => SignInBloc(),
            child: const SignInScreen(),
          ),
        );
      case Routes.diseaseDetection:
        return _routeTo(BlocProvider(
          create: (context) => UploaderBloc(),
          child: const InputPage(),
        ));
      case Routes.splash:
        return _routeTo(BlocProvider(
          create: (context) => SplashBloc(),
          child: const Splash(),
        ));
      case Routes.onboarding:
        return _routeTo(const OnboardingPage());
      case Routes.register:
        return _routeTo(
          BlocProvider(
            create: (context) => RegisterBloc(),
            child: const SingUpScreen(),
          ),
        );
      case Routes.forgetPassword:
        return _routeTo(const ForgetPasswordScreen());
      case Routes.resetPassword:
        return _routeTo(const ResetPasswordScreen());
      case Routes.result:
        return _routeTo(const OutputPage());

      case Routes.verfication:
        return _routeTo(VerficationScreen(fromSignUp: settings.arguments as bool));
      case Routes.main:
        return _routeTo(MultiBlocProvider(
          providers: ProviderList.providers,
          child: const MainPage(),
        ));
      case Routes.search:
        return _routeTo(MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => RecentKeywordCubit()..init()),
            BlocProvider(create: (context) => SearchBloc()),
          ],
          child: const SearchPage(),
        ));
      case Routes.policies:
        return _routeTo(const PoliciesScreen());
    }
    return MaterialPageRoute(builder: (_) => Container());
  }

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName, {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return navigatorState.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }
}
