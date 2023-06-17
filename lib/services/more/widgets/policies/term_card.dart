import 'package:flutter/material.dart';

import '../../../../helpers/app_colors.dart';
import '../../../../helpers/app_text_styles.dart';

class TermCard extends StatelessWidget {
  const TermCard({
    super.key,
    required this.index,
    required this.termText,
    required this.termTitle,
  });
  final int index;
  final String termText;
  final String termTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: .5, color: AppColors.mainColor), borderRadius: BorderRadius.circular(10), color: Colors.white),
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(10)), color: Colors.white),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: AppTextStyles.w800.copyWith(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(termTitle, style: AppTextStyles.w600.copyWith(fontSize: 18, color: AppColors.mainColor)),
              ],
            ),
          ),
          Divider(height: 0, color: AppColors.mainColor),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              termText,
              style: AppTextStyles.w400.copyWith(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
