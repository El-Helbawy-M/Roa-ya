import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_button.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/router/navigator.dart';

import '../../../componants/custom_arrow_back.dart';
import '../../../componants/custom_text_field.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_text_styles.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      width: MediaHelper.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Row(
              children: [
                GestureDetector(onTap: () => CustomNavigator.pop(), child: customImageIconSVG(imageName: "close-circle", color: AppColors.hint)),
                Expanded(
                  child: Center(
                    child: Text(
                      "Add Note",
                      style: AppTextStyles.w600.copyWith(fontSize: 20, color: AppColors.mainColor),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: AppTextStyles.w500.copyWith(fontSize: 14, color: AppColors.hint),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.borderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              height: 124,
              child: TextFormField(
                expands: true,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: "Write here...",
                  hintStyle: AppTextStyles.w500.copyWith(fontSize: 14, color: AppColors.hint),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.borderColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomBtn(
              text: "Add",
              onTap: () {},
              radius: 8,
              withPadding: false,
            ),
          )
        ],
      ),
    );
  }
}
