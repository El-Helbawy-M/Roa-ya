import 'package:flutter/material.dart';
import 'package:graduation_project/helpers/app_colors.dart';

import '../helpers/app_media_query.dart';
import '../helpers/app_text_styles.dart';
import 'custom_icon.dart';

class EmptyContainer extends StatelessWidget {
  final String? img;
  final String? txt;
  final String? subText;
  final double? remain;
  final double? height;
  final TextStyle? subStyle;
  final bool isSvg;
  const EmptyContainer({Key? key, this.isSvg = true, this.img, this.txt, this.remain = 0.0, this.subText, this.subStyle, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        height: (MediaHelper.height - 200) - remain!,
        width: MediaHelper.width,
        child: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isSvg) Expanded(child: customImageIconSVG(imageName: img ?? "empty")),
                if (!isSvg)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(48),
                      child: Image.asset(img ?? ""),
                    ),
                  ),
                // customImageIconSVG(imageName: "empty-image"),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(txt ?? "No result found", textAlign: TextAlign.center, style: AppTextStyles.w500.copyWith(fontSize: 24, color: AppColors.mainColor)),
                ),
                if (subText != null)
                  Text(
                    subText ?? "It's like we cant find any results",
                    textAlign: TextAlign.center,
                    style: subStyle ?? AppTextStyles.w400.copyWith(fontSize: 14, color: AppColors.lightHeader),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
