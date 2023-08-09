import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/utils/colors.dart';
import 'package:logger/logger.dart';

Future<void> successSnackBar(String title ,String message) async {

  await Flushbar(title: title,
    titleColor: greenColor,
    message: message,
    messageColor: whiteColor,
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,


  ).show(Get.context!);

}
Future<void> errorSnackBar(String title ,String message) async {

  await Flushbar(title: title,
    titleColor: redColor,
    message: message,
    messageColor: whiteColor,
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,


  ).show(Get.context!);
}
// Future<void> infoSnackBar(String message) async {
  //   await Get.snackbar(
  //     duration: Duration(seconds: 3),
  //     backgroundColor: Colors.black,
  //     margin: EdgeInsets.zero,
  //     borderRadius: 0,
  //     "Alert",
  //     message,
  //     colorText: Colors.white,
  //     icon: Icon(
  //       Icons.info_outline,
  //       color: Colors.white,
  //       size: 40,
  //     ),
  //   );
  // }


Logger logger = Logger();
// gotoPage(Widget widget,
//     {Transition transition Transition.native,
//       Duration duration const Duration(seconds: 1),
//       bool isClosePrevious false}) {
//   if (isClosePrevious) {
//     Get.offAll(() => widget, transition: transition, duration: duration);
//   } else {
//     Get.to(() => widget, transition: transition, duration: duration);
//   }
// }