import 'package:flutter/material.dart';
import 'package:graduation_project/router/navigator.dart';

import '../helpers/app_colors.dart';
import '../helpers/app_text_styles.dart';
import 'custom_icon.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    this.withPadding = false,
    this.color = Colors.white,
    this.title,
    this.suffixIcon,
    this.centered = true,
    this.onSuffixTap,
  }) : super(key: key);
  final bool withPadding;
  final bool centered;
  final Color color;
  final String? title;
  final String? suffixIcon;
  final Function()? onSuffixTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: withPadding ? 24 : 0),
      child: Row(
        children: [
          InkWell(
            onTap: () => CustomNavigator.pop(),
            borderRadius: BorderRadius.circular(15),
            child: customImageIconSVG(
              imageName: "square_back_arrow",
              color: color,
            ),
          ),
          Expanded(
            child: Align(
              alignment: centered ? Alignment.center : Alignment.centerLeft,
              child: Text(
                title ?? "",
                style: AppTextStyles.w600.copyWith(
                  fontSize: 24,
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ),
          InkWell(
              onTap: onSuffixTap,
              child: customImageIconSVG(imageName: suffixIcon)),
        ],
      ),
    );
  }
}
