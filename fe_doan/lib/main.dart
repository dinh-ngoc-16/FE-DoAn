import 'package:fe_doan/pages/detail_result.dart';
import 'package:fe_doan/pages/detail_test.dart';
import 'package:fe_doan/pages/detail_student.dart';
import 'package:fe_doan/pages/list_result.dart';
import 'package:fe_doan/pages/question_menu.dart';
import 'package:fe_doan/pages/shedule_subject.dart';
import 'package:fe_doan/pages/shedule_test.dart';
import 'package:fe_doan/pages/login_page.dart';
import 'package:fe_doan/pages/menu_info.dart';
import 'package:fe_doan/pages/detail_subject.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => LoginPage(),
        "/home": (BuildContext context) => const MenuInfo(),
        "/detail": (BuildContext context) => const DetailStudent(),
        "/schedule": (BuildContext context) => const ScheduleSubject(),
        "/schedule_test": (BuildContext context) => const ScheduleTest(),
        "/subject_detail": (BuildContext context) => const detailSubject(),
        "/test_detail": (BuildContext context) => const detailTest(),
        "/list-result": (BuildContext context) => const ListResult(),
        "/result_detail": (BuildContext context) => const detailResult(),
        "/question-menu": (BuildContext context) => const QuestionMenu(),
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
