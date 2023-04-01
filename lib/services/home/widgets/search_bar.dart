import 'package:flutter/material.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';

import '../../../componants/custom_icon.dart';
import '../../../helpers/app_text_styles.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.goingDown,
    this.onSearch,
    this.suffixWidget,
    this.onChanged,
    this.onSuffixClick,
    this.controller,
  }) : super(key: key);

  final bool goingDown;
  final Function(String)? onSearch;
  final Function(String)? onChanged;
  final Function()? onSuffixClick;
  final Widget? suffixWidget;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: TextFormField(
        onChanged: onChanged,
        onFieldSubmitted: onSearch,
        controller: controller,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: customImageIconSVG(imageName: "search", color: AppColors.hint),
            ),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: "Search",
            hintStyle: AppTextStyles.w400.copyWith(fontSize: 14, color: AppColors.hint)),
      ),
    );
  }
}


//enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColors.borderColor)),
// focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColors.borderColor)),
              