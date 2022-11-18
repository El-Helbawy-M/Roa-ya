import 'package:flutter/material.dart';
import 'package:graduation_project/helpers/app_colors.dart';

import '../../../componants/custom_icon.dart';
import '../../../helpers/app_text_styles.dart';

class MoreOption extends StatelessWidget {
  const MoreOption({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  final String title, icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          
          Divider(height: 0),
    
          ListTile(
            leading:
                customImageIconSVG(imageName: icon, color: AppColors.mainColor),
            title: Text(
              title,
              style: AppTextStyles.w500.copyWith(
                fontSize: 16,
                color: AppColors.lightHeader
              ),
            ),
          ),
          Divider(height: 0)
        ],
      ),
    );
  }
}
