import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graduation_project/services/home/models/latest_appoinemts_mode.dart';

import '../../../componants/custom_icon.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_text_styles.dart';

class CommingAppoinmentCard extends StatelessWidget {
  const CommingAppoinmentCard({
    super.key,
    required this.appoiment,
  });
  final Appoiment appoiment;
  @override
  Widget build(BuildContext context) {
    log(appoiment.patient ?? "no name");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.containerColor.withOpacity(.8),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appoiment.patient ?? "no name", style: AppTextStyles.w500.copyWith(fontSize: 18)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: "calendar", width: 16, height: 16, color: AppColors.mainColor),
                              const SizedBox(width: 8),
                              Text(appoiment.date ?? "no date", style: AppTextStyles.w600.copyWith(fontSize: 14, color: AppColors.greyText)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              customImageIconSVG(imageName: "timer", width: 16, height: 16, color: AppColors.mainColor),
                              const SizedBox(width: 8),
                              Text(appoiment.time ?? "no time", style: AppTextStyles.w600.copyWith(fontSize: 14, color: AppColors.greyText)),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 4),
              customImageIconSVG(imageName: "forward_square", color: AppColors.mainColor, width: 36, height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
