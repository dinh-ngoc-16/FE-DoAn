// import "package:http/http.dart" as http;
// import 'package:flutter/material.dart';
// import "package:fe_doan/services/storage_service.dart";
// import "dart:convert";

// import "package:sticky_headers/sticky_headers.dart";

// class Schedule {
//   List<Data>? data;
//   int? count;

//   Schedule({this.data, this.count});

//   Schedule.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     count = json['count'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['count'] = count;
//     return data;
//   }
// }

// class Data {
//   ChiTiet? chiTiet;
//   ChiTiet? thiLai;
//   String? sId;
//   String? idLopHoc;
//   bool? hoanThanh;

//   Data({this.chiTiet, this.thiLai, this.sId, this.idLopHoc, this.hoanThanh});

//   Data.fromJson(Map<String, dynamic> json) {
//     chiTiet =
//         json['chiTiet'] != null ? ChiTiet.fromJson(json['chiTiet']) : null;
//     thiLai = json['thiLai'] != null ? ChiTiet.fromJson(json['thiLai']) : null;
//     sId = json['_id'];
//     idLopHoc = json['id_LopHoc'];
//     hoanThanh = json['hoanThanh'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (chiTiet != null) {
//       data['chiTiet'] = chiTiet!.toJson();
//     }
//     if (thiLai != null) {
//       data['thiLai'] = thiLai!.toJson();
//     }
//     data['_id'] = sId;
//     data['id_LopHoc'] = idLopHoc;
//     data['hoanThanh'] = hoanThanh;
//     return data;
//   }
// }

// class ChiTiet {
//   String? thoiGianThi;
//   String? diaDiem;
//   String? phong;
//   int? thoiGian;
//   String? hinhThucThi;

//   ChiTiet(
//       {this.thoiGianThi,
//       this.diaDiem,
//       this.phong,
//       this.thoiGian,
//       this.hinhThucThi});

//   ChiTiet.fromJson(Map<String, dynamic> json) {
//     thoiGianThi = json['thoiGianThi'];
//     diaDiem = json['diaDiem'];
//     phong = json['phong'];
//     thoiGian = json['thoiGian'];
//     hinhThucThi = json['hinhThucThi'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['thoiGianThi'] = thoiGianThi;
//     data['diaDiem'] = diaDiem;
//     data['phong'] = phong;
//     data['thoiGian'] = thoiGian;
//     data['hinhThucThi'] = hinhThucThi;
//     return data;
//   }
// }

// class ScheduleTest extends StatefulWidget {
//   const ScheduleTest({Key? key}) : super(key: key);

//   @override
//   State<ScheduleTest> createState() => _ScheduleTest();
// }

// class _ScheduleTest extends State<ScheduleTest> {
//   final StorageService _storageService = StorageService();
//   bool isChecked = false;
//   late Future<Schedule> dataFromApi;

//   @override
//   void initState() {
//     super.initState();
//     dataFromApi = getDataStudent();
//   }

//   Future<Schedule> getDataStudent() async {
//     final id = await _storageService.readSecureData("id");
//     final accessToken = await _storageService.readSecureData("accessToken");
//     var url = 'http://10.0.2.2:3500/subject/lichkt/$id?all=all';
//     var response = await http.get(
//       Uri.parse(url),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'token': 'Bearers $accessToken'
//       },
//     );
//     return Schedule.fromJson(jsonDecode(response.body));
//   }

//   Future<void> getAllStorage() async {
//     final value = await _storageService.readAllSecureData();
//     for (var i in value) {
//       i.Println();
//     }
//   }

//   navigateTo(BuildContext context, bool type) {
//     if (type == true) {
//       getDataStudent();
//     }
//     setState(() {});
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Color getColor(Set<MaterialState> states) {
//       const Set<MaterialState> interactiveStates = <MaterialState>{
//         MaterialState.pressed,
//         MaterialState.hovered,
//         MaterialState.focused,
//       };
//       if (states.any(interactiveStates.contains)) {
//         return Colors.blue;
//       }
//       return Colors.red;
//     }

//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.red.shade600,
//           title: const Text('Lịch thi'),
//         ),
//         body: SingleChildScrollView(
//           physics: const ScrollPhysics(),
//           child: Row(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //dialog
//               StickyHeader(
//                   header: Container(
//                       decoration: const BoxDecoration(),
//                       child: Row(
//                         // mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Checkbox(
//                             checkColor: Colors.white,
//                             fillColor:
//                                 MaterialStateProperty.resolveWith(getColor),
//                             value: isChecked,
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 isChecked = value!;
//                               });
//                             },
//                           ),
//                           const Text("Hiện tất cả lịch thi")
//                         ],
//                       )),
//                   content: Column(
//                     children: [
//                       Center(
//                         child: FutureBuilder<Schedule>(
//                           future: dataFromApi,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: snapshot.data!.count,
//                                 itemBuilder: (context, index) {
//                                   return ListTile(
//                                     title: Text(snapshot
//                                         .data!.data![index].idLopHoc
//                                         .toString()),
//                                     trailing: Text(snapshot
//                                         .data!.data![index].idLopHoc
//                                         .toString()),
//                                     subtitle: Text(snapshot
//                                         .data!.data![index].idLopHoc
//                                         .toString()),
//                                   );
//                                 },
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text('${snapshot.error}');
//                             }
//                             return const CircularProgressIndicator();
//                           },
//                         ),
//                       )
//                     ],
//                   )),

//               //list view
//             ],
//           ),
//         ));
//   }
// }
