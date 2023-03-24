import 'package:get_it/get_it.dart';
import 'package:track_one/src/auth/auth_manager.dart';
import 'package:track_one/src/services/dioservices.dart';


final getIt = GetIt.instance;

Future <void> setupServiceLocator() async {
  getIt.registerSingleton<DioClient>(DioClient());
  getIt.registerSingleton<AuthManager>(AuthManager());

}