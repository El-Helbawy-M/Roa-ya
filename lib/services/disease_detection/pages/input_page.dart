import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/componants/animated_widgets.dart';
import 'package:graduation_project/componants/custom_app_bar.dart';
import 'package:graduation_project/componants/custom_button.dart';
import 'package:graduation_project/componants/upload_image.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/app_text_styles.dart';
import 'package:graduation_project/services/disease_detection/bloc/uploader_bloc.dart';

import '../../../componants/custom_text_field.dart';
import '../../../core/app_events.dart';
import '../../../core/validator.dart';
import '../../registration/bloc/signIn_bloc.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  child: Form(
                    key: _formKey,
                    child: ListAnimator(data: [
                      const SizedBox(height: 24),
                      StreamBuilder<String?>(
                        stream: UploaderBloc.instance.patientNameStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            hint: "Patient Name",
                            onChange: UploaderBloc.instance.updatePatientName,
                            type: TextInputType.emailAddress,
                            onValidate: (v) {
                              if (NameValidator.nameValidator(v as String) != null) {
                                UploaderBloc.instance.patientName.addError(
                                  NameValidator.nameValidator(v)!,
                                );
                              }
                            },
                            hasError: snapshot.hasError,
                            errorText: (snapshot.error ?? "") as String,
                          );
                        },
                      ),
                      StreamBuilder<String?>(
                        stream: UploaderBloc.instance.notesStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            hint: "Notes",
                            onChange: UploaderBloc.instance.updateNotes,
                            type: TextInputType.emailAddress,
                            onValidate: (v) {
                              if (NoteValidator.nameValidator(v as String) != null) {
                                UploaderBloc.instance.notes.addError(
                                  NoteValidator.nameValidator(v)!,
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
                        child: StreamBuilder<MultipartFile?>(
                            stream: UploaderBloc.instance.imageStream,
                            builder: (context, snapshot) {
                              return UploadImage(
                                label: "Upload Image",
                                updatedImage: UploaderBloc.instance.updateImage,
                                isFilled: UploaderBloc.instance.image.valueOrNull != null,
                              );
                            }),
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
                      BlocBuilder<UploaderBloc, AppState>(builder: (context, state) {
                        return StreamBuilder<bool?>(
                            stream: UploaderBloc.instance.submitStream,
                            builder: (context, snapshot) {
                              return CustomBtn(
                                btnHeight: 55,
                                txtColor: Colors.white,
                                color: AppColors.mainColor,
                                radius: 15,
                                withPadding: false,
                                loading: state is Loading,
                                text: "Upload",
                                onTap: () {
                                  log("${_formKey.currentState!.validate()}  ${snapshot.data}");
                                  if (snapshot.hasData) {
                                    if (snapshot.data!) {
                                        UploaderBloc.instance.add(Post());
                                    }
                                  }
                                },
                              );
                            });
                      })
                    ]),
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
