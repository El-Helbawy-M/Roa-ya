import 'package:flutter/material.dart';
import 'package:graduation_project/componants/animated_widgets.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import '../../../componants/custom_app_bar.dart';
import '../../../componants/custom_arrow_back.dart';
import '../../../componants/custom_button.dart';
import '../../../componants/custom_icon.dart';
import '../../../componants/custom_text_field.dart';
import '../../../core/localization.dart';
import '../../../core/validator.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_media_query.dart';
import '../../../router/navigator.dart';
import '../../../router/routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool filled = false;
  String password = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaHelper.width,
          height: MediaHelper.height,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const CustomAppBar(
                  withPadding: true,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: customImageIcon(
                      imageName: "logo",
                      height: 132,
                      width: 195,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(50)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(24),
                    child: ListAnimator(
                      data: [
                        const SizedBox(height: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              getLang("Reset new password"),
                              style: AppTextStyles.w700.copyWith(
                                  fontSize: 26, color: AppColors.mainColor),
                            ),
                            SizedBox(height: 4),
                            Text(
                              getLang("Enter reset password"),
                              style: AppTextStyles.w400.copyWith(
                                  fontSize: 16, color: AppColors.mainColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        CustomTextField(
                            hint: getLang("password"),
                            onChange: (value) => setState(() {
                                  password = value;
                                  if (value.isNotEmpty) {
                                    filled = true;
                                  } else {
                                    filled = false;
                                  }
                                }),
                            onValidate: (value) =>
                                PasswordValidator.passwordValidator(value)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          child: CustomTextField(
                              hint: getLang("confirm_password"),
                              onChange: (value) {
                                if (value.isNotEmpty) {
                                  filled = true;
                                } else {
                                  filled = false;
                                }
                              },
                              onValidate: (value) =>
                                  PasswordConfirmationValidator
                                      .passwordValidator(password, value)),
                        ),
                        CustomBtn(
                          text: getLang("submit").toUpperCase(),
                          onTap: () {
                            if (_formKey.currentState!.validate())
                              CustomNavigator.push(Routes.login, clean: true);
                          },
                          btnHeight: 44,
                          txtColor: filled ? Colors.white : AppColors.lightGrey,
                          color: filled
                              ? AppColors.mainColor
                              : AppColors.blaceHolderColor,
                          radius: 15,
                          withPadding: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
