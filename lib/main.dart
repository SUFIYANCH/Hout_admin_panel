import 'package:flutter/material.dart';
import 'package:hout_admin_panel/screens/auth_checker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Authchecker(),
    );
  }
}
