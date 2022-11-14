import 'package:flutter/material.dart';
import 'package:graduation_project/componants/animated_widgets.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/router/routes.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import '../../../componants/custom_app_bar.dart';
import '../../../componants/custom_arrow_back.dart';
import '../../../componants/custom_button.dart';
import '../../../componants/custom_icon.dart';
import '../../../core/localization.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_media_query.dart';
import '../../../router/navigator.dart';

class VerficationScreen extends StatefulWidget {
  const VerficationScreen({Key? key, required this.fromSignUp})
      : super(key: key);
  final bool fromSignUp;
  @override
  State<VerficationScreen> createState() => _VerficationScreenState();
}

class _VerficationScreenState extends State<VerficationScreen> {
  bool resend = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: SizedBox(
          width: MediaHelper.width,
          height: MediaHelper.height,
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
                            getLang("Verfication"),
                            style: AppTextStyles.w700.copyWith(
                                fontSize: 26, color: AppColors.mainColor),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            getLang("Enter the verfication code"),
                            style: AppTextStyles.w400.copyWith(
                                fontSize: 16, color: AppColors.mainColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Align(
                          alignment: Alignment.center,
                          child: PinCodeTextField(
                              // controller: controller,

                              pinBoxHeight: 65,
                              pinBoxWidth: 65,
                              pinBoxRadius: 15,
                              pinBoxColor: AppColors.mainColor.withOpacity(.1),
                              pinBoxBorderWidth: 1,
                              pinBoxOuterPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              defaultBorderColor: AppColors.mainColor,
                              hasTextBorderColor: AppColors.mainColor,
                              keyboardType: TextInputType.number,
                              onTextChanged: (value) {},
                              //     VerificationBloc.instance.updateCode,
                              pinTextStyle:
                                  AppTextStyles.w400.copyWith(fontSize: 24),
                              autofocus: true,
                              onDone: (v) {
                                widget.fromSignUp
                                    ? CustomNavigator.push(Routes.main,
                                        clean: true)
                                    : CustomNavigator.push(Routes.resetPassword,
                                        replace: true);
                              }),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomBtn(
                        text: getLang("resend_code"),
                        onTap: () {},
                        btnHeight: 44,
                        btnWidth: 180,
                        txtColor: !resend ? Colors.white : AppColors.lightGrey,
                        color: !resend
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
    );
  }
}
