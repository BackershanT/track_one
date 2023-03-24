import 'package:dio/dio.dart';

class DioClient {

  final String baseUrl = "http://api.openweathermap.org/data/2.5/weather?lat=10.019670730071525&lon=76.3421626530782&APPID=21d6e175e99da7893408f2c0d5f60fdc";



  get(String endUrl, {String? token}) async {
    var dio = Dio();
    String url = baseUrl + endUrl;
    try {
      if (token == null) {
        Response response = await dio.get(url);
        return response.data;
      }
      if (token != null) {
        Response response = await dio.get(url, options: Options(headers: {'Authorization': 'Bearer $token'}));
        return response.data;
      }
    } catch (e) {

    }
  }


}