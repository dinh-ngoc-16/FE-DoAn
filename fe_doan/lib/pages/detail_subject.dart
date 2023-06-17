import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import "package:fe_doan/services/storage_service.dart";
import "dart:convert";

class DetailSubject {
  Data? data;
  int? count;

  DetailSubject({this.data, this.count});

  DetailSubject.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['count'] = count;
    return data;
  }
}

class Data {
  ThoiGian? thoiGian;
  String? sId;
  String? maLopHoc;
  IdMonHoc? idMonHoc;

  Data({this.thoiGian, this.sId, this.maLopHoc, this.idMonHoc});

  Data.fromJson(Map<String, dynamic> json) {
    thoiGian =
        json['thoiGian'] != null ? ThoiGian.fromJson(json['thoiGian']) : null;
    sId = json['_id'];
    maLopHoc = json['maLopHoc'];
    idMonHoc =
        json['id_MonHoc'] != null ? IdMonHoc.fromJson(json['id_MonHoc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (thoiGian != null) {
      data['thoiGian'] = thoiGian!.toJson();
    }
    data['_id'] = sId;
    data['maLopHoc'] = maLopHoc;
    if (idMonHoc != null) {
      data['id_MonHoc'] = idMonHoc!.toJson();
    }
    return data;
  }
}

class ThoiGian {
  String? ngayBD;
  String? ngayKT;
  List<GioHoc>? gioHoc;

  ThoiGian({this.ngayBD, this.ngayKT, this.gioHoc});

