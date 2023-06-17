import 'package:flutter/material.dart';
import 'package:graduation_project/router/navigator.dart';
import 'package:graduation_project/router/routes.dart';
import 'package:graduation_project/services/patients_folders/models/patients_model.dart';
import '../../../componants/custom_icon.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_media_query.dart';
import '../../../helpers/app_text_styles.dart';

class PatientFolderCard extends StatelessWidget {
  const PatientFolderCard({Key? key, required this.model}) : super(key: key);
  final Patient model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomNavigator.push(Routes.patientDetails),
      child: Container(
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
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name ?? "no name",
                      style: AppTextStyles.w600.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      model.email ?? "no email",
                      style: AppTextStyles.w600.copyWith(fontSize: 14, color: AppColors.bodyMediumColor),
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
                      Expanded(child: Text(model.history != null ? "Visit time - ${model.history}" : "no history", style: AppTextStyles.w400.copyWith(fontSize: 12, color: Colors.black))),
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
                Expanded(
                  child: Row(
                    children: [
                      customImageIconSVG(width: 16, height: 16, imageName: "calendar", color: AppColors.mainColor.withOpacity(.5)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(model.createdAt ?? "no date", style: AppTextStyles.w400.copyWith(fontSize: 12, color: Colors.black))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
