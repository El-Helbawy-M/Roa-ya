import 'package:flutter/material.dart';
import 'package:graduation_project/helpers/app_media_query.dart';

import '../../../componants/custom_icon.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_text_styles.dart';

class MainOptionBtn extends StatelessWidget {
  const MainOptionBtn({
    Key? key,
    required this.title,
    required this.onClick,
    required this.iconName,
  }) : super(key: key);
  final String title,iconName;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: MediaHelper.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.mainColor.withOpacity(.3),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .1),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 85,height: 85,child: customImageIconSVG(imageName: iconName),),
            const SizedBox(height: 24),
            Text(title,style: AppTextStyles.w700.copyWith(fontSize: 26,color: AppColors.mainColor),)
          ],
        ),
      ),
    );
  }
}
