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
    this.initialValue,
  }) : super(key: key);

  final bool goingDown;
  final Function(String)? onSearch;
  final Function(String)? onChanged;
  final Function()? onSuffixClick;
  final String? initialValue;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: goingDown ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 200),
      firstChild: SizedBox(height: 0, width: MediaHelper.width),
      secondChild: SizedBox(
        height: 52,
        child: TextFormField(
          onChanged: onChanged,
          onFieldSubmitted: onSearch,
          initialValue: initialValue,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.searchField,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15),
                child: customImageIconSVG(imageName: "search", color: AppColors.hint),
              ),
              suffixIcon: suffixWidget,
              hintText: "Search",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none
              ),
              hintStyle: AppTextStyles.w400.copyWith(fontSize: 14, color: AppColors.hint)),
        ),
      ),
    );
  }
}
