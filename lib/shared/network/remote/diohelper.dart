import 'package:dio/dio.dart';

// https://newsapi.org/v2/top-headlines?country=us&apiKey=13ec49a4755a41c0b993584adc654987
//base url:https://newsapi.org/
//method (url):v2/top-headlines?
//queries: country=us&apiKey=13ec49a4755a41c0b993584adc654987
class DioHelper {

  static late Dio dio;
  static init()
  {
    //https://student.valuxapps.com/api/
    //https://student.valuxapps.com/api/
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,

        )
    );
  }
  static Future <Response> getData ({
    required String url,
    Map<String,dynamic>? query,
    String lang = 'en',
    String? token
  }
      ) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization': token==null?'':token,
    };
    return await dio.get(url,queryParameters: query??null,);
  }

  static Future <Response> deleteData ({
    required String url,
    Map<String,dynamic> ? query,
    String lang = 'en',
    String? token
  }
      ) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization': token==null?'':token,
    };
    return dio.delete(
    url,
    queryParameters: query,
    );
  }

  static Future <Response> postData ({
    required String url,
    Map<String,dynamic> ? query,
    required Map<String,dynamic> data,
    String lang = 'en',
    String? token
  }
      ) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization': token==null?'':token,
    };
    return dio.post(
        url,
        queryParameters: query,
        data: data
    );
  }

  static Future <Response> putData ({
    required String url,
    Map<String,dynamic> ? query,
    required Map<String,dynamic> data,
    String lang = 'en',
    String? token
  }
      ) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization': token==null?'':token,
    };
    return dio.put(
        url,
        queryParameters: query,
        data: data
    );
  }
  }
