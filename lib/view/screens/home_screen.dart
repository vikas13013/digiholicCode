
import 'dart:developer';

import 'package:digiholicinfotech/api_service/get_storage.dart';
import 'package:digiholicinfotech/controller/home_controller.dart';
import 'package:digiholicinfotech/utils/common_widget.dart';
import 'package:digiholicinfotech/utils/style.dart';
import 'package:digiholicinfotech/view/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      initState: (state) {
        state.controller!.isListGrid.value=true;
        state.controller!.firstName.value = "${GetStorage().read("${getStorage.firstName}")??""}";
        state.controller!.lastName.value = "${GetStorage().read("${getStorage.lastName}")??""}";
        state.controller!.emailId.value = "${GetStorage().read("${getStorage.emailId}")??""}";
        state.controller!.profileImg.value = "${GetStorage().read("${getStorage.profileImage}")??""}";
        state.controller!.userList.clear();
        state.controller!.userListLoader.value=false;
        state.controller!.userMainLoder.value=true;
        state.controller!.UserListProvider("1");
        state.controller!.pagination();
      },
      init: HomeController(),
      builder: (controller) {
        print(controller.isListGrid.value);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Row(
              children: [
                CommonChacheImage(50, 50, "${controller.profileImg.value}", 30),
                10.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${controller.firstName.value??""} ${controller.lastName.value}",style: CommonStyle.black16ExtraBold,),
                    5.height,
                    Text("${controller.emailId.value??""}",style: CommonStyle.grey13Bold,),
                  ],
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: commonElevatedButton(
                    backgroundColor: Colors.red, height: 30, width: Get.width*0.1,
                    onTapButton: (){
                      CommonMessageDialogWithTwoOnTaP(context,
                          title: "Come back soon!",
                          text: "Are you sure you want to Log out ?",
                          ontapFirst: (){
                            GetStorage().remove("${getStorage.emailId}");
                            GetStorage().remove("${getStorage.phone}");
                            GetStorage().remove("${getStorage.firstName}");
                            GetStorage().remove("${getStorage.lastName}");
                            GetStorage().remove("${getStorage.password}");
                            GetStorage().remove("${getStorage.token}");
                            GetStorage().remove("${getStorage.userId}");
                            Get.offAll(() => const SignInScreen(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 300));
                          },
                          ontapSecond: (){
                            Get.back();
                          },
                          fBtnName: "YES", sBtnName: "CANCEL");
                    }, child: const Text("Logout",style: TextStyle(color:Colors.white , fontSize: 14,fontWeight: FontWeight.w700)),
                    borderRadius: 5,
                    elevation: 1),
              )
            ],
          ),
          body: Container(
            padding: const EdgeInsets.only(right: 15,left: 15,top: 20),
            alignment: Alignment.center,
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/Mask_Group.png"),fit: BoxFit.fill)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("User list",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black,fontSize: 18),),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                controller.isListGrid.value=true;
                              },
                              child: Image(image: const AssetImage("assets/listview_icon.png"),color: controller.isListGrid.value?CommonColor.primaryColor:CommonColor.blackColor,width: 20,height: 20,)),
                          20.width,
                          InkWell(
                              onTap: () {
                                controller.isListGrid.value=false;
                              },
                              child: Image(image: const AssetImage("assets/grid_icon.png"),color: controller.isListGrid.value?CommonColor.blackColor:CommonColor.primaryColor,height: 20,width: 20,))
                        ],
                      ),
                    )
                  ],
                ),
                15.height,
                controller.isListGrid.value?
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async{
                      controller.userMainLoder.value=true;
                      controller.userList.clear();
                      controller.UserListProvider("1");
                    },
                    child:controller.userMainLoder.value?
                    HomeListViewLoader(context):
                    controller.userList.isEmpty?
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         const Text("User list is empty"),
                         ElevatedButton(
                             onPressed: () {
                               controller.userMainLoder.value=true;
                               controller.userList.clear();
                               controller.UserListProvider("1");
                               }, child: const Text("Refresh"))
                     ],
                     ):
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.userListLoader.value?controller.userList.length+1:controller.userList.length,
                      controller: controller.scrollController.value,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                         if(index<controller.userList.length){
                           var data  = controller.userList[index];
                           return Container(
                             padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                             margin: const EdgeInsets.symmetric(vertical: 5),
                             decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: const BorderRadius.all(Radius.circular(10))),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Flexible(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text.rich(
                                         TextSpan(
                                             text: "${data.firstName??""}  ",
                                             children: [
                                               TextSpan(
                                                   text: "${data.lastName??""}"
                                               )
                                             ]
                                         ),
                                       ),
                                       10.height,
                                       Text.rich(
                                         TextSpan(
                                             text: "${data.email??""}  ",
                                             children: [
                                               TextSpan(
                                                   text: "${data.phoneNo??""}"
                                               )
                                             ]
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                                 Container(
                                     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                                     decoration: BoxDecoration(border: Border.all(color: CommonColor.primaryColor),borderRadius: const BorderRadius.all(Radius.circular(8))),
                                     child: const Text("View Profile",style: TextStyle(fontSize: 10,color: CommonColor.primaryColor),))
                               ],
                             ),
                           );
                         }else{
                           return const Center(child: CircularProgressIndicator(color: Colors.blue,));
                         }

                      },),
                  ),
                ):
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async{
                      controller.userMainLoder.value=true;
                      controller.userList.clear();
                      controller.UserListProvider("1");
                    },
                    child:controller.userMainLoder.value?
                    HomeGridViewLoader(context):
                    controller.userList.isEmpty?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("User list is empty"),
                        ElevatedButton(
                            onPressed: () {
                              controller.userMainLoder.value=true;
                              controller.userList.clear();
                              controller.UserListProvider("1");
                            }, child: const Text("Refresh"))
                      ],
                    ):
                    GridView.builder(
                      itemCount: controller.userListLoader.value?controller.userList.length+1:controller.userList.length,
                      shrinkWrap: true,
                      controller: controller.scrollController.value,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2/2.2,
                          crossAxisSpacing: 10
                      ),
                      itemBuilder: (context, index) {
                        if(index<controller.userList.length){
                          var data = controller.userList[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: const BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${data.firstName??""}",maxLines: 1,),
                                5.height,
                                Text("${data.lastName??""}",maxLines: 1,),
                                5.height,
                                Text("${data.email??""}",maxLines: 2,),
                                5.height,
                                Text("${data.phoneNo??""}",maxLines: 1,),
                                const Spacer(),
                                Container(
                                    alignment: Alignment.center,
                                    width: Get.width,
                                    padding: const EdgeInsets.symmetric(vertical: 7),
                                    decoration: BoxDecoration(border: Border.all(color: CommonColor.primaryColor),borderRadius: const BorderRadius.all(Radius.circular(8))),
                                    child: const Text("View Profile",style: TextStyle(fontSize: 10,color: CommonColor.primaryColor),))
                              ],
                            ),
                          );
                        }else{
                          return const Center(child: CircularProgressIndicator(color: Colors.blue,));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    },);
  }
}
