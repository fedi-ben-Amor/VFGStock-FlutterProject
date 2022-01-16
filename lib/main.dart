import 'package:flutter/material.dart';
import 'package:frontend/auth/register.dart';
import 'package:frontend/home/home.dart';
import 'auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHome(),
        '/home': (context) => const MyHome(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
      },
    );
  }
}
