import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import "package:fe_doan/services/storage_service.dart";
import "dart:convert";
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class Detail {
  String? sId;
  String? tenSV;
  String? lopSV;
  int? sDT;
  Khoa? khoa;
  String? mSSV;
  String? khoaHoc;
  String? gioiTinh;
  String? queQuan;
  List<ThanNhan>? thanNhan;
  String? dob;
  CoVan? coVan;

  Detail(
      {this.sId,
      this.tenSV,
      this.lopSV,
      this.sDT,
      this.khoa,
      this.mSSV,
      this.khoaHoc,
      this.gioiTinh,
      this.queQuan,
      this.thanNhan,
      this.dob,
      this.coVan});

  Detail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tenSV = json['tenSV'];
    lopSV = json['lopSV'];
    sDT = json['SDT'];
    khoa = json['khoa'] != null ? Khoa.fromJson(json['khoa']) : null;
    mSSV = json['MSSV'];
    khoaHoc = json['khoaHoc'];
    gioiTinh = json['gioiTinh'];
    queQuan = json['queQuan'];
    if (json['thanNhan'] != null) {
      thanNhan = <ThanNhan>[];
      json['thanNhan'].forEach((v) {
        thanNhan!.add(ThanNhan.fromJson(v));
      });
    }
    dob = json['dob'];
    coVan = json['coVan'] != null ? CoVan.fromJson(json['coVan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['tenSV'] = tenSV;
    data['lopSV'] = lopSV;
    data['SDT'] = sDT;
    if (khoa != null) {
      data['khoa'] = khoa!.toJson();
    }
    data['MSSV'] = mSSV;
    data['khoaHoc'] = khoaHoc;
    data['gioiTinh'] = gioiTinh;
    data['queQuan'] = queQuan;
    if (thanNhan != null) {
      data['thanNhan'] = thanNhan!.map((v) => v.toJson()).toList();
    }
    data['dob'] = dob;
    if (coVan != null) {
      data['coVan'] = coVan!.toJson();
    }
    return data;
  }
}

class Khoa {
  String? sId;
  String? tenKhoa;

  Khoa({this.sId, this.tenKhoa});

  Khoa.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tenKhoa = json['tenKhoa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['tenKhoa'] = tenKhoa;
    return data;
  }
}

class ThanNhan {
  String? sId;
  String? hoTenThanNhan;
  int? sdt;
  String? dob;
  String? gioiTinh;
  String? vaiTro;

  ThanNhan(
      {this.sId,
      this.hoTenThanNhan,
      this.sdt,
      this.dob,
      this.gioiTinh,
      this.vaiTro});

  ThanNhan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    hoTenThanNhan = json['hoTenThanNhan'];
    sdt = json['sdt'];
    dob = json['dob'];
    gioiTinh = json['gioiTinh'];
    vaiTro = json['vaiTro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['hoTenThanNhan'] = hoTenThanNhan;
    data['sdt'] = sdt;
    data['dob'] = dob;
    data['gioiTinh'] = gioiTinh;
    data['vaiTro'] = vaiTro;
    return data;
  }
}

class CoVan {
  String? sId;
  String? tenGV;
  int? sDT;

  CoVan({this.sId, this.tenGV, this.sDT});

  CoVan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    tenGV = json['tenGV'];
    sDT = json['SDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['tenGV'] = tenGV;
    data['SDT'] = sDT;
    return data;
  }
}

// ignore: camel_case_types
class DetailStudent extends StatefulWidget {
  const DetailStudent({Key? key}) : super(key: key);

  @override
  State<DetailStudent> createState() => _DetailStudent();
}

// ignore: camel_case_types
class _DetailStudent extends State<DetailStudent> {
  final StorageService _storageService = StorageService();
  late Future<Detail> dataFromApi;
  late DateTime date =
      DateTime.parse(formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]));

  @override
  void initState() {
    super.initState();
    dataFromApi = getDataStudent();
  }

  late Future<Detail> dataFromAPI;

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
    return Detail.fromJson(json.decode(response.body));
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
          title: const Text('Thông tin sinh viên'),
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
                  const SizedBox(height: 20),
                  SizedBox(
                    child: FutureBuilder<Detail>(
                      future: dataFromApi,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 20, 68, 171),
                                            width: 5),
                                        borderRadius:
                                            BorderRadius.circular(500),
                                        color: Colors.grey[200],
                                        image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'lib/images/vinh_ngu.jpg',
                                            ))),
                                  ),
                                  // thong tin sinh vien
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 20),
                                      child: const Text(
                                        'Thông tin sinh viên',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 14, 10)),
                                      )),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                                    'Tên Sinh viên',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 139, 139, 139),
                                                      fontSize: 16,
                                                    ),
                                                  )),
                                              Text(
                                                snapshot.data!.tenSV
                                                    .toString()
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
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                                  'Mã sinh viên',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            Text(
                                              snapshot.data!.mSSV.toString(),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                                  'Giới tính',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            Text(
                                              snapshot.data!.gioiTinh
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                                  'Ngày sinh',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            Text(
                                              DateFormat('dd-MM-yyyy').format(
                                                  DateTime.parse(snapshot
                                                      .data!.dob!
                                                      .split('T')[0])),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                                  'Quê quán',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            Text(
                                              snapshot.data!.queQuan.toString(),
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
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 188, 188, 188)))),
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 30),
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
                                                  'SĐT',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            Text(
                                              snapshot.data!.sDT.toString(),
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
                                  // thong tin khoa hoc
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 25),
                                      child: const Text(
                                        'Thông tin khóa học',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 14, 10)),
                                      )),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                                  'Khóa học',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            Text(
                                              snapshot.data!.khoaHoc.toString(),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                                  'Khoa',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            Text(
                                              snapshot.data!.khoa!.tenKhoa
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                                  'Lớp học',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            Text(
                                              snapshot.data!.lopSV.toString(),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                                  'Cố vấn học tập',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            Text(
                                              snapshot.data!.coVan!.tenGV
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
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 188, 188, 188)))),
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 30),
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
                                                  'SĐT cố vấn',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                    fontSize: 16,
                                                  ),
                                                )),
                                            Text(
                                              snapshot.data!.coVan!.sDT
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
                                  //than nhan
                                  const Text('Người bảo hộ',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 14, 10))),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            snapshot.data!.thanNhan!.length,
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
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 10),
                                                  child: Text(
                                                    '- Thân nhân ${index + 1}',
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
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 10, 0, 10),
                                                  child: Row(children: [
                                                    Image.asset(
                                                      "lib/images/clock.png",
                                                      height: 20,
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            8, 0, 0, 0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Tên thân nhân: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16)),
                                                            Text(
                                                                snapshot
                                                                    .data!
                                                                    .thanNhan![
                                                                        index]
                                                                    .hoTenThanNhan
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))
                                                          ],
                                                        ))
                                                  ]),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 10, 0, 0),
                                                  child: Row(children: [
                                                    Image.asset(
                                                      "lib/images/marker.png",
                                                      height: 20,
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            8, 0, 0, 0),
                                                        child: Row(
                                                          children: [
                                                            const Text('SDT: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16)),
                                                            Text(
                                                                snapshot
                                                                    .data!
                                                                    .thanNhan![
                                                                        index]
                                                                    .sdt
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))
                                                          ],
                                                        ))
                                                  ]),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 20, 0, 0),
                                                  child: Row(children: [
                                                    Image.asset(
                                                      "lib/images/door.png",
                                                      height: 25,
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            7, 0, 0, 0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Giới tính: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16)),
                                                            Text(
                                                                snapshot
                                                                    .data!
                                                                    .thanNhan![
                                                                        index]
                                                                    .gioiTinh
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
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
                                                          BorderRadius.circular(
                                                              15)),
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 20, 0, 0),
                                                  child: Row(children: [
                                                    Image.asset(
                                                      "lib/images/calendar-days-blue.png",
                                                      height: 20,
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            8, 0, 0, 0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Ngày sinh: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16)),
                                                            Text(
                                                                DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot
                                                                        .data!
                                                                        .thanNhan![
                                                                            index]
                                                                        .dob!
                                                                        .split(
                                                                            'T')[
                                                                    0])),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
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
                                                          BorderRadius.circular(
                                                              15)),
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 20, 0, 15),
                                                  child: Row(children: [
                                                    Image.asset(
                                                      "lib/images/calendar-clock.png",
                                                      height: 20,
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            8, 0, 0, 0),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Vai trò: ',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16)),
                                                            Text(
                                                                snapshot
                                                                    .data!
                                                                    .thanNhan![
                                                                        index]
                                                                    .vaiTro
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
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
                  const SizedBox(height: 50),
                ],
              ),
            )));
  }
}
