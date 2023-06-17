import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/helpers/app_error_handeler.dart';
import 'package:graduation_project/services/disease_detection/model/custom_model_sheet.dart';
import 'package:graduation_project/services/disease_detection/repo/uploader_repo.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/app_events.dart';
import '../../../router/navigator.dart';
import '../../disease_detection/model/result_model.dart';
import '../../disease_detection/widgets/result_bottom_sheet.dart';

class GelecomaUploaderBloc extends Bloc<AppEvent, AppState> {
  GelecomaUploaderBloc() : super(Start());
  final patientName = BehaviorSubject<CustomModelSheet?>();
  final file = BehaviorSubject<File?>();
  final image = BehaviorSubject<File?>();

  Function(CustomModelSheet?) get updatePatientName => patientName.sink.add;
  Function(File?) get updatefile => file.sink.add;
  Function(File?) get updateImage => image.sink.add;

  Stream<CustomModelSheet?> get patientNameStream => patientName.stream.asBroadcastStream();
  Stream<File?> get fileStream => file.stream.asBroadcastStream();
  Stream<File?> get imageStream => image.stream.asBroadcastStream();

  Stream<bool> get submitStream => Rx.combineLatest3(patientNameStream, imageStream, fileStream, (a, b, c) {
        if (a != null && b != null) {
          return true;
        }
        return false;
      });

  clear() {
    updatePatientName(null);
    updatefile(null);
    updateImage(null);
  }

  @override
  Future<void> close() {
    patientName.close();
    file.close();
    image.close();
    return super.close();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    try {
      if (event is Post) {
        //condations.valueOrNull!
        MultipartFile fileCash = await MultipartFile.fromFile(file.valueOrNull!.path);
        MultipartFile imageFile = await MultipartFile.fromFile(image.valueOrNull!.path);
        FormData data = FormData.fromMap({
          "img": imageFile,
          "xml": fileCash,
        });
        ResultModel model = await UploaderRepo.uploadGelecoma(data: data);
        if (model.results!.isNotEmpty) {
          showModalBottomSheet(
            context: CustomNavigator.navigatorState.currentContext!,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            builder: (context) => ResultBottemSheet(
              patienName: patientName.valueOrNull!.name ?? "",
              diseasesName: model.results ?? "there is no results",
            ),
          ).then((value) => clear());
          yield Done();
        } else {
          ErrorHandler(title: "Unexpected Behavior", message: "The detaction is failed please try again").showDefaultErrorMessage();

          yield Error();
        }
      }
    } catch (e) {
      ErrorHandler(title: "Server Error", message: "The server is not working right now \npleasae try again later").showDefaultErrorMessage();

      yield Error();
    }
  }
}
