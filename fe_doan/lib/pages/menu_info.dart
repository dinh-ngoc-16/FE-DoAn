import "package:fe_doan/services/storage_service.dart";
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class Detail {
  String? sId;
  String? tenSV;
  List<String>? mH;
  String? mSSV;
  int? sDT;
  String? khoa;
  String? lopSV;
  String? pass;
  String? userName;

  Detail(
      {this.sId,
      this.tenSV,
      this.mH,
      this.mSSV,
      this.sDT,
      this.khoa,
      this.lopSV,
      this.pass,
      this.userName});

  Detail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tenSV = json['tenSV'];
    mH = json['MH'].cast<String>();
    mSSV = json['MSSV'];
    sDT = json['SDT'];
    khoa = json['khoa'];
    lopSV = json['lopSV'];
    pass = json['pass'];
    userName = json['userName'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['tenSV'] = this.tenSV;
  //   data['MH'] = this.mH;
  //   data['MSSV'] = this.mSSV;
  //   data['SDT'] = this.sDT;
  //   data['khoa'] = this.khoa;
  //   data['lopSV'] = this.lopSV;
  //   data['pass'] = this.pass;
  //   data['userName'] = this.userName;
  //   return data;
  // }
}

// class Menu extends StatefulWidget {
//   const Menu({Key? key}) : super(key: key);

//   @override
//   State<Menu> createState() => MenuInfo();
// }

class MenuInfo extends StatelessWidget {
  static String routeName = "/detail";
  String nameStudent = "Dinh";

  // @override
  // void initState() {
  //   printPackageInformation();
  // }

  final StorageService _storageService = StorageService();
  Future<Detail> getDataStudent() async {
    final id = await _storageService.readSecureData("id");
    final accessToken = await _storageService.readSecureData("accessToken");

    var response = await http.get(
      Uri.parse('http://10.0.2.2:3500/student/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearers $accessToken'
      },
    );
    // final dataForSave = json.decode(response.body) as Map<String, dynamic>;
    return Detail.fromJson(json.decode(response.body));
  }

  // Future<void> getAllStorage() async {
  //   final value = await _storageService.readSecureData("id");
  // for (var i in value) {
  //   i.Println();
  // }
  //   print(value);
  // }
  // Future<void> printPackageInformation() async {
  //   final Detail packageInfo;

  //   packageInfo = await getDataStudent();

  //   print(packageInfo.tenSV);
  //   String? tenSv = packageInfo.tenSV;
  //   String? mssv = packageInfo.mSSV;
  //   nameStudent = "$mssv-$tenSv";
  // final StorageItem storageItem = StorageItem("id", packageInfo.id);
  // await _storageService.writeSecureData(storageItem);
  // final StorageItem storageItem2 =
  //     StorageItem("accessToken", packageInfo.accessToken);
  // await _storageService.writeSecureData(storageItem2);
  // getAllStorage();
  // navigateTo("/home", context);
  // }

  navigateTo(String route, BuildContext context) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  onTap() {}
  @override
  Widget build(BuildContext context) {
    // printPackageInformation();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),

              // logo
              // const SquareTile(imagePath: 'lib/images/logo_van_lang.png'),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 5),
                  borderRadius: BorderRadius.circular(500),
                  color: Colors.grey[200],
                ),
                child: Image.asset(
                  'lib/images/boy.png',
                  height: 150,
                ),
              ),

              const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
              Text(
                nameStudent,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30)),

              GestureDetector(
                onTap: onTap,
                child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0)),
                        Image.asset(
                          'lib/images/user.png',
                          height: 30,
                        ),
                        const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 20, 0)),
                        const Center(
                          child: Text(
                            "student profile",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () => navigateTo('/login', context),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 220),
            ],
          ),
        ),
      ),
    );
  }
}
