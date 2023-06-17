import 'package:flutter/material.dart';
import "package:fe_doan/components/my_button.dart";

class QuestionMenu extends StatelessWidget {
  const QuestionMenu({super.key});

  navigateTo(String route, BuildContext context) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FD),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 250),

              // sign in button
              Container(
                margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused)) {
                        return Colors.red;
                      }
                      return null; // Defer to the widget's default.
                    }),
                  ),
                  onPressed: () {},
                  child: const Text('TextButton'),
                ),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                child: MyButton(
                  // ignore: avoid_print
                  onTap: () => print('Câu hỏi của bạn đã gửi cho trường'),
                ),
              ),

              const SizedBox(height: 250),
            ],
          ),
        ),
      ),
    );
  }
}
