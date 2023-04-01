import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/helpers/shared_helper.dart';

class RecentKeywordCubit extends Cubit<AppState> {
  RecentKeywordCubit() : super(Loading());

  List<String> words = [];
  init() async {
    words = await SharedHelper.sharedHelper!.readListOfString(CachingKey.RECENT_KEYWORDS);
    if (words.isNotEmpty) {
      emit(Done(list: words));
    } else {
      emit(Empty());
    }
  }

  update(String keyWord) async {
    if (keyWord.isNotEmpty) {
      if (words.length == 5) {
        words.removeLast();
        words.insert(0, keyWord);
      } else {
        words.insert(0, keyWord);
      }
    }
    emit(Done(list: words));
    SharedHelper.sharedHelper!.writeData(CachingKey.RECENT_KEYWORDS, words);
  }

  remove(String keyWord) async {
    words.remove(keyWord);
    if (words.isNotEmpty) {
      emit(Done(list: words));
    } else {
      emit(Empty());
    }
    SharedHelper.sharedHelper!.writeData(CachingKey.RECENT_KEYWORDS, words);
  }
}
