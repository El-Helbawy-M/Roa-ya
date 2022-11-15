
import 'package:dio/dio.dart';
import 'package:graduation_project/network/network_helper.dart';

import '../model/result_model.dart';

abstract class UploaderRepo {
  static Future<ResultModel> upload({required FormData data})async{
    return NetworkHelper().post(url: "",body: data,model: ResultModel()) as ResultModel;
  }
}