import 'package:flutter/material.dart';

import '../../../componants/custom_icon.dart';
import '../../../componants/custom_network_image.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_media_query.dart';
import '../../../helpers/app_text_styles.dart';

class PatientFolderCard extends StatelessWidget {
  const PatientFolderCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      width: MediaHelper.width,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: AppColors.blaceHolderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomNetworkImage.circleNewWorkImage(
                radius: 24,
                image: "https://images.pexels.com/photos/189857/pexels-photo-189857.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ahmed ali",
                    style: AppTextStyles.w600.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Ahmedali@gmail.com",
                    style: AppTextStyles.w600.copyWith(fontSize: 14, color: AppColors.blaceHolderColor),
                  ),
                ],
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
                    Expanded(child: Text("Visit time - 02:00PM", style: AppTextStyles.w500.copyWith(fontSize: 16, color: AppColors.lightGrey))),
                  ],
                ),
              ),
              SizedBox(
                  height: 24,
                  child: VerticalDivider(
                    color: AppColors.borderColor,
                    thickness: 1,
                  )),
              Expanded(
                child: Row(
                  children: [
                    customImageIconSVG(width: 16, height: 16, imageName: "calendar", color: AppColors.mainColor.withOpacity(.5)),
                    const SizedBox(width: 8),
                    Expanded(child: Text("12-2-20022", style: AppTextStyles.w500.copyWith(fontSize: 16, color: AppColors.lightGrey))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
