import 'package:flutter/material.dart';
import "./pages/login_page.dart";
import './pages/menu_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => LoginPage(),
        "/home": (BuildContext context) => MenuInfo(),
      },
      initialRoute: "/login",
      title: 'Flutter Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
