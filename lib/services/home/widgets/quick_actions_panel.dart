import 'package:flutter/material.dart';
import 'package:graduation_project/services/home/models/quick_access_model.dart';

import '../../../componants/animated_widgets.dart';
import '../../../componants/custom_icon.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_media_query.dart';
import '../../../helpers/app_text_styles.dart';

class QuickActionsPanel extends StatelessWidget {
  QuickActionsPanel({
    Key? key,
  }) : super(key: key);
  final QuickAccessOptions model = QuickAccessOptions();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 143,
      width: MediaHelper.width,
      child: ListAnimator(
        direction: Axis.horizontal,
        data: List.generate(
          model.length,
          (index) => Padding(
            padding: index == 0?const EdgeInsets.only(left: 24,right: 8):const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: model.actions[index],
              child: Container(
                width: 142,
                height: 142,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.mainColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 50,height: 50,child: customImageIconSVG(imageName: model.icons[index],color: Colors.white)),
                    Text(model.names[index],style: AppTextStyles.w600.copyWith(fontSize: 13,color: Colors.white),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
