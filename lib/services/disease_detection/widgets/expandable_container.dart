import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_arrow_back.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import '../../../helpers/app_text_styles.dart';

class ExpandableContainer extends StatefulWidget {
  const ExpandableContainer({
    // required this.label,
    // required this.value,
    // required this.onTap,
    // required this.data,
    Key? key,
  }) : super(key: key);
  // final String? label, value;
  // final Function(String) onTap;
  // final List<CustomModel> data;
  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Advice",
                  style: AppTextStyles.w800
                      .copyWith(fontSize: 12, color: AppColors.mainColor),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 400),
                  turns: isExpanded ? .25 : 0,
                  child: ArrowBackIos(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 400),
            firstChild: SizedBox(width: MediaHelper.width,),
            alignment: Alignment.center,
            secondChild: SizedBox(
              width: MediaHelper.width,
              child: Text(
                "اتنيل شوفلك دكتور",
                style: AppTextStyles.w600.copyWith(fontSize: 18),
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            secondCurve: Curves.easeInOut ,
            firstCurve: Curves.easeInOut,
            sizeCurve: Curves.easeInOut,
          ),
          // if (isExpanded)
        ],
      ),
    );
  }
}
