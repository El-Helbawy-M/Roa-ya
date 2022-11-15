// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_project/config/bloc_providers.dart';
import 'package:graduation_project/core/localization.dart';
import 'package:graduation_project/core/validator.dart';
import 'package:graduation_project/network/shared_helper.dart';
import 'package:graduation_project/router/navigator.dart';
import 'package:graduation_project/router/routes.dart';
import 'package:graduation_project/services/registration/bloc/signIn_bloc.dart';
import 'package:graduation_project/services/registration/pages/sign_in_screen.dart';
import 'package:graduation_project/services/splash/pages/splash_page.dart';
import 'package:integration_test/integration_test.dart';

class BaseSetup extends StatelessWidget {
  const BaseSetup({required this.screen, super.key});
  final Widget screen;
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
        // initialRoute: route,
        home: screen,
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

void main() {
  SharedHelper.init();
  group("Authentaction testing", () {
    testWidgets('validation testing', (WidgetTester tester) async {
      Future<void> _loginIn(Finder btnFinder) async {
        await tester.tap(btnFinder);
        await tester.pump();
      }

      await tester.pumpWidget(const BaseSetup(screen: SignInScreen()));
      await tester.pump();
      Finder emailField = find.byKey(Key("emailField"));
      Finder passwordField = find.byKey(Key("password_field"));
      Finder btn = find.byKey(Key("login_btn"));

      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, "mohamed@gmail.com");
      expect(passwordField, findsOneWidget);
      // test when the user doesn't enter the password (1)
      await _loginIn(btn);
      expect(find.text(getLang("password_length_validation")), findsOneWidget);
      // test when the user enter the password (2)
      await tester.enterText(passwordField, "lklklklk");
      await tester.pump();
      await _loginIn(btn);
      expect(find.text(getLang("password_length_validation")), findsNothing);
    });
  });

  // group("authentaction testing", () {

  // });
}
