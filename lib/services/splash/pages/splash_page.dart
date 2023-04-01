import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/helpers/app_colors.dart';

import '../../../componants/animated_widgets.dart';
import '../../../core/app_events.dart';
import '../bloc/splash_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      context.read<SplashBloc>().add(Click());
    });
    return Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Center(
          key: Key("root"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //     padding: EdgeInsets.symmetric(vertical: 70.0),
              //     child: RichText(
              //       text: TextSpan(text: "coursafer App",  style: TextStyle(
              //           fontSize: 15,
              //           fontWeight: FontWeight.w500,
              //           color: Styles.WHITE_COLOR)),
              //     )),
              Expanded(
                child: AnimatedWidgets(
                  durationMilli: 2000.0,
                  verticalOffset: 0.0,
                  horizontalOffset: 0.0,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    customImageIcon(imageName: "logo", width: 226, height: 48),
                    SizedBox(width: 25),
                  ]),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: RichText(
                    text: TextSpan(text: "Powerd By", children: [TextSpan(text: " Roa'ya", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white))], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                  )),
            ],
          ),
        ));
  }
}
