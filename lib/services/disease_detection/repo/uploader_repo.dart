import 'package:dio/dio.dart';
import '../core/cloud_server_proxy.dart';
import '../model/result_model.dart';

abstract class UploaderRepo {
  static Future<ResultModel> upload({required FormData data}) async {
    return await CloudServerProxy().post(url: "", body: data, model: ResultModel()) as ResultModel;
  }
}
