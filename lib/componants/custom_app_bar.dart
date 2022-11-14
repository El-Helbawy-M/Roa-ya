import 'package:flutter/material.dart';
import 'package:graduation_project/router/navigator.dart';

import '../helpers/app_colors.dart';
import '../helpers/app_text_styles.dart';
import 'custom_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.withPadding = false,
  }) : super(key: key);
  final bool withPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: withPadding ? 24 : 0),
      child: Row(
        children: [
          InkWell(
            onTap: ()=>CustomNavigator.pop(),
            borderRadius: BorderRadius.circular(15),
            child: customImageIconSVG(imageName: "square_back_arrow"),
          ),
          const Expanded(child: Text("")),
        ],
      ),
    );
  }
}
