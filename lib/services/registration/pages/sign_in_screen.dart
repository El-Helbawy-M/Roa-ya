import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/componants/animated_widgets.dart';
import 'package:graduation_project/componants/custom_button.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/core/app_events.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/core/localization.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/services/registration/bloc/signIn_bloc.dart';

import '../../../componants/custom_text_field.dart';
import '../../../core/validator.dart';
import '../../../router/navigator.dart';
import '../../../router/routes.dart';
import '../widgets/facebook_google_registration.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key, this.isTestMode = false, this.onTest}) : super(key: key);
  final bool isTestMode;
  final Function()? onTest;
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: SizedBox(
          width: MediaHelper.width,
          height: MediaHelper.height,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
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
                        const SizedBox(height: 24),
                        StreamBuilder<String?>(
                            stream: SignInBloc.instance.emailStream,
                            builder: (context, snapshot) {
                              return CustomTextField(
                                fieldKey: const Key("emailField"),
                                hint: getLang("email"),
                                onChange: SignInBloc.instance.updateEmail,
                                type: TextInputType.emailAddress,
                                onValidate: (v) {
                                  if (EmailValidator.emailValidator(v as String) != null) {
                                    SignInBloc.instance.email.addError(EmailValidator.emailValidator(v)!);
                                  }
                                },
                                hasError: snapshot.hasError,
                                errorText: (snapshot.error ?? "") as String,
                              );
                            }),
                        const SizedBox(height: 18),
                        StreamBuilder<String?>(
                            stream: SignInBloc.instance.passwordStream,
                            builder: (context, snapshot) {
                              return CustomTextField(
                                fieldKey: Key("password_field"),
                                hint: getLang("password"),
                                onChange: SignInBloc.instance.updatePassword,
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
                                  if (PasswordValidator.passwordValidator(v) != null) {
                                    SignInBloc.instance.password.addError(PasswordValidator.passwordValidator(v)!);
                                  }
                                },
                                hasError: snapshot.hasError,
                                errorText: (snapshot.error ?? "") as String,
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: () => CustomNavigator.push(Routes.forgetPassword),
                            child: Text(
                              getLang("Forget Password? "),
                              style: AppTextStyles.w500.copyWith(fontSize: 10, color: AppColors.mainColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<SignInBloc, AppState>(
                          builder: (context, state) {
                            return StreamBuilder<bool?>(
                              stream: SignInBloc.instance.submitStream,
                              builder: (context, snapshot) {
                                return CustomBtn(
                                  text: getLang("Log_in"),
                                  onTap: () {
                                    log("${_formKey.currentState!.validate()}  ${snapshot.data}");
                                    if (snapshot.hasData) {
                                      if (snapshot.data!) {
                                        if (!widget.isTestMode) {
                                          SignInBloc.instance.add(Post());
                                        } else {
                                          widget.onTest != null ? widget.onTest!() : () {};
                                        }
                                      }
                                    }
                                  },
                                  btnHeight: 55,
                                  txtColor: Colors.white,
                                  color: AppColors.mainColor,
                                  radius: 15,
                                  withPadding: false,
                                  loading: state is Loading,
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Text(
                              getLang("Don't have an account? "),
                              style: AppTextStyles.w300.copyWith(fontSize: 12, color: AppColors.mainColor),
                            ),
                            InkWell(
                              onTap: () => CustomNavigator.push(Routes.register),
                              child: Text(
                                " " + getLang("Create an account"),
                                style: AppTextStyles.w700.copyWith(fontSize: 14, color: AppColors.mainColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24)
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
