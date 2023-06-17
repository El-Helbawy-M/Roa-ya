import 'dart:developer';
import 'dart:io';
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
import 'package:graduation_project/services/disease_detection/model/custom_model_sheet.dart';
import 'package:graduation_project/services/disease_detection/widgets/form_drop_down_menu.dart';
import 'package:graduation_project/services/patients_folders/models/patients_model.dart';
import '../../../componants/custom_text_field.dart';
import '../../../core/app_events.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key, required this.patients}) : super(key: key);
  final List<Patient> patients;
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<UploaderBloc>(context);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Form(
        key: _formKey,
        child: SafeArea(
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
                      // StreamBuilder<String?>(
                      //   stream: bloc.patientNameStream,
                      //   builder: (context, snapshot) {
                      //     return CustomTextField(
                      //       hint: "Patient Name",
                      //       onChange: bloc.updatePatientName,
                      //       type: TextInputType.emailAddress,
                      //       onValidate: (v) {
                      //         if (NameValidator.nameValidator(v as String) != null) {
                      //           bloc.patientName.addError(
                      //             NameValidator.nameValidator(v)!,
                      //           );
                      //         }
                      //       },
                      //       hasError: snapshot.hasError,
                      //       errorText: (snapshot.error ?? "") as String,
                      //     );
                      //   },
                      // ),
                      StreamBuilder<CustomModelSheet?>(
                        stream: bloc.patientNameStream,
                        builder: (context, snapshot) {
                          return FormSelector(
                            label: "Patient Name",
                            value: bloc.patientName.valueOrNull,
                            onTap: bloc.updatePatientName,
                            data: List.generate(
                              widget.patients.length,
                              (index) => CustomModelSheet(
                                name: widget.patients[index].name,
                                value: widget.patients[index].name,
                              ),
                            ),
                            hasError: snapshot.hasError,
                            errorText: (snapshot.error ?? "") as String,
                          );
                        },
                      ),
                      SizedBox(height: 8),
                      StreamBuilder<String?>(
                        stream: bloc.notesStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            hint: "Notes",
                            onChange: bloc.updateNotes,
                            type: TextInputType.text,
                            onValidate: (v) {
                              if (bloc.patientName.valueOrNull == null) {
                                bloc.patientName.addError(
                                  "Please select the patient name",
                                );
                              }
                              if (bloc.image.valueOrNull == null) {
                                bloc.image.addError(
                                  "Please pick the image",
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
                        child: StreamBuilder<File?>(
                            stream: bloc.imageStream,
                            builder: (context, snapshot) {
                              return UploadImage(
                                label: "Upload Image",
                                updatedImage: bloc.updateImage,
                                selectedImage: bloc.image.valueOrNull,
                                isFilled: bloc.image.valueOrNull != null,
                                hasError: snapshot.hasError,
                                errorText: (snapshot.error ?? "") as String,
                              );
                            }),
                      ),
                      const SizedBox(height: 24),

                      BlocBuilder<UploaderBloc, AppState>(builder: (context, state) {
                        return StreamBuilder<bool?>(
                            stream: bloc.submitStream,
                            builder: (context, snapshot) {
                              return CustomBtn(
                                text: "Upload",
                                withPadding: false,
                                onTap: () {
                                  log("${_formKey.currentState!.validate()}  ${snapshot.data}");
                                  if (snapshot.hasData) {
                                    if (snapshot.data!) {
                                      bloc.add(Post());
                                    }
                                  }
                                },
                                btnHeight: 55,
                                txtColor: Colors.white,
                                color: AppColors.mainColor,
                                radius: 10,
                                loading: state is Loading,
                              );
                            });
                      }),
                    ]),
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
