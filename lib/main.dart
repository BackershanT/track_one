import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:track_one/firebase_options.dart';
import 'package:track_one/src/app.dart';
import 'package:track_one/src/services/service_locator.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupServiceLocator();

  runApp(const MyApp());
}



