import 'package:flutter/material.dart';

import '../../../componants/animated_widgets.dart';
import '../../../componants/custom_icon.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_media_query.dart';
import '../../../helpers/app_text_styles.dart';

class QuickActionsPanel extends StatelessWidget {
  const QuickActionsPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 143,
      width: MediaHelper.width,
      child: ListAnimator(
        direction: Axis.horizontal,
        data: List.generate(
          5,
          (index) => Container(
            width: 142,
            height: 142,
            margin: index == 0?const EdgeInsets.only(left: 24,right: 4):const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.mainColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customImageIcon(width: 50,height: 50,imageName: "search_image"),
                RichText(
                  text: TextSpan(
                    text: "Fundus ",
                    children: [TextSpan(text: "\nDetection", style: AppTextStyles.w600.copyWith(fontSize: 13,color: Colors.white))],
                    style: AppTextStyles.w400.copyWith(fontSize: 13, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
