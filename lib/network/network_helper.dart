import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/config/api_names.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import '../core/app_core.dart';
import '../core/app_notification.dart';
import 'mapper.dart';
import 'shared_helper.dart';

class NetworkHelper {
  static NetworkHelper? _instance;
  static Dio? _dio;

  NetworkHelper._internal();

  factory NetworkHelper(
      {String? urlCode, String? schema, bool change = false}) {
    if (_instance == null) {
      // NetworkHelper.generateBaseUrl(urlCode: urlCode, schema: schema);
      _instance = NetworkHelper._internal();
      _dio = Dio();
      _dio!.options.baseUrl = baseUrl;
    }
    return _instance!;
  }

  Future<dynamic> get(
      {@required String? url,
      Mapper? model,
      Map<String, dynamic>? query,
      var headers}) async {
    Response? _res;
    if (headers != null) {
      _dio!.options.headers = headers;
    } else {
      String _token = await SharedHelper.sharedHelper!.readString(CachingKey.TOKEN);
      // String lang = await allTranslations.getPreferredLanguage();
      _dio!.options.headers = {
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
        'Accept-Language': "US",//lang == 'en' ? "US" : "AR"
      };
    }
    log('==: End point => ${_dio!.options.baseUrl}$url');
    if (query != null) {
      log(query.toString());
    }
    try {
      _res = await _dio!.get(url!, queryParameters: query);
      log('==: End point =>  ${_dio!.options.baseUrl}$url');
      log('Response >>> ${_res.toString()}');
    } on DioError catch (e) {
      _res = e.response;
      log('Exception >>>  ${e.response.toString()}');
      if (_res == null)
        return Response(
            data: {"status": 0, "message": "NO INTERNET CONNECTION"},
            requestOptions: RequestOptions(path: ''));
    }

    if (model == null) {
      return _res;
    }else {
      return Mapper(model, _res.data);
    }
  }

  Future<dynamic> post(
      {@required String? url,
      var body,
      Mapper? model,
      var headers,
      String? base,
      bool withToken = true}) async {
    Response? _res;
    try {
      if (headers != null) {
        _dio!.options.headers = headers;
      } else {
        if (withToken) {
          String _token =
              await SharedHelper.sharedHelper!.readString(CachingKey.TOKEN);
          // String lang = await allTranslations.getPreferredLanguage();
          log('Token is >>> $_token');
          _dio!.options.headers = {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
            'Accept-Language': "US",//lang == 'en' ? "US" : "AR"
          };
        }
      }
      if(base!=null){
        _dio!.options.baseUrl = base;
      }
      print("hello");
      if (body != null) {
        print("object");
        print('==: Body => ${body}');
        _res = await _dio!.post(url!, data: body);
      } else {
        _res = await _dio!.post(url!);
      }
      _dio!.options.baseUrl = baseUrl;
      print('==: End point => ${_dio!.options.baseUrl}$url');
      print('Response >>> ${_res}');
    } on DioError catch (e) {
      _res = e.response;
      print('==: End point => ${_dio!.options.baseUrl}$url');
      print('Exception >>>  ${e.response.toString()}');
      print('e >>>  ${e.message}');
      if (e.message.contains('Network is unreachable')) {
        return AppCore.showSnackBar(notification: AppNotification(message: 'Network is unreachable',backgroundColor: AppColors.inActive,iconName: "fill-close-circle"));
      }

      if (_res == null)
        return Response(
            data: {"status": 0, "message": "NO INTERNET CONNECTION"},
            requestOptions: RequestOptions(path: ''));
      else if (model == null)
        return _res;
      else
        print(url);
        return Mapper(model, _res.data);
    }

    if (model == null) {
      return _res;
    } else {
      return Mapper(model, _res.data);
    }
    
  }

  Future<dynamic> download(
      {@required String? url,
        var body,
        Mapper? model,
        var headers,
        bool withToken = true}) async {
    Response<ResponseBody>? _res;
    try {
      if (headers != null) {
        _dio!.options.headers = headers;
      } else {
        if (withToken) {
          String _token =
          await SharedHelper.sharedHelper!.readString(CachingKey.TOKEN);
          // String lang = await allTranslations.getPreferredLanguage();
          log('Token is >>> $_token');
          _dio!.options.headers = {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
            'Content-Type' : 'application/pdf',
            'Accept-Language': "US",//lang == 'en' ? "US" : "AR"
          };
        }
      }
      if (body != null) {
        _res = await _dio!.post(url!, data: body ,
          onReceiveProgress : showDownloadProgress , options: Options(
            responseType: ResponseType.stream,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),);
      } else {
        _res = await _dio!.post(url!);
      }

      log('==: Body => $body');
      log('==: End point => ${_dio!.options.baseUrl}$url');
      log('Response >>> ${await _res.data!.stream}');
    } on DioError catch (e) {
      _res = e.response as Response<ResponseBody>;
      log('==: End point => ${_dio!.options.baseUrl}$url');
      log('Exception >>>  ${e.response.toString()}');
      log('e >>>  ${e.message}');
      if (e.message.contains('Network is unreachable')) {
        return AppCore.showSnackBar(notification: AppNotification(message:'Network is unreachable'));
      }
    }
    return _res ;
  }
  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
  Future<dynamic> put(
      {@required String? url,
      var body,
      Mapper? model,
      var headers,
      bool withToken = true}) async {
    Response? _res;
    try {
      if (headers != null) {
        _dio!.options.headers = headers;
        
      } else {
        if (withToken) {
          String _token =
              await SharedHelper.sharedHelper!.readString(CachingKey.TOKEN);
          // String lang = await allTranslations.getPreferredLanguage();
          log('Token is >>> $_token');
          _dio!.options.headers = {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
            'Content-Type' : 'application/pdf',
            'Accept-Language': "US",//lang == 'en' ? "US" : "AR"
          };
        }
      }
    
      if (body != null) {
        _res = await _dio!.put(url!, data: body);
      } else {
        _res = await _dio!.put(url!);
      }

      log('==: Body => $body');
      log('==: End point => ${_dio!.options.baseUrl}$url');
      log('Response >>> ${_res}');
    } on DioError catch (e) {
      _res = e.response;
      log('==: End point => ${_dio!.options.baseUrl}$url');
      log('Exception >>>  ${e.response.toString()}');
      log('e >>>  ${e.message}');
      if (e.message.contains('Network is unreachable')) {
        return AppCore.showSnackBar(notification: AppNotification(message: 'Network is unreachable',backgroundColor: AppColors.inActive,iconName: "fill-close-circle"));
      }

      if (_res == null)
        return Response(
            data: {"status": 0, "message": "NO INTERNET CONNECTION"},
            requestOptions: RequestOptions(path: ''));
      else if (model == null)
        return _res;
      else
        return Mapper(model, _res.data);
    }

    if (model == null) {
      return _res;
    } else {
      return Mapper(model, _res.data);
    }
  }
}

enum BaseUrl { A1, D1 }
