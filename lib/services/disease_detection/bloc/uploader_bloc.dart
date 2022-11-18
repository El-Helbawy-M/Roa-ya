import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/services/disease_detection/model/custom_model_sheet.dart';
import 'package:graduation_project/services/disease_detection/repo/uploader_repo.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/app_core.dart';
import '../../../core/app_events.dart';
import '../../../core/app_notification.dart';
import '../../../core/validator.dart';
import '../../../helpers/app_colors.dart';
import '../../../router/navigator.dart';
import '../model/result_model.dart';
import '../widgets/result_bottom_sheet.dart';

class UploaderBloc extends Bloc<AppEvent, AppState> {
  UploaderBloc() : super(Start());
  static UploaderBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);
  final patientName = BehaviorSubject<CustomModelSheet?>();
  final notes = BehaviorSubject<String?>();
  final image = BehaviorSubject<File?>();

  Function(CustomModelSheet?) get updatePatientName => patientName.sink.add;
  Function(String?) get updateNotes => notes.sink.add;
  Function(File?) get updateImage => image.sink.add;

  Stream<CustomModelSheet?> get patientNameStream =>
      patientName.stream.asBroadcastStream();
  Stream<String?> get notesStream => notes.stream.asBroadcastStream();
  Stream<File?> get imageStream => image.stream.asBroadcastStream();

  Stream<bool> get submitStream =>
      Rx.combineLatest2(patientNameStream, imageStream, (a, b) {
        if (a != null && b != null) {
          return true;
        }
        return false;
      });

  clear() {
    updatePatientName(null);
    updateNotes(null);
    updateImage(null);
  }

  @override
  Future<void> close() {
    patientName.close();
    notes.close();
    image.close();
    return super.close();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    try {
      if (event is Post) {
        //condations.valueOrNull!
        FormData data = FormData.fromMap({
          "attachment": MultipartFile.fromFile(image.valueOrNull!.path),
        });
        updateImage(image.valueOrNull);
        ResultModel model = await UploaderRepo.upload(data: data);
        if (model.results!.isNotEmpty) {
          clear();
          showModalBottomSheet(
            context: CustomNavigator.navigatorState.currentContext!,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            builder: (context) => ResultBottemSheet(
              patienName:
                  UploaderBloc.instance.patientName.valueOrNull!.name ?? "",
                  diseasesName: model.results??"there is no results",
            ),
          );
          yield Done();
        } else {
          AppCore.showSnackBar(
            notification: AppNotification(
              message: "failed please try again",
              backgroundColor: AppColors.inActive,
              iconName: "fill-close-circle",
            ),
          );

          yield Error();
        }
      }
    } catch (e) {
      AppCore.showSnackBar(
          notification: AppNotification(
              message: "The server is not working right now \npleasae try again later",
              backgroundColor: AppColors.inActive,
              iconName: "fill-close-circle"));
      yield Error();
    }
  }
}
