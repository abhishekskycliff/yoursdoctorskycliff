import 'dart:convert';

import 'package:YOURDRS_FlutterAPP/common/app_api.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/data/model/userclass.datr.dart';
import 'package:http/http.dart' as http;

Future<UserAuth> fetchUserData() async {
  final response = await http.get(
    AppAPI.login_api,
  );
  final responseJson = jsonDecode(response.body);

  return UserAuth.fromJson(responseJson[0]);
}

Future<AuthenticateUser>postApiMethod(name, password) async {
  String apiUrl = ApiUrlConstants.getUser;

  final json = {

      "userName": name,
      "password": password,
      "deviceCode": "string",
      "encryptionKey": "string"

  };

  http.Response response = await http.post(apiUrl, body: jsonEncode(json),headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },);

  var jsonResponse = jsonDecode(response.body);
  print(jsonResponse);
  return AuthenticateUser.fromJson(jsonResponse);
}