import 'package:dio/dio.dart';
import '../../gelecoma_detection/core/cloud_server_proxy.dart';
import '../core/cloud_server_proxy.dart';
import '../model/result_model.dart';

abstract class UploaderRepo {
  static Future<ResultModel> upload({required FormData data}) async {
    return await CloudServerProxy().post(url: "", body: data, model: ResultModel()) as ResultModel;
  }

  static Future<ResultModel> uploadGelecoma({required FormData data}) async {
    return await GelecomaCloudServerProxy().post(url: "", body: data, model: ResultModel()) as ResultModel;
  }
}
