import "package:fe_doan/models/storage_item.dart";
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import "package:fe_doan/services/storage_service.dart";
import "dart:convert";

// import "package:sticky_headers/sticky_headers.dart";

class Schedule {
  List<Data>? data;
  int? count;

  Schedule({this.data, this.count});

  Schedule.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Data {
  ChiTiet? chiTiet;
  ChiTiet? thiLai;
  String? sId;
  IdLopHoc? idLopHoc;
  bool? hoanThanh;

  Data({this.chiTiet, this.thiLai, this.sId, this.idLopHoc, this.hoanThanh});

  Data.fromJson(Map<String, dynamic> json) {
    chiTiet =
        json['chiTiet'] != null ? ChiTiet.fromJson(json['chiTiet']) : null;
    thiLai = json['thiLai'] != null ? ChiTiet.fromJson(json['thiLai']) : null;
    sId = json['_id'];
    idLopHoc =
        json['id_LopHoc'] != null ? IdLopHoc.fromJson(json['id_LopHoc']) : null;
    hoanThanh = json['hoanThanh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chiTiet != null) {
      data['chiTiet'] = chiTiet!.toJson();
    }
    if (thiLai != null) {
      data['thiLai'] = thiLai!.toJson();
    }
    data['_id'] = sId;
    if (idLopHoc != null) {
      data['id_LopHoc'] = idLopHoc!.toJson();
    }
    data['hoanThanh'] = hoanThanh;
    return data;
  }
}

class ChiTiet {
  String? thoiGianThi;
  String? diaDiem;
  String? phong;
  int? thoiGian;
  String? hinhThucThi;

  ChiTiet(
      {this.thoiGianThi,
      this.diaDiem,
      this.phong,
      this.thoiGian,
      this.hinhThucThi});

  ChiTiet.fromJson(Map<String, dynamic> json) {
    thoiGianThi = json['thoiGianThi'];
    diaDiem = json['diaDiem'];
    phong = json['phong'];
    thoiGian = json['thoiGian'];
    hinhThucThi = json['hinhThucThi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thoiGianThi'] = thoiGianThi;
    data['diaDiem'] = diaDiem;
    data['phong'] = phong;
    data['thoiGian'] = thoiGian;
    data['hinhThucThi'] = hinhThucThi;
    return data;
  }
}

class IdLopHoc {
  String? sId;
  String? maLopHoc;
  IdMonHoc? idMonHoc;

  IdLopHoc({this.sId, this.maLopHoc, this.idMonHoc});

  IdLopHoc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    maLopHoc = json['maLopHoc'];
    idMonHoc =
        json['id_MonHoc'] != null ? IdMonHoc.fromJson(json['id_MonHoc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['maLopHoc'] = maLopHoc;
    if (idMonHoc != null) {
      data['id_MonHoc'] = idMonHoc!.toJson();
    }
    return data;
  }
}

class IdMonHoc {
  String? sId;
  String? tenMonHoc;
  int? tC;

  IdMonHoc({this.sId, this.tenMonHoc, this.tC});

  IdMonHoc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tenMonHoc = json['tenMonHoc'];
    tC = json['TC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['tenMonHoc'] = tenMonHoc;
    data['TC'] = tC;
    return data;
  }
}

class ScheduleTest extends StatefulWidget {
  const ScheduleTest({Key? key}) : super(key: key);

  @override
  State<ScheduleTest> createState() => _ScheduleTest();
}

class _ScheduleTest extends State<ScheduleTest> {
  final StorageService _storageService = StorageService();
  bool isChecked = false;
  late Future<Schedule> dataFromApi;

  @override
  void initState() {
    super.initState();
    dataFromApi = getDataStudent();
  }

  Future<Schedule> getDataStudent() async {
    final id = await _storageService.readSecureData("id");
    final accessToken = await _storageService.readSecureData("accessToken");
    var url = 'http://10.0.2.2:3500/subject/lichkt/$id?all=now';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearers $accessToken'
      },
    );
    return Schedule.fromJson(jsonDecode(response.body));
  }

  Future<void> getAllStorage() async {
    final value = await _storageService.readAllSecureData();
    for (var i in value) {
      i.Println();
    }
  }

  goToDetail(BuildContext context, String idTestDate) async {
    final StorageItem storageItem = StorageItem("idTestDate", idTestDate);
    await _storageService.writeSecureData(storageItem);
    // ignore: use_build_context_synchronously
    navigateTo(context, '/test_detail');
  }

  navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.red.shade600,
          title: const Text('Lịch kiểm tra'),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child:
              //dialog
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: FutureBuilder<Schedule>(
                  future: dataFromApi,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.count,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => goToDetail(context,
                                snapshot.data!.data![index].sId.toString()),
                            child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 20, 68, 171),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 15),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey))),
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            Flexible(
                                              child: Text(
                                                  snapshot
                                                      .data!
                                                      .data![index]
                                                      .idLopHoc!
                                                      .idMonHoc!
                                                      .tenMonHoc
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18)),
                                            ),
                                          ]),
                                          Row(children: [
                                            Flexible(
                                                child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 5, 0, 0),
                                              child: Text(
                                                snapshot.data!.data![index]
                                                    .idLopHoc!.maLopHoc
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                            )),
                                          ]),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Row(children: [
                                              Image.asset(
                                                "lib/images/marker.png",
                                                height: 20,
                                              ),
                                              Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 0, 0),
                                                  child: Text(
                                                      'Địa điểm: ${snapshot.data!.data![index].chiTiet!.diaDiem.toString()}',
                                                      style: const TextStyle(
                                                          fontSize: 15)))
                                            ]),
                                          ),
                                        ),
                                        Flexible(
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Row(children: [
                                              Image.asset(
                                                "lib/images/door.png",
                                                height: 23,
                                              ),
                                              Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 0, 0),
                                                  child: Text(
                                                      'Phòng: ${snapshot.data!.data![index].chiTiet!.phong.toString()}',
                                                      style: const TextStyle(
                                                          fontSize: 15)))
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              )
            ],

            //list view
          ),
        ));
  }
}
