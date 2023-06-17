import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/services/home/models/latest_appoinemts_mode.dart';

import '../repo/home_repo.dart';

class LatestAppoinmentsCubit extends Cubit<AppState> {
  LatestAppoinmentsCubit() : super(Loading());
  late LatestAppoimentsModel model;
  void getAppoinments() async {
    emit(Loading());
    try {
      // model = await HomeRepo().getAppoinments();
      model = LatestAppoimentsModel(
        data: CommingAppoimentsData(comingAppointments: [
          Appoiment(
            id: 1,
            patient: "Mohamed Khaled",
            time: "10:00 AM",
          ),
          Appoiment(
            id: 2,
            patient: "Ahmed Ali",
            time: "12:00 PM",
          ),
        ]),
      );
      if (model.data!.comingAppointments.isEmpty) {
        emit(Empty());
      } else {
        emit(Done());
      }
    } catch (e) {
      emit(Error());
    }
  }
}
