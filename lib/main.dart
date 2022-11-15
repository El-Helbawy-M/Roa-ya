import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation_project/config/bloc_providers.dart';
import 'package:graduation_project/network/shared_helper.dart';
import 'package:graduation_project/router/navigator.dart';
import 'package:graduation_project/router/routes.dart';
import 'package:graduation_project/services/onboarding/pages/onboarding_page.dart';

import 'core/localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: ProviderList.providers,
      child: MaterialApp(
        title: 'Roaya',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "inter",
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        // home: const OnboardingPage(),
        navigatorKey: CustomNavigator.navigatorState,
        navigatorObservers: [CustomNavigator.routeObserver],
        scaffoldMessengerKey: CustomNavigator.scaffoldState,
        onGenerateRoute: CustomNavigator.onCreateRoute,
    
        // to tell the app what the language should support
        supportedLocales: const [Locale("en"), Locale("ar")],
    
        // to tell the app what the components should follow the determined language
        localizationsDelegates: const [
          AppLocale.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale("en"),
    
        // this is a callback, it's executed when the user open the app or change the localaization of the mobile
        // what is its jop?
        // : it cheks if what is the current language of the mobile and return it for the app to follow it
        // : it cheks too if the user specified any language he need even if it's not same as the mobile language is
        localeResolutionCallback: (currentLang, supportedLangs) {
          // String? savedLgnCode = pref!.getString("lgnCode");
          if (currentLang != null) {
            for (Locale locale in supportedLangs) {
              if (locale.languageCode == currentLang.languageCode) return locale;
            }
          }
          return supportedLangs.first;
        },
      ),
    );
  }
}

