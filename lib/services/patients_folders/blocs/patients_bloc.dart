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
      // model = await PatientsRepo().getAllPatients();
      model = PatientsModel(
        data: Patients(
          patients: [
            Patient(
              name: "Mohamed Khaled",
              email: "mohamed.khaled@gmail.com",
              createdAt: "2021-09-01",
              history: "No History",
            ),
            Patient(
              name: "Ahmed Ali",
              email: "ahmed.ali@gmail.com",
              createdAt: "2021-09-02",
              history: "No History",
            )
          ],
        ),
      );
      if (model.data!.patients.isEmpty) {
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
