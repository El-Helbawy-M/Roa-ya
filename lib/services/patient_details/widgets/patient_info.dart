import 'package:flutter/material.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_text_styles.dart';

class PatientInfo extends StatelessWidget {
  const PatientInfo({
    super.key,
    required this.label,
    required this.icon,
  });
  final Widget icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      height: 36,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.w600.copyWith(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
