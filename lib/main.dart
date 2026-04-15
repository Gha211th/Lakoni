import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/screen/splash_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  if (Platform.isWindows ||
      Platform.isLinux ||
      Platform.isLinux ||
      Platform.isAndroid ||
      Platform.isIOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Lakoni Basic CRUD',
      home: const SplashScreen(),
    );
  }
}
