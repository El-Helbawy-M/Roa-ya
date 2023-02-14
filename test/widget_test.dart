// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_project/config/bloc_providers.dart';
import 'package:graduation_project/core/localization.dart';
import 'package:graduation_project/core/validator.dart';
import 'package:graduation_project/helpers/shared_helper.dart';
import 'package:graduation_project/router/navigator.dart';
import 'package:graduation_project/router/routes.dart';
import 'package:graduation_project/services/registration/bloc/signIn_bloc.dart';
import 'package:graduation_project/services/registration/models/user_model.dart';
import 'package:graduation_project/services/registration/pages/sign_in_screen.dart';
import 'package:graduation_project/services/registration/pages/sign_up_screen.dart';
import 'package:graduation_project/services/registration/repo/signIn_repo.dart';
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
    testWidgets('Login validation testing', (WidgetTester tester) async {
      Future<void> _loginIn(Finder btnFinder) async {
        await tester.tap(btnFinder);
        await tester.pump();
      }

      await tester.pumpWidget(BaseSetup(
          screen: SignInScreen(
        isTestMode: true,
        onTest: () {
          print("success");
        },
      )));
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
    testWidgets('Registration validation testing', (WidgetTester tester) async {
      Future<void> _loginIn(Finder btnFinder) async {
        await tester.tap(btnFinder);
        await tester.pump(Duration(seconds: 3));
      }

      await tester.pumpWidget(BaseSetup(
          screen: SingUpScreen(
        isTestMode: true,
        onTest: () {
          print("success");
        },
      )));
      await tester.pump(Duration(seconds: 2));
      Finder emailField = find.byKey(ValueKey("email"));
      Finder passwordField = find.byKey(ValueKey("password"));
      Finder nameField = find.byKey(const ValueKey("name"));
      Finder confirmPasswordField = find.byKey(ValueKey("confirm_password"));
      Finder btn = find.byKey(const ValueKey("btn"));
      expect(btn, findsOneWidget);
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(nameField, findsOneWidget);
      expect(confirmPasswordField, findsOneWidget);
      // test when the user doesn't enter the inputs (1)
      await _loginIn(btn);
      // expect(find.text(getLang("please_enter_valid_email")), findsOneWidget);
      // expect(find.text(getLang("password_length_validation")), findsOneWidget);
      // expect(find.text(getLang("enter_confirm_password_validation")), findsOneWidget);
      expect(find.text(getLang("enter_name_validation")), findsOneWidget);

      // test when the user enter the inputs (2)
      await tester.enterText(emailField, "mohamed@gmail.com");
      await tester.enterText(passwordField, "lklklklk");
      await tester.enterText(nameField, "mohamed");
      await tester.enterText(confirmPasswordField, "lklklklj");
      await tester.pump();
      await _loginIn(btn);
      expect(find.text(getLang("please_enter_valid_email")), findsNothing);
      expect(find.text(getLang("password_length_validation")), findsNothing);
      expect(find.text(getLang("confirm_password_length_validation")), findsNothing);
      expect(find.text(getLang("name_length_validation")), findsNothing);
    });
  });

  group("Authentecation logic testing", () {
    test("login function", () async {
      late FormData data;
      data = FormData.fromMap({"email": "mohamed@gmail.com", "password": "lklklklk"});
      print(data.fields);
      expect((await RegistrationRepo.signIn(data: data)).token, "28|PdddLJjeSV8anM9FQe5ALDSX9WJ2HgT3cJAxOmvI");
    });
  });
  // group("authentaction testing", () {

  // });
}
