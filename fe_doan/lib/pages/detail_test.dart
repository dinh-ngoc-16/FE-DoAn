import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import "package:fe_doan/services/storage_service.dart";
import "dart:convert";
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DetailTest {
  Data? data;
  int? count;

  DetailTest({this.data, this.count});

  DetailTest.fromJson(Map<String, dynamic> json) {
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
  ChiTiet? chiTiet;
  ChiTiet? thiLai;
  String? sId;
  IdLopHoc? idLopHoc;

  Data({this.chiTiet, this.thiLai, this.sId, this.idLopHoc});

  Data.fromJson(Map<String, dynamic> json) {
    chiTiet =
        json['chiTiet'] != null ? ChiTiet.fromJson(json['chiTiet']) : null;
    thiLai = json['thiLai'] != null ? ChiTiet.fromJson(json['thiLai']) : null;
    sId = json['_id'];
    idLopHoc =
        json['id_LopHoc'] != null ? IdLopHoc.fromJson(json['id_LopHoc']) : null;
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

// ignore: camel_case_types
class detailTest extends StatefulWidget {
  const detailTest({Key? key}) : super(key: key);

  @override
  State<detailTest> createState() => _detailTest();
}

// ignore: camel_case_types
class _detailTest extends State<detailTest> {
  final StorageService _storageService = StorageService();
  late Future<DetailTest> dataFromApi;
  late DateTime date =
      DateTime.parse(formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]));

  @override
  void initState() {
    super.initState();
    dataFromApi = getDetailSubject();
  }

  Future<DetailTest> getDetailSubject() async {
    final idLopHoc = await _storageService.readSecureData("idTestDate");
    final accessToken = await _storageService.readSecureData("accessToken");
    var url = 'http://10.0.2.2:3500/subject/lopKT/detail/$idLopHoc';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearers $accessToken'
      },
    );
    return DetailTest.fromJson(jsonDecode(response.body));
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
          title: const Text('Chi tiết buổi kiểm tra'),
        ),
        body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 25, 15, 25),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  SizedBox(
                    child: FutureBuilder<DetailTest>(
                      future: dataFromApi,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
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
                                                snapshot.data!.data!.idLopHoc!
                                                    .idMonHoc!.tenMonHoc
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 188, 188, 188)))),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
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
                                              snapshot.data!.data!.idLopHoc!
                                                  .maLopHoc
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 22,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Text('Thi lần 1',
                                      style: TextStyle(fontSize: 22)),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 188, 188, 188))),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 10, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/marker.png",
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text('Địa điểm: ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        snapshot.data!.data!
                                                            .chiTiet!.diaDiem
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/door.png",
                                              height: 25,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        7, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text('Phòng: ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        snapshot.data!.data!
                                                            .chiTiet!.phong
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 20, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/calendar-days-blue.png",
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text('Ngày: ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(DateTime
                                                                .parse(snapshot
                                                                        .data!
                                                                        .data!
                                                                        .chiTiet!
                                                                        .thoiGianThi!
                                                                        .split(
                                                                            'T')[
                                                                    0])),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 20, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/calendar-clock.png",
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text('Giờ thi: ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        DateFormat('HH:mm')
                                                            .format(DateTime
                                                                .parse(snapshot
                                                                    .data!
                                                                    .data!
                                                                    .chiTiet!
                                                                    .thoiGianThi!)),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 20, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/clock.png",
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                        'Thời gian làm bài (phút): ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        snapshot.data!.data!
                                                            .chiTiet!.thoiGian
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 20, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/text.png",
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                        'Hình thức thi: ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        snapshot
                                                            .data!
                                                            .data!
                                                            .chiTiet!
                                                            .hinhThucThi
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text('Thi lần 2 (dự kiến)',
                                      style: TextStyle(fontSize: 22)),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 188, 188, 188))),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 10, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/marker.png",
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text('Địa điểm: ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        snapshot.data!.data!
                                                            .thiLai!.diaDiem
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/door.png",
                                              height: 25,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        7, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text('Phòng: ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        snapshot.data!.data!
                                                            .thiLai!.phong
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 20, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/calendar-days-blue.png",
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text('Ngày: ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(DateTime
                                                                .parse(snapshot
                                                                        .data!
                                                                        .data!
                                                                        .thiLai!
                                                                        .thoiGianThi!
                                                                        .split(
                                                                            'T')[
                                                                    0])),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 20, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/calendar-clock.png",
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text('Giờ thi: ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        DateFormat('HH:mm')
                                                            .format(DateTime
                                                                .parse(snapshot
                                                                    .data!
                                                                    .data!
                                                                    .thiLai!
                                                                    .thoiGianThi!)),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 20, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/clock.png",
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                        'Thời gian làm bài (phút): ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        snapshot.data!.data!
                                                            .thiLai!.thoiGian
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          margin: const EdgeInsets.fromLTRB(
                                              2, 20, 0, 0),
                                          child: Row(children: [
                                            Image.asset(
                                              "lib/images/text.png",
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 0, 0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                        'Hình thức thi: ',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    Text(
                                                        snapshot.data!.data!
                                                            .thiLai!.hinhThucThi
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ))
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
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
