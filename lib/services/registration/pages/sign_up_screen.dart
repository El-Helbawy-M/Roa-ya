import 'package:flutter/material.dart';
import 'package:graduation_project/componants/animated_widgets.dart';
import 'package:graduation_project/componants/custom_app_bar.dart';
import 'package:graduation_project/componants/custom_arrow_back.dart';
import 'package:graduation_project/componants/custom_button.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/core/localization.dart';
import 'package:graduation_project/core/validator.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/router/navigator.dart';
import 'package:graduation_project/router/routes.dart';

import '../../../componants/custom_text_field.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
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
                SizedBox(height: 24),
                CustomAppBar(withPadding: true,),
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
                      SizedBox(height: 24),
                      CustomTextField(
                        hint: getLang("first_name"),
                        onChange: (value) {},
                        onValidate: (value) =>
                            NameValidator.nameValidator(value),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: CustomTextField(
                            hint: getLang("last_name"),
                            onChange: (value) {},
                            onValidate: (value) =>
                                NameValidator.nameValidator(value)),
                      ),
                      CustomTextField(
                          hint: getLang("phone"),
                          onChange: (value) {},
                          onValidate: (value) =>
                              PhoneValidator.phoneValidator(value)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: CustomTextField(
                            hint: getLang("email"),
                            onChange: (value) {},
                            onValidate: (value) =>
                                EmailValidator.emailValidator(value)),
                      ),
                      CustomTextField(
                          hint: getLang("password"),
                          onChange: (value) =>
                              setState(() => password = value),
                          onValidate: (value) =>
                              PasswordValidator.passwordValidator(value)),
                      const SizedBox(height: 18),
                      CustomTextField(
                          hint: getLang("confirm_password"),
                          onChange: (value) {},
                          onValidate: (value) =>
                              PasswordConfirmationValidator.passwordValidator(
                                  password, value)),
                      const SizedBox(height: 30),
                      CustomBtn(
                        text: getLang("sign_up"),
                        onTap: () {
                          if (_formKey.currentState!.validate())
                            CustomNavigator.push(Routes.verfication,
                                arguments: true);
                        },
                        btnHeight: 55,
                        txtColor: Colors.white,
                        color: AppColors.mainColor,
                        radius: 15,
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Text(
                            getLang("Have an account? "),
                            style: AppTextStyles.w300.copyWith(
                                fontSize: 12, color: AppColors.mainColor),
                          ),
                          InkWell(
                            onTap: () => CustomNavigator.pop(),
                            child: Text(
                              " "+getLang("Log_in"),
                              style: AppTextStyles.w700.copyWith(
                                  fontSize: 14, color: AppColors.mainColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
