import 'package:flutter/material.dart';
import 'package:graduation_project/helpers/app_colors.dart';

import '../../../helpers/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.withView = false,
    this.mentionText,
    this.onViewTap,
    this.viewColor,
  }) : super(key: key);
  final String title;
  final String? mentionText;
  final bool withView;
  final Color? viewColor;
  final Function()? onViewTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: withView? MainAxisAlignment.spaceBetween:MainAxisAlignment.start,
      children: [
        RichText(text: TextSpan(
          text: title,
          style: AppTextStyles.w500
              .copyWith(fontSize: 18, color: Colors.black),
          children: [
            if(mentionText != null)TextSpan(text: mentionText,style: TextStyle(color: AppColors.mainColor))
          ]
        )),
       if(withView) InkWell(
          onTap: onViewTap,
          child: Text(
            "View all",
            style: AppTextStyles.w500
                .copyWith(fontSize: 11, color: viewColor??AppColors.mainColor),
          ),
        )
      ],
    );
  }
}
