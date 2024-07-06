import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{


  // SignIn screen controller*******************************

  final loginLoader = false.obs;
  final isSignInSignUp = false.obs;
  final isSignInGlobalKey = GlobalKey<FormState>().obs;
  final signInEmailController =  TextEditingController().obs;
  final signInPasswordController =  TextEditingController().obs;


  // SignUp screen controller*******************************

  final registrationLoader = false.obs;
  final isSignUpGlobalKey = GlobalKey<FormState>().obs;
  final signUpFirstNameController =  TextEditingController().obs;
  final signUpLastNameController =  TextEditingController().obs;
  final signUpPhoneController =  TextEditingController().obs;
  final signUpEmailController =  TextEditingController().obs;
  final signUpPasswordController =  TextEditingController().obs;
  final signUpConfirmPasswordController =  TextEditingController().obs;

}