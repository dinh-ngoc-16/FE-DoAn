import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import "package:fe_doan/services/storage_service.dart";
import "dart:convert";

class DetailResult {
  Data? data;
  int? count;

  DetailResult({this.data, this.count});

  DetailResult.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  IdLopHoc? idLopHoc;
  List<ChiTiet>? chiTiet;
  bool? pass;
  dynamic tongDiem;

  Data({this.sId, this.idLopHoc, this.chiTiet, this.pass, this.tongDiem});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idLopHoc =
        json['id_LopHoc'] != null ? IdLopHoc.fromJson(json['id_LopHoc']) : null;
    if (json['chiTiet'] != null) {
      chiTiet = <ChiTiet>[];
      json['chiTiet'].forEach((v) {
        chiTiet!.add(ChiTiet.fromJson(v));
      });
    }
    pass = json['pass'];
    tongDiem = json['tongDiem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (idLopHoc != null) {
      data['id_LopHoc'] = idLopHoc!.toJson();
    }
    if (chiTiet != null) {
      data['chiTiet'] = chiTiet!.map((v) => v.toJson()).toList();
    }
    data['pass'] = pass;
    data['tongDiem'] = tongDiem;
    return data;
  }
}

class IdLopHoc {
  String? sId;
  IdMonHoc? idMonHoc;

  IdLopHoc({this.sId, this.idMonHoc});

  IdLopHoc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idMonHoc =
        json['id_MonHoc'] != null ? IdMonHoc.fromJson(json['id_MonHoc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (idMonHoc != null) {
      data['id_MonHoc'] = idMonHoc!.toJson();
    }
    return data;
  }
}

class IdMonHoc {
  String? sId;
  String? tenMonHoc;
  String? maMonHoc;

  IdMonHoc({this.sId, this.tenMonHoc, this.maMonHoc});

  IdMonHoc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tenMonHoc = json['tenMonHoc'];
    maMonHoc = json['maMonHoc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['tenMonHoc'] = tenMonHoc;
    data['maMonHoc'] = maMonHoc;
    return data;
  }
}

class ChiTiet {
  String? title;
  dynamic phanTram;
  dynamic diem;
  String? sId;

  ChiTiet({this.title, this.phanTram, this.diem, this.sId});

  ChiTiet.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    phanTram = json['phanTram'];
    diem = json['diem'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['phanTram'] = phanTram;
    data['diem'] = diem;
    data['_id'] = sId;
    return data;
  }
}

// ignore: camel_case_types
class detailResult extends StatefulWidget {
  const detailResult({Key? key}) : super(key: key);

  @override
  State<detailResult> createState() => _detailResult();
}

// ignore: camel_case_types
class _detailResult extends State<detailResult> {
  final StorageService _storageService = StorageService();
  late Future<DetailResult> dataFromApi;
  late DateTime date =
      DateTime.parse(formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]));

  @override
  void initState() {
    super.initState();
    dataFromApi = getDetailSubject();
  }

  Future<DetailResult> getDetailSubject() async {
    final idResult = await _storageService.readSecureData("idResult");
    final accessToken = await _storageService.readSecureData("accessToken");
    var url = 'http://10.0.2.2:3500/subject/ketQua/detail/$idResult';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearers $accessToken'
      },
    );
    return DetailResult.fromJson(jsonDecode(response.body));
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
          title: const Text('Chi tiết kết quả'),
        ),
        body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 50),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  SizedBox(
                    child: FutureBuilder<DetailResult>(
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
                                            snapshot.data!.data!.idLopHoc!
                                                .idMonHoc!.tenMonHoc
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
                                          snapshot.data!.data!.idLopHoc!
                                              .idMonHoc!.maMonHoc
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
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                255, 188, 188, 188)))),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 50, 20),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 10),
                                                  child: const Text(
                                                    'Tổng điểm',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 139, 139, 139),
                                                      fontSize: 16,
                                                    ),
                                                  )),
                                              Text(
                                                snapshot.data!.data!.tongDiem
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
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 10),
                                                  child: const Text(
                                                    'Kết quả',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 139, 139, 139),
                                                      fontSize: 16,
                                                    ),
                                                  )),
                                              Row(
                                                children: [
                                                  if (snapshot
                                                          .data!.data!.pass ??
                                                      false) ...[
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 0, 10, 0),
                                                      child: const Text(
                                                        'Đạt',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      "lib/images/check-circle.png",
                                                      height: 25,
                                                    )
                                                  ] else ...[
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 0, 10, 0),
                                                      child: const Text(
                                                        'Không đạt',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      "lib/images/cross-circle.png",
                                                      height: 25,
                                                    )
                                                  ]
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Text('Chi tiết kết quả',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 255, 14, 10))),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(15)),
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        snapshot.data!.data!.chiTiet!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 15, 0, 15),
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 20),
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
                                                  0, 0, 0, 10),
                                              child: Text(
                                                snapshot.data!.data!
                                                    .chiTiet![index].title
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              margin: const EdgeInsets.fromLTRB(
                                                  2, 10, 0, 10),
                                              child: Row(children: [
                                                Image.asset(
                                                  "lib/images/percentage.png",
                                                  height: 18,
                                                ),
                                                Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(8, 0, 0, 0),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                            'Phầm trăm: ',
                                                            style: TextStyle(
                                                                fontSize: 16)),
                                                        Text(
                                                            '${snapshot.data!.data!.chiTiet![index].phanTram.toString()}%',
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
                                                  2, 10, 0, 0),
                                              child: Row(children: [
                                                Image.asset(
                                                  "lib/images/hundred-points.png",
                                                  height: 20,
                                                ),
                                                Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(8, 0, 0, 0),
                                                    child: Row(
                                                      children: [
                                                        const Text('Điểm: ',
                                                            style: TextStyle(
                                                                fontSize: 16)),
                                                        Text(
                                                            snapshot
                                                                .data!
                                                                .data!
                                                                .chiTiet![index]
                                                                .diem
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                      ],
                                                    ))
                                              ]),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
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
                  const SizedBox(height: 30),
                ],
              ),
            )));
  }
}
