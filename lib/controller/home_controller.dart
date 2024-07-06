

import 'dart:convert';

import 'package:digiholicinfotech/api_service/apis.dart';
import 'package:digiholicinfotech/api_service/get_storage.dart';
import 'package:digiholicinfotech/model/userlist_model.dart';
import 'package:digiholicinfotech/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController{

  final isListGrid = true.obs;

  final firstName = ''.obs;
  final lastName = ''.obs;
  final emailId = ''.obs;
  final profileImg = ''.obs;
  final userMainLoder = false.obs;
  final userList = <UserList>[].obs;
  final userListLoader =  false.obs;

  final pageCountDynamic = 2.obs;
  final scrollController = ScrollController().obs;

  pagination() async{
    scrollController.value.addListener(() {
      if (scrollController.value.position.maxScrollExtent == scrollController.value.position.pixels) {
        userListLoader.value = true;
        UserListProvider("${pageCountDynamic.value++}");
      }
    });
  }


  Future UserListProvider(page) async{
    try{
      Apis().commonGetApi("${Urls.userListUrl??""}?${page}").then((value) {
        var data = jsonDecode(value);
        if(data['status']==true){
          UserlistModel user = UserlistModel.fromJson(data);
          userList.addAll(user.userList!);
          userListLoader.value = false;
          userMainLoder.value = false;
        }else{
          userListLoader.value = false;
          userMainLoder.value = false;
          showToastError("Error", "${data['message']??"failed to load"}");
        }
      },).onError((error, stackTrace) {
        userListLoader.value = false;
        userMainLoder.value = false;
        showToastError("Server Error", "${error}");
      },);
    }catch(e){
      userMainLoder.value=false;
      showToastError("Server error", "${e}");
    }

  }

}