import "package:fe_doan/models/storage_item.dart";
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import "package:fe_doan/services/storage_service.dart";
import "dart:convert";

// import "package:sticky_headers/sticky_headers.dart";

class Results {
  List<Data>? data;
  int? count;

  Results({this.data, this.count});

  Results.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  IdLopHoc? idLopHoc;
  bool? pass;
  int? tongDiem;

  Data({this.sId, this.idLopHoc, this.pass, this.tongDiem});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    idLopHoc =
        json['id_LopHoc'] != null ? IdLopHoc.fromJson(json['id_LopHoc']) : null;
    pass = json['pass'];
    tongDiem = json['tongDiem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (idLopHoc != null) {
      data['id_LopHoc'] = idLopHoc!.toJson();
    }
    data['pass'] = pass;
    data['tongDiem'] = tongDiem;
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

class ListResult extends StatefulWidget {
  const ListResult({Key? key}) : super(key: key);

  @override
  State<ListResult> createState() => _ListResult();
}

class _ListResult extends State<ListResult> {
  final StorageService _storageService = StorageService();
  bool isChecked = false;
  late Future<Results> dataFromApi;

  @override
  void initState() {
    super.initState();
    dataFromApi = getDataStudent();
  }

  Future<Results> getDataStudent() async {
    final id = await _storageService.readSecureData("id");
    final accessToken = await _storageService.readSecureData("accessToken");
    var url = 'http://10.0.2.2:3500/subject/ketQua/$id';
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearers $accessToken'
      },
    );
    return Results.fromJson(jsonDecode(response.body));
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
          title: const Text('Kết quả học tập'),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child:
              //dialog
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: FutureBuilder<Results>(
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 10),
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .data![index]
                                                      .idLopHoc!
                                                      .idMonHoc!
                                                      .maMonHoc
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .data![index]
                                                      .idLopHoc!
                                                      .idMonHoc!
                                                      .tenMonHoc
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                              )
                                            ]),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 10),
                                                child: Text(
                                                  snapshot
                                                      .data!.data![index].pass
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 0),
                                                child: Text(
                                                  snapshot.data!.data![index]
                                                      .tongDiem
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ])
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
