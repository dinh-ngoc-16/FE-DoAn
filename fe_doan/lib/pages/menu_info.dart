import 'package:flutter/material.dart';

class MenuInfo extends StatefulWidget {
  const MenuInfo({Key? key}) : super(key: key);

  @override
  State<MenuInfo> createState() => _menuInfo();
}

// ignore: camel_case_types
class _menuInfo extends State<MenuInfo> {
  @override
  void initState() {
    super.initState();
  }

  navigateTo(String route, BuildContext context) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    // printPackageInformation();
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FD),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red.shade600,
        title: const Text('Menu'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
            Container(
              padding: const EdgeInsets.all(20),
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 20, 68, 171), width: 5),
                  borderRadius: BorderRadius.circular(500),
                  color: Colors.grey[200],
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'lib/images/boy.png',
                      ))),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
            Column(children: const <Widget>[
              SizedBox(
                  height: 50,
                  child: Text(
                    "Xin Chào",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ))
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => navigateTo("/detail", context),
                  child: Container(
                      height: 150,
                      width: 150,
                      // padding: const EdgeInsets.all(20),
                      // margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/images/user.png',
                            height: 30,
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          const Center(
                            child: Text(
                              "Thông tin sinh viên",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () => navigateTo("/schedule", context),
                  child: Container(
                      height: 150,
                      width: 150,
                      // padding: const EdgeInsets.all(20),
                      // margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/images/calendar.png',
                            height: 30,
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          const Center(
                            child: Text(
                              "Lịch Học",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => navigateTo("/schedule_test", context),
                  child: Container(
                      height: 150,
                      width: 150,
                      // padding: const EdgeInsets.all(20),
                      // margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/images/list_check.png',
                            height: 30,
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          const Center(
                            child: Text(
                              "Lịch thi",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () => navigateTo("/list-result", context),
                  child: Container(
                      height: 150,
                      width: 150,
                      // padding: const EdgeInsets.all(20),
                      // margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/images/test.png',
                            height: 30,
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          const Center(
                            child: Text(
                              "Kết quả học tập",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => navigateTo("/schedule", context),
                  child: Container(
                      height: 150,
                      width: 150,
                      // padding: const EdgeInsets.all(20),
                      // margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/images/money_check.png',
                            height: 30,
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          const Center(
                            child: Text(
                              "Tài chính sinh viên",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () => navigateTo("/question-menu", context),
                  child: Container(
                      height: 150,
                      width: 150,
                      // padding: const EdgeInsets.all(20),
                      // margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/images/messages-question.png',
                            height: 30,
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                          const Center(
                            child: Text(
                              "Thắc mắc",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20))
          ],
        ),
      ),
    );
  }
}