  ThoiGian.fromJson(Map<String, dynamic> json) {
    ngayBD = json['ngayBD'];
    ngayKT = json['ngayKT'];
    if (json['gioHoc'] != null) {
      gioHoc = <GioHoc>[];
      json['gioHoc'].forEach((v) {
        gioHoc!.add(GioHoc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ngayBD'] = ngayBD;
    data['ngayKT'] = ngayKT;
    if (gioHoc != null) {
      data['gioHoc'] = gioHoc!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GioHoc {
  String? diaDiem;
  String? thu;
  String? phong;
  int? ca;
  String? loai;
  String? sId;
  GV? gV;

  GioHoc(
      {this.diaDiem,
      this.thu,
      this.phong,
      this.ca,
      this.loai,
      this.sId,
      this.gV});

  GioHoc.fromJson(Map<String, dynamic> json) {
    diaDiem = json['diaDiem'];
    thu = json['thu'];
    phong = json['phong'];
    ca = json['ca'];
    loai = json['loai'];
    sId = json['_id'];
    gV = json['GV'] != null ? GV.fromJson(json['GV']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['diaDiem'] = diaDiem;
    data['thu'] = thu;
    data['phong'] = phong;
    data['ca'] = ca;
    data['loai'] = loai;
    data['_id'] = sId;
    if (gV != null) {
      data['GV'] = gV!.toJson();
    }
    return data;
  }
}

class GV {
  String? sId;
  String? tenGV;

  GV({this.sId, this.tenGV});

  GV.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tenGV = json['tenGV'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['tenGV'] = tenGV;
    return data;
  }
}

class IdMonHoc {
  String? sId;
  String? tenMonHoc;
  String? maMonHoc;
  IdKhoa? idKhoa;

  IdMonHoc({this.sId, this.tenMonHoc, this.maMonHoc, this.idKhoa});

  IdMonHoc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tenMonHoc = json['tenMonHoc'];
    maMonHoc = json['maMonHoc'];
    idKhoa = json['id_khoa'] != null ? IdKhoa.fromJson(json['id_khoa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['tenMonHoc'] = tenMonHoc;
    data['maMonHoc'] = maMonHoc;
    if (idKhoa != null) {
      data['id_khoa'] = idKhoa!.toJson();
    }
    return data;
  }
}

class IdKhoa {
  String? sId;
  String? maKhoa;
  String? tenKhoa;

  IdKhoa({this.sId, this.maKhoa, this.tenKhoa});

  IdKhoa.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    maKhoa = json['maKhoa'];
    tenKhoa = json['tenKhoa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['maKhoa'] = maKhoa;
    data['tenKhoa'] = tenKhoa;
    return data;
  }
}

// ignore: camel_case_types
class detailSubject extends StatefulWidget {
  const detailSubject({Key? key}) : super(key: key);

  @override
  State<detailSubject> createState() => _detailSubject();
}

// ignore: camel_case_types
class _detailSubject extends State<detailSubject> {
  final StorageService _storageService = StorageService();
  late Future<DetailSubject> dataFromApi;
  late DateTime date =
      DateTime.parse(formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]));

  @override
  void initState() {
    super.initState();
    dataFromApi = getDetailSubject();
  }

  Future<DetailSubject> getDetailSubject() async {
    final idLopHoc = await _storageService.readSecureData("idLopHoc");
    final accessToken = await _storageService.readSecureData("accessToken");
    final valueDate = await _storageService.readSecureData("dateSelected");
    var url =
        'http://10.0.2.2:3500/subject/lopHoc/detail/$idLopHoc?date=$valueDate';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearers $accessToken'
      },
    );
    return DetailSubject.fromJson(jsonDecode(response.body));
  }

  Future<void> getAllStorage() async {
    final value = await _storageService.readAllSecureData();
    for (var i in value) {
      i.Println();
    }
  }

  // static Route<void> _myRouteBuilder(BuildContext context, Object? arguments) {
  //   return MaterialPageRoute<void>(
  //     builder: (BuildContext context) => const detailSubject(),
  //   );
  // }

  navigateTo(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.red.shade600,
          title: const Text('Chi tiết lớp học'),
        ),
        body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  SizedBox(
                    child: FutureBuilder<DetailSubject>(
                      future: dataFromApi,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 188, 188, 188)))),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              child: const Text(
                                                'Tên môn học',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 139, 139, 139),
                                                  fontSize: 16,
                                                ),
                                              )),
                                          Text(
                                            snapshot
                                                .data!.data!.idMonHoc!.tenMonHoc
                                                .toString(),
                                            style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 22,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: const Text(
                                              'Mã lớp học',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 139, 139, 139),
                                                fontSize: 16,
                                              ),
                                            )),
                                        Text(
                                          snapshot.data!.data!.maLopHoc
                                              .toString(),
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: const Text(
                                              'Khoa',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 139, 139, 139),
                                                fontSize: 16,
                                              ),
                                            )),
                                        Text(
                                          snapshot.data!.data!.idMonHoc!.idKhoa!
                                              .tenKhoa
                                              .toString(),
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: const Text(
                                              'Giảng viên',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 139, 139, 139),
                                                fontSize: 16,
                                              ),
                                            )),
                                        Text(
                                          'Ths. ${snapshot.data?.data?.thoiGian?.gioHoc?[0].gV?.tenGV ?? ''}',
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: Row(children: [
                                          Image.asset(
                                            "lib/images/marker.png",
                                            height: 20,
                                          ),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              child: Text(
                                                  'Địa điểm: ${snapshot.data!.data!.thoiGian!.gioHoc!.isEmpty ? '' : snapshot.data!.data!.thoiGian!.gioHoc![0].diaDiem.toString()}',
                                                  style: const TextStyle(
                                                      fontSize: 17)))
                                        ]),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 0),
                                        child: Row(children: [
                                          Image.asset(
                                            "lib/images/clock.png",
                                            height: 20,
                                          ),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              child: Text(
                                                  'Ca: ${snapshot.data!.data!.thoiGian!.gioHoc!.isEmpty ? '' : snapshot.data!.data!.thoiGian!.gioHoc![0].ca.toString()}',
                                                  style: const TextStyle(
                                                      fontSize: 17)))
                                        ]),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 10, 10, 0),
                                        child: Row(children: [
                                          Image.asset(
                                            "lib/images/door.png",
                                            height: 23,
                                          ),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              child: Text(
                                                  'Phòng: ${snapshot.data!.data!.thoiGian!.gioHoc!.isEmpty ? '' : snapshot.data!.data!.thoiGian!.gioHoc![0].phong.toString()}',
                                                  style: const TextStyle(
                                                      fontSize: 17)))
                                        ]),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 20, 10, 0),
                                        child: Row(children: [
                                          Image.asset(
                                            "lib/images/text.png",
                                            height: 21,
                                          ),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              child: Text(
                                                  'Loại: ${snapshot.data!.data!.thoiGian!.gioHoc!.isEmpty ? '' : snapshot.data!.data!.thoiGian!.gioHoc![0].loai.toString()}',
                                                  style: const TextStyle(
                                                      fontSize: 17)))
                                        ]),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ]),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  const SizedBox(height: 90),
                  GestureDetector(
                    // onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    //     '/home', (Route<dynamic> route) => false),
                    onTap: () => navigateTo(context),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(16),
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
                  const SizedBox(height: 50),
                ],
              ),
            )));
  }
}
