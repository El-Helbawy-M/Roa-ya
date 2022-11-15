import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/app_colors.dart';
import '../helpers/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.fieldKey,
    required this.hint,
    required this.onChange,
    this.onValidate,
    this.hasError = false,
    this.errorText = "",
    this.type = TextInputType.text,
    this.hide = false,
    this.isLarge = false,
    this.suffixIcon
  }) : super(key: key);
  final Key? fieldKey;
  final String hint;
  final String? Function(String?)? onValidate;
  final bool hasError;
  final String errorText;
  final void Function(String)? onChange;
  final TextInputType type;
  final Widget? suffixIcon;
  final bool hide;
  final bool isLarge;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint,style: AppTextStyles.w500.copyWith(fontSize: 15),),
        SizedBox(height: 8),
        SizedBox(
          height: isLarge? 80:54,
          child: TextFormField(
            key: fieldKey,
            style: AppTextStyles.w500.copyWith(fontSize: 12),
            validator: onValidate,
            onChanged: onChange,
            obscureText: suffixIcon != null ? !hide : false,
            keyboardType: type,
            decoration: InputDecoration(
              hintStyle: AppTextStyles.w500.copyWith(fontSize: 12),
              fillColor: AppColors.inputFieldColor,
              suffixIcon: suffixIcon,
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
