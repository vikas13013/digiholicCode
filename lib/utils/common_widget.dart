import 'package:digiholicinfotech/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

Widget HomeListViewLoader(context){
  var width = Get.width;
  var height = Get.height;
  return ListView.builder(
    itemCount: 10,
    physics: ScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return  Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        period: Duration(seconds: 1),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width*0.3,
                      height: 10,
                      color: Colors.white,
                    ),
                    10.height,
                    Container(
                      width: width*0.45,
                      height: 10,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                  decoration: BoxDecoration(border: Border.all(color: CommonColor.primaryColor),borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Text("View Profile",style: TextStyle(fontSize: 10,color: CommonColor.primaryColor),))
            ],
          ),
        ),
      );
    },
  );
}

Widget commonText(context,{required double height,required double width}){
  return  Container(
    height: height,
    width:width,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: const BorderRadius.all(Radius.circular(7)),
    ),
  );
}


Widget HomeGridViewLoader(context){
  var width = Get.width;
  var height = Get.height;
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    period: Duration(seconds: 1),
    child: GridView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/2.2,
          crossAxisSpacing: 10
      ),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText(context, height: 7, width: width*0.3),
              10.height,
              commonText(context, height: 7, width: width*0.3),
              10.height,
              commonText(context, height: 7, width: width*0.3),
              10.height,
              commonText(context, height: 7, width: width*0.3),
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
      },
    ),
  );
}

commonElevatedButton({required Color backgroundColor ,required double height,required double width ,required  onTapButton ,required Widget child,required double borderRadius,required double elevation, bordarcolor,bordarWidth}){
  return ElevatedButton(
    onPressed: onTapButton, child: child,
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: bordarcolor==null?Colors.transparent:bordarcolor,
            width: bordarWidth==null?0.0:bordarWidth,

          )
      ),
      fixedSize: Size(width, height),


      elevation: elevation,
      backgroundColor: backgroundColor,

    ),

  );
}

CommonMessageDialogWithTwoOnTaP(context,{title,required text,required Function ontapFirst,required Function ontapSecond,loader,required fBtnName,required sBtnName}){
  return showGeneralDialog(
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      context: context,
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: Dialog(
            // insetPadding: EdgeInsets.symmetric(horizontal: 15),
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 0,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15),
              children: [
                title==null || title==""?SizedBox():
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text("${title}",style: TextStyle(color:CommonColor.blackColor , fontSize: 22,fontWeight: FontWeight.w700),textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("${text}",style: TextStyle(color:CommonColor.blackColor , fontSize: 14, fontWeight: FontWeight.w700),textAlign: TextAlign.center),
                ),
                20.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    commonElevatedButton(
                        backgroundColor: CommonColor.primaryColor,
                        height: 40,
                        width: 100,
                        onTapButton: () {
                          ontapFirst();
                        }, child: Text("${fBtnName}",style: TextStyle(color:Colors.white , fontSize: 16, fontFamily: "Montserrat700")), borderRadius: 5, elevation: 1),
                    commonElevatedButton(
                        backgroundColor: CommonColor.primaryColor,
                        height: 40,
                        width: 100,
                        onTapButton: () {
                          ontapSecond();
                        }, child: Text("${sBtnName}",style: TextStyle(color:Colors.white , fontSize: 16, fontFamily: "Montserrat700")), borderRadius: 5, elevation: 1),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400)
  );
}
