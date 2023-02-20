import 'package:flutter/material.dart';

import '../../../componants/custom_icon.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_text_styles.dart';

class MoreOption extends StatelessWidget {
  const MoreOption({Key? key, this.isLogout = false, required this.label, required this.iconName, required this.onTap}) : super(key: key);
  final String label, iconName;
  final Function() onTap;
  final bool isLogout;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          leading: customImageIconSVG(imageName: iconName, color: isLogout ? AppColors.inActive : AppColors.mainColor),
          minLeadingWidth: 20,
          title: Text(label, style: AppTextStyles.w500.copyWith(fontSize: 18)),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: isLogout ? AppColors.inActive : AppColors.mainColor, size: 16),
          onTap: onTap,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Divider(height: 0),
        ),
      ],
    );
  }
}
