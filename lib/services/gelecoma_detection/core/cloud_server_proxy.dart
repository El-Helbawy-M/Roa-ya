import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../network/mapper.dart';

class GelecomaCloudServerProxy {
  final String _cloudUrl = "http://habibaahmed12.pythonanywhere.com/";
  final Dio _dio = Dio();
  Future<dynamic> post({@required String? url, var body, Mapper? model, var headers}) async {
    Response? _res;

    try {
      _dio.options.baseUrl = _cloudUrl;
      if (body != null) {
        FormData data = body;

        log('==: Body => ${data.files}');
        _res = await _dio.post(url ?? "", data: body);
      }
      log('==: End point => ${_dio.options.baseUrl}$url');
      log('Response >>> ${_res}');

      // if (base != null)
    } on DioError catch (e) {
      _res = e.response;
      log('==: End point => ${_dio.options.baseUrl}$url');
      log('Exception >>>  ${e.error.toString()}');
      if (_res == null)
        return Response(data: {"status": 0, "message": "NO INTERNET CONNECTION"}, requestOptions: RequestOptions(path: ''));
      else if (model == null)
        return _res;
      else
        print(url);
      return Mapper(model, _res.data);
    }
    if (model == null) {
      return _res;
    } else {
      return Mapper(model, _res!.data);
    }
  }
}
