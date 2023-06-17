import 'package:flutter/material.dart';

import '../../../componants/custom_icon.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_media_query.dart';
import '../../../helpers/app_text_styles.dart';

class AppointmentsCard extends StatelessWidget {
  const AppointmentsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 112,
          width: MediaHelper.width,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: .5, color: AppColors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ahmed Mohamed",
                    style: AppTextStyles.w600.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "ahmed@gmail.com",
                    style: AppTextStyles.w600.copyWith(fontSize: 14, color: AppColors.bodyMediumColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        customImageIconSVG(width: 16, height: 16, imageName: "timer", color: AppColors.mainColor.withOpacity(.7)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Visit time - 15:00"
                            // model.history != null ? "Visit time - ${model.history}" : "no history"
                            ,
                            style: AppTextStyles.w600.copyWith(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                    child: VerticalDivider(
                      color: AppColors.borderColor,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: [
                        customImageIconSVG(width: 16, height: 16, imageName: "calendar", color: AppColors.mainColor.withOpacity(.5)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "12-2-2021",
                            // model.createdAt ?? "no date",
                            style: AppTextStyles.w600.copyWith(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 24,
          width: 75,
          decoration: BoxDecoration(
            color: AppColors.pending.withOpacity(.2),
            borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              "Pending",
              style: AppTextStyles.w600.copyWith(fontSize: 12, color: AppColors.pending),
            ),
          ),
        )
      ],
    );
  }
}
