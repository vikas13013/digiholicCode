import 'dart:convert';
import 'dart:developer';
import 'package:digiholicinfotech/api_service/apis.dart';
import 'package:digiholicinfotech/api_service/get_storage.dart';
import 'package:digiholicinfotech/controller/auth_controller.dart';
import 'package:digiholicinfotech/utils/style.dart';
import 'package:digiholicinfotech/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      init: AuthController(),
      initState: (state) {
        state.controller!.isSignInSignUp.value = true;
      },
      builder: (controller) {
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/Mask_Group.png"),fit: BoxFit.fill)),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          controller.isSignInSignUp.value=true;
                        },
                        child: const Text("Sign in",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),)),
                    20.width,
                    InkWell(
                        onTap: () {
                          controller.isSignInSignUp.value=false;
                        },
                        child: const Text("Sign up",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),)),
                  ],
                ),
                controller.isSignInSignUp.value?SignIn(context):SignUp(context),
              ],
            ),
          ),
        ),
      );
    },);
  }

  Widget SignIn(context){
    return GetX<AuthController>(
      init: AuthController(),
      builder: (controller) {
      return Form(
        key: controller.isSignInGlobalKey.value,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                    width: Get.width*0.17,
                    child: const Divider(color: Colors.blue,thickness: 2,)),
                SizedBox(
                    width: Get.width*0.67,
                    child: Divider(color: Colors.grey.shade300,thickness: 2,))
              ],
            ),
            SizedBox(height: Get.height*0.04,),
            TextFormField(
              controller: controller.signInEmailController.value,
              keyboardType: TextInputType.emailAddress,
              decoration: inputDecoration(context, hint: "Enter your email", lable: "E-mail",),
              validator: (value) {
                if(value == null || value.isEmpty){
                  return "Please enter email";
                }else if(GetUtils.isEmail(value)==false){
                  return "Please enter correct email";
                }
                return null;
              },
            ),
            25.height,
            TextFormField(
              controller: controller.signInPasswordController.value,
              keyboardType: TextInputType.text,
              decoration: inputDecoration(context, hint: "Enter your password", lable: "Password",),
              validator: (value) {
                if(value == null || value.isEmpty){
                  return "Please enter password";
                }
                return null;
              },
            ),
            50.height,
            ElevatedButton(
              style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(Get.width, Get.height*0.066)),
                  backgroundColor:  const WidgetStatePropertyAll(Colors.blueAccent),
                  shape: const WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))
              ),
              onPressed: () {
                if(controller.isSignInGlobalKey.value.currentState!.validate()){
                  Map<String, dynamic> para = {
                    "email":"${controller.signInEmailController.value.text??""}",
                    "password":"${controller.signInPasswordController.value.text??""}"
                  };
                  log("${para}");
                  controller.loginLoader.value =  true;
                  try{
                    Apis().commonPostAPi(para, "${Urls.loginUlr}",).then((value) {
                      var data = jsonDecode(value);
                      log("${data}");
                      if(data['status']==true){
                        GetStorage().write("${getStorage.userId}", '${data['record']['id']??""}');
                        GetStorage().write("${getStorage.firstName}", '${data['record']['firstName']??""}');
                        GetStorage().write("${getStorage.lastName}", '${data['record']['lastName']??""}');
                        GetStorage().write("${getStorage.emailId}", '${data['record']['email']??""}');
                        GetStorage().write("${getStorage.phone}", '${data['record']['phoneNo']??""}');
                        GetStorage().write("${getStorage.profileImage}", '${data['record']['profileImg']??""}');
                        GetStorage().write("${getStorage.token}", '${data['record']['authtoken']??""}');
                        GetStorage().write("${getStorage.password}", '${controller.signInPasswordController.value.text}');
                        showToastSucces("Success", "${data['message']??"login successfully"}");
                        Get.off(()=>const HomeScreen(),duration: const Duration(milliseconds: 300),transition: Transition.fadeIn);
                        controller.loginLoader.value =  false;
                      }else{
                        showToastError("Error", "${data['message']??"failed to load"}");
                        controller.loginLoader.value =  false;
                      }
                    },).onError((error, stackTrace) {
                      controller.loginLoader.value =  false;
                      showToastError("Error", "${error}");
                    },);
                  }catch(e){
                    controller.loginLoader.value =  false;
                    showToastError("Server error", "${e}");
                  }
                }
              },
              child:controller.loginLoader.value?SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)):Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
            15.height,
            const Align(
              alignment: Alignment.centerRight,
              child: Text("Forgot Password?",style: TextStyle(fontSize: 15),),
            ),
            50.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: Get.width*0.25,child: const Divider(color: Colors.black,)),
                const Text("Or signin with"),
                SizedBox(width: Get.width*0.25,child: const Divider(color: Colors.black,))
              ],
            ),
            25.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage("assets/Facebook_icon.png"),width: 30,),
                40.width,
                const Image(image: AssetImage("assets/Google_pay_icon.png"),width: 30,),
                40.width,
                const Image(image: AssetImage("assets/apple_icon.png"),width: 30,),
              ],
            ),
            SizedBox(
              height: Get.height*0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have a Account?",style: TextStyle(color: Colors.grey.shade400,fontSize: 12,fontWeight: FontWeight.w400),),
                5.width,
                InkWell(
                    onTap: () {
                      controller.isSignInSignUp.value=false;
                    },
                    child: const Text("Sign up",style: TextStyle(color: Colors.blue,fontSize: 14,fontWeight: FontWeight.w500),))
              ],
            ),
          ],
        ),
      );
    },);
  }

  Widget SignUp(context){
    return GetX<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return Form(
          key: controller.isSignUpGlobalKey.value,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                      width: Get.width*0.2,
                      child: Divider(color: Colors.grey.shade300,thickness: 2,)),
                  SizedBox(
                      width: Get.width*0.2,
                      child: const Divider(color: Colors.blue,thickness: 2,)),
                  SizedBox(
                      width: Get.width*0.44,
                      child: Divider(color: Colors.grey.shade300,thickness: 2,))
                ],
              ),
              SizedBox(height: Get.height*0.04,),
              TextFormField(
                controller: controller.signUpFirstNameController.value,
                keyboardType: TextInputType.text,
                decoration: inputDecoration(context, hint: "Enter first name", lable: "First name",),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please enter first name";
                  }
                  return null;
                },
              ),
              25.height,
              TextFormField(
                controller: controller.signUpLastNameController.value,
                keyboardType: TextInputType.text,
                decoration: inputDecoration(context, hint: "Enter last name", lable: "Last name",),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please enter last name";
                  }
                  return null;
                },
              ),
              25.height,
              TextFormField(
                controller: controller.signUpPhoneController.value,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),],
                decoration: inputDecoration(context, hint: "Enter phone number", lable: "Phone number",),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please enter mobile no.";
                  }else if(value.length<10){
                    return "Please enter correct mobile no.";
                  }
                  return null;
                },
              ),
              25.height,
              TextFormField(
                controller: controller.signUpEmailController.value,
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecoration(context, hint: "Enter your email", lable: "E-mail",),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please enter email";
                  }else if(GetUtils.isEmail(value)==false){
                    return "Please enter correct email";
                  }
                  return null;
                },
              ),
              25.height,
              TextFormField(
                controller: controller.signUpPasswordController.value,
                keyboardType: TextInputType.text,
                decoration: inputDecoration(context, hint: "Enter password", lable: "Password",),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please enter password";
                  }else if(value.length<8){
                    return "Please enter password at least 8 characters";
                  }
                  return null;
                },
              ),
              25.height,
              TextFormField(
                controller: controller.signUpConfirmPasswordController.value,
                keyboardType: TextInputType.text,
                decoration: inputDecoration(context, hint: "Enter confirm password", lable: "Confirm password",),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please enter confirm password";
                  }else if(value.length<8){
                    return "Please enter password at least 8 characters";
                  }else if(value.toString()!=controller.signUpConfirmPasswordController.value.text.toString()){
                    return "Password not match";
                  }
                  return null;
                },
              ),
              50.height,
              ElevatedButton(
                style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(Get.width, Get.height*0.066)),
                    backgroundColor:  const WidgetStatePropertyAll(Colors.blueAccent),
                    shape: const WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))
                ),
                onPressed: () {
                  if(controller.isSignUpGlobalKey.value.currentState!.validate()){

                    Map<String, dynamic> para = {
                      "first_name":"${controller.signUpFirstNameController.value.text.toString()??""}",
                      "last_name":"${controller.signUpLastNameController.value.text.toString()??""}",
                      "country_code":"+91",
                      "phone_no":"${controller.signUpPhoneController.value.text.toString()??""}",
                      "email":"${controller.signUpEmailController.value.text.toString()??""}",
                      "password":"${controller.signUpPasswordController.value.text.toString()??""}",
                      "confirm_password":"${controller.signUpConfirmPasswordController.value.text.toString()??""}",
                    };
                    controller.registrationLoader.value = true;
                    log("parapara");
                    log(para.toString());
                    Apis().commonPostAPi(para, "${Urls.registerUrl}").then((value) {
                      var data = jsonDecode(value);
                      if(data['status']==true){
                        log("parapara11");
                        log(data.toString());
                        GetStorage().write("${getStorage.userId}", '${data['data']['id']??""}');
                        GetStorage().write("${getStorage.firstName}", '${controller.signUpFirstNameController.value.text}');
                        GetStorage().write("${getStorage.lastName}", '${controller.signUpLastNameController.value.text}');
                        GetStorage().write("${getStorage.emailId}", '${data['data']['email']??""}');
                        GetStorage().write("${getStorage.phone}", '${controller.signUpPhoneController.value.text}');
                        GetStorage().write("${getStorage.password}", '${controller.signUpPasswordController.value.text}');
                        GetStorage().write("${getStorage.token}", '${data['data']['authtoken']??""}');
                        showToastSucces("Success", "${data['message']??"Register successfully"}");
                        controller.registrationLoader.value = false;
                        Get.off(()=>const HomeScreen(),duration: const Duration(milliseconds: 300),transition: Transition.fadeIn);
                        controller.signUpFirstNameController.value.clear();
                        controller.signUpLastNameController.value.clear();
                        controller.signUpPhoneController.value.clear();
                        controller.signUpEmailController.value.clear();
                        controller.signUpPasswordController.value.clear();
                        controller.signUpConfirmPasswordController.value.clear();
                      }else{
                        showToastError("Error", "${data['message']??"failed to load"}");
                        controller.registrationLoader.value = false;
                      }
                    },).onError((error, stackTrace) {
                      showToastError("Error", "${error}");
                      controller.registrationLoader.value = false;
                    },);
                  }
                },
                child: controller.registrationLoader.value?SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)):Text("Register",style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
            ],
          ),
        );
      },);
  }

}
