import 'package:graduation_project/router/navigator.dart';

class QuickAccessOptions {
  int length = 3;
  List<String> names = [
    "Fundus \nDetection",
    "Regular \nDetection",
    "Coming \nSoon",
  ];
  List<String> icons = [
    "eye_fundus",
    "regular_image",
    "soon",
  ];

  List<Function()> actions = [
    () => CustomNavigator.navigatorState, 
    () => CustomNavigator.navigatorState,
    (){}
  ];
}