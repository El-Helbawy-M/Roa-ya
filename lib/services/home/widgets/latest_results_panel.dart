import 'package:flutter/material.dart';
import 'package:graduation_project/componants/shimmer/custom_shimmer.dart';

import '../../../componants/custom_icon.dart';
import '../../../componants/custom_network_image.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_media_query.dart';
import '../../../helpers/app_text_styles.dart';

class LatestResultsPanel extends StatelessWidget {
  const LatestResultsPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        10,
        (index) => Container(
          height: 68,
          width: MediaHelper.width,
          margin: const EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.searchField,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomNetworkImage.circleNewWorkImage(
                radius: 25,
                color: Colors.white,
                backGroundColor: Colors.white,
                image: "https://rewo.rw/wp-content/uploads/2022/03/7-77391_businessman-transparent-business-man-png.jpg",
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ahmed Emad", style: AppTextStyles.w700.copyWith(fontSize: 18)),
                  const SizedBox(height: 4),
                  Text("Ahmed Emad", style: AppTextStyles.w400.copyWith(fontSize: 12,color: AppColors.mainColor)),
                ],
              ),
              const Expanded(child: SizedBox()),
              customImageIconSVG(imageName: "square_back_ios_arrow")
            ],
          ),
        ),
      ),
    );
  }
}

class LatestResultsPanelMock extends StatelessWidget {
  const LatestResultsPanelMock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => Container(
          height: 68,
          width: MediaHelper.width,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.searchField,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomShimmerCircleImage(radius: 25,),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomShimmerText(width: 40),
                  SizedBox(height: 4),
                  CustomShimmerText(width: 60),
                ],
              ),
              const Expanded(child: SizedBox()),
              customImageIconSVG(imageName: "square_back_ios_arrow")
            ],
          ),
        ),
      ),
    );
  }
}
