import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../model/tenants_model.dart';
import '../utils/string_constants.dart';

class TenantsController {
  final tenantsItem = <TenantsData>[];

  Box box = Hive.box(ConstantStrings.localDB);

   openBox() async {
    box = await Hive.openBox(ConstantStrings.localDB);
  }

   putData(List<TenantsData> data) async {
    List<Map<String, dynamic>> jsonData = data.map((e) => e.toJson()).toList();
    await Hive.box(ConstantStrings.localDB).put(ConstantStrings.dbKey, jsonData);
   }


  // Call API for fetchTenantsItems
  Future<List<TenantsData>> fetchTenantsItems(String tenantId) async {
    openBox();
    String baseUrl = "${ConstantStrings.baseURL}$tenantId/widgets";
    var response = await http.get(Uri.parse(baseUrl),);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      debugPrint("LOG:: fetchTenantsItems Result:: $result");
      Iterable list = result;
      print("Hello ${list.map((tenantsData) => TenantsData.fromJson(tenantsData)).toList()}");
      return list.map((tenantsData) => TenantsData.fromJson(tenantsData)).toList();

      putData(tenantsItem);
    } else {
      throw Exception("Failed to load data");
    }
  }
}

final userProvider = Provider<TenantsController>((ref)=>TenantsController());