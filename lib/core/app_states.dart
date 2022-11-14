import 'package:flutter/cupertino.dart';
import '../network/mapper.dart';

abstract class AppState {}

class Start extends AppState {}

class Done extends AppState {
  Mapper? model;
  List<Widget>? cards;
  List<dynamic>? list;
  bool? reload;
  bool? loading;

  Done({this.model, this.cards, this.list, this.reload = true , this.loading = false});
}




class Error extends AppState {}

class Loading extends AppState {}

class Empty extends AppState {
  final bool? initial;

  Empty({this.initial});
}
