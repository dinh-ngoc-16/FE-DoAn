import 'package:fe_doan/models/storage_item.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import "package:fe_doan/services/storage_service.dart";
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:sticky_headers/sticky_headers.dart';
import "dart:convert";

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
  ThoiGian? thoiGian;
  String? sId;
  String? maLopHoc;
  IdMonHoc? idMonHoc;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.thoiGian,
      this.sId,
      this.maLopHoc,
      this.idMonHoc,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    thoiGian =
        json['thoiGian'] != null ? ThoiGian.fromJson(json['thoiGian']) : null;
    sId = json['_id'];
    maLopHoc = json['maLopHoc'];
    idMonHoc =
        json['id_MonHoc'] != null ? IdMonHoc.fromJson(json['id_MonHoc']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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

class ScheduleSubject extends StatefulWidget {
  const ScheduleSubject({Key? key}) : super(key: key);

  @override
  State<ScheduleSubject> createState() => _scheduleSubject();
}

// ignore: camel_case_types
class _scheduleSubject extends State<ScheduleSubject> {
  final StorageService _storageService = StorageService();
  late Future<Schedule> dataFromApi;
  late DateTime date =
      DateTime.parse(formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]));

  @override
  void initState() {
    super.initState();
    dataFromApi = getDataStudent();
  }

  Future<Schedule> getDataStudent() async {
    final id = await _storageService.readSecureData("id");
    final accessToken = await _storageService.readSecureData("accessToken");
    var valueDate = date.toString().split(' ')[0];
    var url = 'http://10.0.2.2:3500/subject/lichhoc/$id?date=$valueDate';
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

  goToDetail(BuildContext context, String idLopHoc) async {
    final StorageItem storageItem = StorageItem("idLopHoc", idLopHoc);
    await _storageService.writeSecureData(storageItem);
    final StorageItem storageDate =
        StorageItem("dateSelected", date.toString().split(' ')[0]);
    await _storageService.writeSecureData(storageDate);
    // ignore: use_build_context_synchronously
    navigateTo(context, 'detail', '/subject_detail');
  }

  navigateTo(BuildContext context, String? type, String route) async {
    if (type == 'dialog') {
      dataFromApi = getDataStudent();
      setState(() {});
      Navigator.pop(context);
    } else if (type == 'detail') {
      Navigator.pushNamed(context, route);
    }
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    String data = formatDate(args.value, [yyyy, '-', mm, '-', dd]);
    date = DateTime.parse(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF0F4FD),
        appBar: AppBar(
          backgroundColor: Colors.red.shade600,
          title: const Text('Lịch Học'),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //dialog
              StickyHeader(
                header: Container(
                  decoration: const BoxDecoration(color: Color(0xffF0F4FD)),
                  child: TextButton(
                      onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                SfDateRangePicker(
                                    backgroundColor: Colors.white,
                                    showActionButtons: true,
                                    headerHeight: 180,
                                    todayHighlightColor: Colors.red,
                                    selectionColor: Colors.red,
                                    viewSpacing: 100,
                                    initialSelectedDate: date,
                                    onSelectionChanged: _onSelectionChanged,
                                    navigationDirection:
                                        DateRangePickerNavigationDirection
                                            .vertical,
                                    onCancel: () =>
                                        navigateTo(context, 'dialog', ''),
                                    cancelText: 'Xác nhận',
                                    confirmText: '',
                                    showTodayButton: true,
                                    toggleDaySelection: true),
                          ),
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child:
                              // color: Colors.white,
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                Flexible(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "lib/images/calendar-days.png",
                                          height: 20,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 0, 0, 0),
                                          child: const Text('Calender',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.red)),
                                        ),
                                      ],
                                    )),
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Text(
                                          formatDate(
                                              date, [dd, '-', mm, '-', yyyy]),
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Color(0xff5A55CA))),
                                    ))
                              ]))),
                ),
                content: Center(
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
                                                    snapshot.data!.data![index]
                                                        .idMonHoc!.tenMonHoc
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18)),
                                              ),
                                            ]),
                                            Row(children: [
                                              Flexible(
                                                  child: Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 5, 0, 0),
                                                child: Text(
                                                  snapshot.data!.data![index]
                                                      .maLopHoc
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
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              child: Row(children: [
                                                Image.asset(
                                                  "lib/images/marker.png",
                                                  height: 20,
                                                ),
                                                Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(5, 0, 0, 0),
                                                    child: Text(
                                                        'Địa điểm: ${snapshot.data!.data![index].thoiGian!.gioHoc!.isEmpty ? '' : snapshot.data!.data![index].thoiGian!.gioHoc![0].diaDiem.toString()}',
                                                        style: const TextStyle(
                                                            fontSize: 15)))
                                              ]),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              child: Row(children: [
                                                Image.asset(
                                                  "lib/images/door.png",
                                                  height: 23,
                                                ),
                                                Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(5, 0, 0, 0),
                                                    child: Text(
                                                        'Phòng: ${snapshot.data!.data![index].thoiGian!.gioHoc!.isEmpty ? '' : snapshot.data!.data![index].thoiGian!.gioHoc![0].phong.toString()}',
                                                        style: const TextStyle(
                                                            fontSize: 15)))
                                              ]),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              child: Row(children: [
                                                Image.asset(
                                                  "lib/images/clock.png",
                                                  height: 20,
                                                ),
                                                Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(5, 0, 0, 0),
                                                    child: Text(
                                                      'Ca: ${snapshot.data!.data![index].thoiGian!.gioHoc!.isEmpty ? '' : snapshot.data!.data![index].thoiGian!.gioHoc![0].ca.toString()}',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ))
                                              ]),
                                            ),
                                          ),
                                        ],
                                      )
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
                ),
              ),
              //list view
            ],
          ),
        ));
  }
}
