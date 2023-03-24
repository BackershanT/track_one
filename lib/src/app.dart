import 'package:flutter/material.dart';
import 'package:track_one/src/auth/auth_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track One',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home:const AuthPage(),
    );
  }
}