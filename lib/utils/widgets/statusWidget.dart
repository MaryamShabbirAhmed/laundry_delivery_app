import 'package:flutter/material.dart';

import '../colors.dart';

class StatusWidget extends StatelessWidget {
  String status;

  Color backgroundColor;
   StatusWidget({Key? key, required this.status, required  this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: backgroundColor,
              borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
          child: Center(child: Text(status, style: TextStyle(color: whiteColor,fontSize: 15),)),
        ),
      ),
    );
  }
}
