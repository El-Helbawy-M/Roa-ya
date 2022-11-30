import 'package:flutter/material.dart';

import '../../../componants/custom_icon.dart';
import '../../../componants/custom_network_image.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_text_styles.dart';
import '../../registration/models/user_model.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  final User model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImage.circleNewWorkImage(
          radius: 45,
          image:
              "https://rewo.rw/wp-content/uploads/2022/03/7-77391_businessman-transparent-business-man-png.jpg",
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dr.${model.name ?? "No name"}",
              style:
                  AppTextStyles.w700.copyWith(fontSize: 18),
            ),
            if (model.email != null)
              const SizedBox(height: 8),
            if (model.email != null)
              Text(
                model.email ?? "",
                style: AppTextStyles.w500.copyWith(
                  fontSize: 14,
                  color: AppColors.lightHeader,
                ),
              ),
          ],
        ),
        const Expanded(child: SizedBox()),
        customImageIconSVG(
            imageName: "edit", color: AppColors.mainColor)
      ],
    );
  }
}