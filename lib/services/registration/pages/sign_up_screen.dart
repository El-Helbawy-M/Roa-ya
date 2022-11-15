import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:graduation_project/services/registration/bloc/register_bloc.dart';

import '../../../componants/custom_text_field.dart';
import '../../../core/app_events.dart';
import '../../../core/app_states.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key,this.isTestMode = false,this.onTest}) : super(key: key);
  final bool isTestMode;
  final Function()? onTest;
  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = false, showConfirmPassword = false;
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
                const CustomAppBar(withPadding: true),
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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: ListAnimator(
                    data: [
                      SizedBox(height: 24),
                      StreamBuilder<String?>(
                          stream: RegisterBloc.instance.nameStream,
                          builder: (context, snapshot) {
                            return CustomTextField(
                                hint: "Your Name",
                                fieldKey: ValueKey("name"),
                                onChange: RegisterBloc.instance.updateName,
                                type: TextInputType.text,
                                onValidate: (v) {
                                  if (NameValidator.nameValidator(v as String) != null) {
                                    RegisterBloc.instance.name.addError(
                                      NameValidator.nameValidator(v)!,
                                    );
                                  }
                                },
                                hasError: snapshot.hasError,
                                errorText: (snapshot.error ?? "") as String);
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: StreamBuilder<String?>(
                          stream: RegisterBloc.instance.emailStream,
                          builder: (context, snapshot) {
                            return CustomTextField(
                              hint: getLang("email"),
                              fieldKey: ValueKey("email"),
                              onChange: RegisterBloc.instance.updateEmail,
                              type: TextInputType.emailAddress,
                              onValidate: (v) {
                                if (EmailValidator.emailValidator(v as String) != null) {
                                  RegisterBloc.instance.email.addError(
                                    EmailValidator.emailValidator(v)!,
                                  );
                                }
                              },
                              hasError: snapshot.hasError,
                              errorText: (snapshot.error ?? "") as String,
                            );
                          },
                        ),
                      ),
                      StreamBuilder<String?>(
                          stream: RegisterBloc.instance.passwordStream,
                          builder: (context, snapshot) {
                            return CustomTextField(
                              hint: getLang("password"),
                              fieldKey: ValueKey("password"),
                              onChange: RegisterBloc.instance.updatePassword,
                              type: TextInputType.visiblePassword,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: InkWell(
                                  onTap: () => setState(() => showPassword = !showPassword),
                                  child: customImageIconSVG(
                                    color: showPassword ? AppColors.mainColor : null,
                                    imageName: showPassword ? 'show' : 'hide',
                                  ),
                                ),
                              ),
                              hide: showPassword,
                              onValidate: (v) {
                                if (PasswordValidator.passwordValidator(v as String) != null) {
                                  RegisterBloc.instance.password.addError(
                                    PasswordValidator.passwordValidator(v)!,
                                  );
                                }
                              },
                              hasError: snapshot.hasError,
                              errorText: (snapshot.error ?? "") as String,
                            );
                          }),
                      const SizedBox(height: 18),
                      StreamBuilder<String?>(
                          stream: RegisterBloc.instance.confirmPasswordStream,
                          builder: (context, snapshot) {
                            return CustomTextField(
                              hint: getLang("confirm_password"),
                              
                              fieldKey: ValueKey("confirm_password"),
                              onChange: RegisterBloc.instance.updateConfirmPassword,
                              type: TextInputType.visiblePassword,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: InkWell(
                                  onTap: () => setState(() => showConfirmPassword = !showConfirmPassword),
                                  child: customImageIconSVG(
                                    color: showConfirmPassword ? AppColors.mainColor : null,
                                    imageName: showConfirmPassword ? 'show' : 'hide',
                                  ),
                                ),
                              ),
                              hide: showConfirmPassword,
                              onValidate: (v) {
                                if (PasswordConfirmationValidator.passwordValidator(v, RegisterBloc.instance.password.valueOrNull) != null) {
                                  RegisterBloc.instance.confirmPassword.addError(
                                    PasswordConfirmationValidator.passwordValidator(v, RegisterBloc.instance.password.valueOrNull)!,
                                  );
                                }
                              },
                              hasError: snapshot.hasError,
                              errorText: (snapshot.error??"") as String,
                            );
                          }),
                      const SizedBox(height: 30),
                      BlocBuilder<RegisterBloc, AppState>(builder: (context, state) {
                        return StreamBuilder<bool?>(
                            stream: RegisterBloc.instance.submitStream,
                            builder: (context, snapshot) {
                              return CustomBtn(
                                text: getLang("sign_up"),
                                key: ValueKey("sign_up_btn"),
                                onTap: () {
                                  log("${_formKey.currentState!.validate()}  ${snapshot.data}");
                                  if (snapshot.hasData) {
                                    if (snapshot.data!) {
                                      if(!widget.isTestMode) {RegisterBloc.instance.add(Post());}
                                      else {widget.onTest!=null?widget.onTest!():(){};}
                                    }
                                  }
                                },
                                btnHeight: 55,
                                txtColor: Colors.white,
                                color: AppColors.mainColor,
                                radius: 15,
                                loading: state is Loading,
                              );
                            });
                      }),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Text(
                            getLang("Have an account? "),
                            style: AppTextStyles.w300.copyWith(fontSize: 12, color: AppColors.mainColor),
                          ),
                          InkWell(
                            onTap: () => CustomNavigator.pop(),
                            child: Text(
                              " " + getLang("Log_in"),
                              style: AppTextStyles.w700.copyWith(fontSize: 14, color: AppColors.mainColor),
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
