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
      height: 156,
      width: MediaHelper.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 24),
            ...List.generate(
              model.length,
              (index) => Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: model.actions[index],
                    child: Container(
                      width: 156,
                      height: 156,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.mainColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: customImageIconSVG(imageName: model.icons[index], color: Colors.white, width: 50, height: 50),
                          ),
                          Container(
                            width: 100,
                            height: 30,
                            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.horizontal(right: Radius.circular(15))),
                            child: Row(
                              children: [
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    model.names[index],
                                    style: AppTextStyles.w600.copyWith(fontSize: 13, color: AppColors.mainColor),
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
