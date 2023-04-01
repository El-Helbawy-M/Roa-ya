import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_events.dart';
import 'package:graduation_project/core/app_states.dart';

class SearchBloc extends Bloc<AppEvent, AppState> {
  SearchBloc() : super(Start()) {
    on<GetData>(_searchFor);
  }

  String keyWord = "";

  _searchFor(AppEvent event, Emitter emit) {
    emit(Loading());
    keyWord = event.arguments as String;

    if (keyWord.isNotEmpty) {
      emit(Empty());
    } else {
      emit(Start());
    }
  }
}
