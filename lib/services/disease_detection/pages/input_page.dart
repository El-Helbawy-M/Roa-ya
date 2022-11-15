import 'package:flutter/material.dart';
import 'package:graduation_project/componants/animated_widgets.dart';
import 'package:graduation_project/componants/custom_app_bar.dart';
import 'package:graduation_project/componants/custom_button.dart';
import 'package:graduation_project/componants/upload_image.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';

import '../../../componants/custom_text_field.dart';
import '../../../core/validator.dart';
import '../../registration/bloc/signIn_bloc.dart';

class InputPage extends StatelessWidget {
  const InputPage({Key? key}) : super(key: key);

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
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: CustomAppBar(),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  "Diseas Detection",
                  style: AppTextStyles.w700.copyWith(fontSize: 32, color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: ListAnimator(data: [
                    const SizedBox(height: 24),
                    StreamBuilder<String?>(
                      stream: null,
                      builder: (context, snapshot) {
                        return CustomTextField(
                          hint: "Patient Name",
                          onChange: SignInBloc.instance.updateEmail,
                          type: TextInputType.emailAddress,
                          onValidate: (v) {
                            if (EmailValidator.emailValidator(v as String) != null) {
                              SignInBloc.instance.email.addError(
                                EmailValidator.emailValidator(v)!,
                              );
                            }
                          },
                          hasError: snapshot.hasError,
                          errorText: (snapshot.error ?? "") as String,
                        );
                      },
                    ),
                    StreamBuilder<String?>(
                      stream: null,
                      builder: (context, snapshot) {
                        return CustomTextField(
                          hint: "Notes",
                          onChange: SignInBloc.instance.updateEmail,
                          type: TextInputType.emailAddress,
                          onValidate: (v) {
                            if (EmailValidator.emailValidator(v as String) != null) {
                              SignInBloc.instance.email.addError(
                                EmailValidator.emailValidator(v)!,
                              );
                            }
                          },
                          hasError: snapshot.hasError,
                          errorText: (snapshot.error ?? "") as String,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: UploadImage(
                        label: "Upload Image",
                        updatedImage: (v) {},
                      ),
                    ),
                    const SizedBox(height: 36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HorizontalAnaliticPoint(color: AppColors.mainColor, value: "Internal - 33.3%"),
                        HorizontalAnaliticPoint(color: AppColors.inActive, value: "External - 53.3%"),
                        HorizontalAnaliticPoint(color: AppColors.active, value: "Active - 13.3%"),
                      ],
                    ),
                    const SizedBox(height: 36),
                    CustomBtn(txtFontSize: 18,btnHeight: 60,text: "Upload", onTap: (){})
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalAnaliticPoint extends StatelessWidget {
  const HorizontalAnaliticPoint({
    Key? key,
    required this.color,
    required this.value,
  }) : super(key: key);
  final Color color;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
        const SizedBox(width: 8),
        Text(
          value,
          style: AppTextStyles.w500.copyWith(fontSize: 12),
        )
      ],
    );
  }
}
