import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';

import '../../../componants/custom_button.dart';

class ResultBottemSheet extends StatelessWidget {
  const ResultBottemSheet({
    Key? key,
    required this.patienName,
    required this.diseasesName,
  }) : super(key: key);
  final String patienName;
  final String diseasesName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaHelper.width,
      height: 280,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 84,
            width: MediaHelper.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25),
              ),
              color: AppColors.mainColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Detectrion Result",
                  style: AppTextStyles.w700.copyWith(fontSize: 24, color: Colors.white),
                ),
                customImageIconSVG(imageName: "file_download_icon")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diseasesName,
                  style: AppTextStyles.w700.copyWith(fontSize: 32, color: AppColors.mainColor),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Text(
                    patienName,
                    style: AppTextStyles.w500.copyWith(fontSize: 24, color: Colors.black),
                  ),
                ),
                Text(
                  "Detection Date",
                  style: AppTextStyles.w500.copyWith(fontSize: 18, color: AppColors.lightHeader),
                ),
                const SizedBox(height: 8),
                Text(
                  TimeOfDay.now().format(context),
                  style: AppTextStyles.w600.copyWith(fontSize: 24, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
