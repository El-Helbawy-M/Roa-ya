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
      model = await HomeRepo().getAppoinments();
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
