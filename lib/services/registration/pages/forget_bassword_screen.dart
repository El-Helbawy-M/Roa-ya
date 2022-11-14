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

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool filled = false;

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
                CustomAppBar(
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
                              getLang("No Proplem"),
                              style: AppTextStyles.w700
                                  .copyWith(fontSize: 32, color: AppColors.mainColor),
                            ),
                            
                        SizedBox(height: 4),
                            Text(
                          getLang("Enter your email"),
                          style: AppTextStyles.w400
                              .copyWith(fontSize: 18, color: AppColors.mainColor),
                        ),
                          ],
                        ),
                        
                        const SizedBox(height: 60),
                        CustomTextField(
                            hint: getLang("email"),
                            onChange: (value) {setState((){if(value.isNotEmpty) {filled = true;} else {filled = false;}});},
                            onValidate: (value) =>
                                EmailValidator.emailValidator(value)),
                        const SizedBox(height: 20),
                        CustomBtn(
                          text: getLang("submit").toUpperCase(),
                          onTap: () {
                            if(filled){if (_formKey.currentState!.validate())
                              {CustomNavigator.push(Routes.verfication,
                                  replace: true, arguments: false);}}
                          },
                          btnHeight: 44,
                          txtColor:filled?Colors.white: AppColors.lightGrey,
                          color: filled?AppColors.mainColor:AppColors.blaceHolderColor,
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
