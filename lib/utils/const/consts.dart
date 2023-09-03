



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../colors.dart';

var height=Get.height;
var width=Get.width;

SizedBox  heightBox(double h){
  return SizedBox(height: h,);

}
SizedBox widthBox(double b) {
  return SizedBox(width: b);
}



    startProgress()  {
    if (!Get.isDialogOpen!)
       Get.generalDialog(pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: SpinKitCircle(itemBuilder: (BuildContext context, index) {
            return Container(
              width: 10,
              height: 10,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(100), color: secondaryColor),
            );
          }),
        );
      });
  }

 stopProgress()  {
    if (Get.isDialogOpen!)
       Get.back();
  }



  //

