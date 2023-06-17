import 'package:flutter/material.dart';

import '../../../helpers/app_colors.dart';
import '../../../helpers/app_media_query.dart';
import '../../../helpers/app_text_styles.dart';

class PatientDetailsHeader extends StatelessWidget {
  const PatientDetailsHeader({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaHelper.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.mainColor.withOpacity(.2),
      ),
      child: Text(
        label,
        style: AppTextStyles.w500.copyWith(fontSize: 18),
      ),
    );
  }
}
