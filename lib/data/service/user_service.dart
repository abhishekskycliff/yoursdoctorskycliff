import 'dart:convert';
import 'dart:io';

import 'package:YOURDRS_FlutterAPP/common/app_api.dart';
import 'package:YOURDRS_FlutterAPP/data/model/userclass.datr.dart';
import 'package:http/http.dart' as http;

Future<UserAuth> fetchUserData() async {
  final response = await http.get(
    AppAPI.login_api,
  //  headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
  );
  final responseJson = jsonDecode(response.body);


  return UserAuth.fromJson(responseJson[0]);
}