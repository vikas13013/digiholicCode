

import 'dart:convert';
import 'dart:developer';

import 'package:digiholicinfotech/api_service/get_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http ;

import '../utils/style.dart';

class Urls{

  static String baseUrl = "https://mmfinfotech.co/machine_test/api/";

  static String loginUlr = "${baseUrl}userLogin";
  static String registerUrl = "${baseUrl}userRegister";
  static String userListUrl = "${baseUrl}userList";
  static String logout = "${baseUrl}logout";

}

class Apis{

  Future<dynamic> commonPostAPi(Map<String, dynamic> body,apiEndPoint) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${apiEndPoint}'));
    request.body = json.encode(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.bytesToString();
    }
    else {
      print(response.reasonPhrase);
      showToastError("Error", "${response.reasonPhrase}");

    }

  }

  Future<dynamic> commonGetApi(apiEndPoint) async {
    var headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer ${GetStorage().read("${getStorage.token??""}")}'
    };
    var request = http.Request('GET', Uri.parse('${apiEndPoint}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return response.stream.bytesToString();
    }
    else {
      print(response.reasonPhrase);
      showToastError("Error", "${response.reasonPhrase}");

    }

  }


}