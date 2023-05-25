import 'package:flutter/material.dart';
import 'package:laundry_delivery/utils/colors.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _pinPutFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: TextStyle(
        fontSize: 20,
        color: whiteColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: whiteColor, width: 2),
        color: primaryColor,
      ),
    );



    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'Verification Code',
              style: TextStyle(
                  color: whiteColor, fontWeight: FontWeight.w500, fontSize: 25),
            ),
            Text(
              'Enter Otp send to the mobile',
              style: TextStyle(color: whiteColor, fontSize: 15),
            ),
            Text(
              'Number ******454',
              style: TextStyle(color: whiteColor, fontSize: 15),
            ),
            SizedBox(
              height: 20,
            ),
            Pinput(
              length: 4,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme,
              submittedPinTheme: defaultPinTheme,
              focusNode: _pinPutFocusNode,
              // onCompleted: ,
              // controller: data.pinPutController,
            ),
          ],
        ),
      ),
    );
  }

//
}
