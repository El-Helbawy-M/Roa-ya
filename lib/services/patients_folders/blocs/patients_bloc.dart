import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/services/patients_folders/models/patients_model.dart';
import 'package:graduation_project/services/patients_folders/repo/patients_repo.dart';

import '../../../helpers/app_error_handeler.dart';

class PatientsCubit extends Cubit<AppState> {
  PatientsCubit() : super(Loading());
  late PatientsModel model;
  void getPatients() async {
    emit(Loading());
    try {
      model = await PatientsRepo().getAllPatients();
      if (model.data!.patients!.isEmpty) {
        emit(Empty());
      } else {
        emit(Done());
      }
    } catch (e) {
      ErrorHandler(title: "Data Error", message: model.message ?? "").showDefaultErrorMessage();
      emit(Error());
    }
  }
}
