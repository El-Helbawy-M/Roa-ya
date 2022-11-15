import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/services/disease_detection/repo/uploader_repo.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/app_core.dart';
import '../../../core/app_events.dart';
import '../../../core/app_notification.dart';
import '../../../core/validator.dart';
import '../../../helpers/app_colors.dart';
import '../../../router/navigator.dart';
import '../model/result_model.dart';

class UploaderBloc extends Bloc<AppEvent, AppState> {
  UploaderBloc() : super(Start());
  static UploaderBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);
  final patientName = BehaviorSubject<String?>();
  final notes = BehaviorSubject<String?>();
  final image = BehaviorSubject<MultipartFile?>();

  Function(String?) get updatePatientName => patientName.sink.add;
  Function(String?) get updateNotes => notes.sink.add;
  Function(MultipartFile?) get updateImage => image.sink.add;

  Stream<String?> get patientNameStream => patientName.stream.asBroadcastStream();
  Stream<String?> get notesStream => notes.stream.asBroadcastStream();
  Stream<MultipartFile?> get imageStream => image.stream.asBroadcastStream();

  Stream<bool> get submitStream => Rx.combineLatest3(patientName, notesStream, imageStream, (a, b, c) {
        if (NameValidator.nameValidator(a as String) == null && NoteValidator.nameValidator(b as String) == null && c == null) {
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
          "attachment": image.valueOrNull,
        });
        ResultModel model = await UploaderRepo.upload(data: data);
        if (model.results!.isNotEmpty) {
          AppCore.showSnackBar(notification: AppNotification(message: model.results!.first.value ?? "", backgroundColor: AppColors.active, iconName: "check-circle"));
          yield Done();
        } else {
          AppCore.showSnackBar(
            notification: AppNotification(message: "field", backgroundColor: AppColors.inActive, iconName: "fill-close-circle"),
          );

          yield Error();
        }
      }
    } catch (e) {
      AppCore.showSnackBar(notification: AppNotification(message: e.toString(), backgroundColor: AppColors.inActive, iconName: "fill-close-circle"));
      yield Error();
    }
  }
}
