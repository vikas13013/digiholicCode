
import 'dart:async';

import 'package:digiholicinfotech/api_service/get_storage.dart';
import 'package:digiholicinfotech/view/auth/sign_in_screen.dart';
import 'package:digiholicinfotech/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 3),(){
      if(GetStorage().read("${getStorage.token}")==null || GetStorage().read("${getStorage.token}")==""){
        Get.to(()=>const SignInScreen(),duration: const Duration(milliseconds: 300),transition: Transition.fadeIn);
      }else{
        Get.off(()=>const HomeScreen(),duration: const Duration(milliseconds: 300),transition: Transition.fadeIn);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/Mask_Group.png"),fit: BoxFit.fill)),
        child: Image(image: AssetImage("assets/digiholic_logo.png"),height: Get.height*0.05,width: Get.width*0.4,),
      ),
    );
  }
}
