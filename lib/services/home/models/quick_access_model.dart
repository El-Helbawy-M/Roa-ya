import 'package:graduation_project/helpers/shared_helper.dart';
import 'package:graduation_project/router/navigator.dart';
import 'package:graduation_project/router/routes.dart';

class QuickAccessOptions {
  int length = 2;
  List<String> names = [
    "Diseases \nDetection",
    "Coming \nSoon",
  ];
  List<String> icons = [
    "eye_fundus",
    "soon",
  ];

  List<Function()> actions = [
    () => CustomNavigator.push(Routes.diseaseDetection),
    () {},
  ];
}
