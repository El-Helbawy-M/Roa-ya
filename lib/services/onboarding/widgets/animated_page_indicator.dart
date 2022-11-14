import 'package:flutter/material.dart';

import '../../../helpers/app_colors.dart';

class AnimatedPageIndicatorOnboarding extends StatelessWidget {
  const AnimatedPageIndicatorOnboarding({
    Key? key,
    required this.check,
  }) : super(key: key);
  final bool check;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 20,
      height: check ? 6 : 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.mainColor,
      ),
    );
  }
}
