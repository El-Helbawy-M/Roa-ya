import 'package:flutter/material.dart';

import '../helpers/app_colors.dart';
import '../helpers/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.onChange,
    this.onValidate,
    this.hasError = false,
    this.errorText = "",
  }) : super(key: key);
  final String hint;
  final String? Function(String?)? onValidate;
  final bool hasError;
  final String errorText;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint,style: AppTextStyles.w500.copyWith(fontSize: 15),),
        SizedBox(height: 8),
        SizedBox(
          height: 54,
          child: TextFormField(
            style: AppTextStyles.w500.copyWith(fontSize: 12),
            validator: onValidate,
            onChanged: onChange,
            decoration: InputDecoration(
              hintStyle: AppTextStyles.w500.copyWith(fontSize: 12),
              fillColor: AppColors.inputFieldColor,
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal:16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none
              ),
              
            ),
          ),
        ),
        if(hasError) Text(errorText,style: AppTextStyles.w400.copyWith(fontSize: 14,color: AppColors.inActive),),
      ],
    );
  }
}
