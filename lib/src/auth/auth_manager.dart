import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_one/src/model/track_one.dart';
import 'package:track_one/src/services/dioservices.dart';
import 'package:track_one/src/services/service_locator.dart';

class AuthManager {
  int? degree;
  int? type;
  String? description;

  getTemperature() async {
    String url =
        "http://api.openweathermap.org/data/2.5/weather?lat=10.019670730071525&lon=76.3421626530782&APPID=21d6e175e99da7893408f2c0d5f60fdc";
    Map<String, dynamic> response = await getIt<DioClient>().gt(url);
    // print("response");
    // print(response);
    if (response != null) {
      Model model = Model.fromJson(response);
      if (model.wind!.deg != null) {
        degree = model.wind!.deg;
        type = model.sys!.type;
        description = model.weather![0].description;
        await getIt<SharedPreferences>().setInt('degree', degree!);
        await getIt<SharedPreferences>().setInt('type', type!);
        await getIt<SharedPreferences>().setString("description", description!);

        // print("******$degree");
        // print("******$type");
        // print("******$description");
      }
    }
  }
}
