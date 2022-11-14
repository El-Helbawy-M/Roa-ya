import 'package:flutter/cupertino.dart';

import '../router/navigator.dart';

abstract class MediaHelper {
  static double width = MediaQuery.of(CustomNavigator.navigatorState.currentContext!).size.width;
  static double height = MediaQuery.of(CustomNavigator.navigatorState.currentContext!).size.height;
}