import "dart:convert";
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import "package:fe_doan/components/my_button.dart";
import "package:fe_doan/components/my_textfield.dart";
import "package:fe_doan/components/square_title.dart";
import 'package:fe_doan/models/storage_item.dart';
import 'package:fe_doan/services/storage_service.dart';

class Student {
  final String id;
  final String accessToken;

  Student({required this.id, required this.accessToken});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'] as String, accessToken: json['accessToken'] as String);
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final StorageService _storageService = StorageService();
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  Future<Student> signUserIn() async {
    var response = await http.post(
      Uri.parse('http://10.0.2.2:3500/student/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': usernameController.text,
        'pass': passwordController.text
      }),
    );
    // final dataForSave = json.decode(response.body) as Map<String, dynamic>;
    return Student.fromJson(json.decode(response.body));
  }

  Future<void> printPackageInformation(context) async {
    final Student packageInfo;

    packageInfo = await signUserIn();

    final StorageItem storageItem = StorageItem("id", packageInfo.id);
    await _storageService.writeSecureData(storageItem);
    final StorageItem storageItem2 =
        StorageItem("accessToken", packageInfo.accessToken);
    await _storageService.writeSecureData(storageItem2);
    navigateTo("/home", context);
  }

  Future<void> getAllStorage() async {
    final value = await _storageService.readAllSecureData();
    for (var i in value) {
      i.Println();
    }
  }

  navigateTo(String route, BuildContext context) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const SquareTile(
                imagePath: 'lib/images/logo_van_lang.png',
                circular: 16,
                size: 250,
              ),

              const SizedBox(height: 50),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: () => printPackageInformation(context),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
