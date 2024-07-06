import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonColor{
  static const Color primaryColor = Colors.blueAccent;
  static const Color blackColor = Colors.black;

}

extension EmptySpace on num {
  SizedBox get height => SizedBox(height: toDouble(),);
  SizedBox get width => SizedBox(width: toDouble(),);
}

class CommonStyle{

  static const grey13Bold = TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w500);


  static const black16ExtraBold = TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700);
  static const black18ExtraBold = TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700);


  static const white = TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700);



}


InputDecoration inputDecoration(BuildContext context, {String? lable,String? hint}) {
  return InputDecoration(
      floatingLabelBehavior:FloatingLabelBehavior.always,
      hintText: hint??"",
      hintStyle: TextStyle(
          color: Colors.grey.shade400
      ),
      labelText: lable,
      labelStyle: CommonStyle.black16ExtraBold,
      border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5)),borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5)),borderSide: BorderSide(color: Colors.grey.shade300)),
      disabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5)),borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(5)),borderSide: BorderSide(color: Colors.grey.shade300))
  );
}

showToastError(String title,String message){
  return Get.snackbar("${title}", "${message}",backgroundColor: Colors.red,colorText: Colors.white,duration: Duration(seconds: 3));
}

showToastSucces(String title,String message){
  return Get.snackbar("${title}", "${message}",backgroundColor: Colors.green,colorText: Colors.white,duration: Duration(seconds: 3));
}


Widget CommonChacheImage(double imgHeight,double imgWidht,String Url,double borderRadius){
  return CachedNetworkImage(
    imageBuilder: (context, imageProvider) => Container(
      height:  imgHeight,
      width:  imgWidht,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(image: imageProvider,fit: BoxFit.fill)
      ),
    ),
    imageUrl: Url,
    errorWidget: (context, url, error) => Container(
      height:  imgHeight,
      width:  imgWidht,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          image: AssetImage("assets/loading.gif"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    placeholder: (context, url) => Container(
      height:  imgHeight,
      width:  imgWidht,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          image: AssetImage("assets/loading.gif"),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}