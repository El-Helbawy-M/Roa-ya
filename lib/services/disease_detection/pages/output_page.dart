import 'package:flutter/material.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';

import '../../../componants/custom_arrow_back.dart';
import '../../../helpers/app_colors.dart';
import '../../../router/navigator.dart';
import '../widgets/expandable_container.dart';

class OutputPage extends StatelessWidget {
  const OutputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => CustomNavigator.pop(),
            icon: ArrowBack(
              color: AppColors.mainColor,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        width: MediaHelper.width,
        height: MediaHelper.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:24),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.active,
                  ),
                  child: Icon(Icons.check,color: Colors.white,size: 60),
                ),
              ),
              SizedBox(height: 36),
              Text(
                "Result",
                style: AppTextStyles.w800
                    .copyWith(fontSize: 12, color: AppColors.mainColor),
              ),
              Text(
                "انت تعبان يابو حميد .. مبرووووك",
                style: AppTextStyles.w600
                    .copyWith(fontSize: 18),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical:8.0),
                child: Divider(height: 0),
              ),
              const ExpandableContainer()
            ],
          ),
        ),
      ),
    );
  }
}
