import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/responses/userLoginResponse.dart';
import 'package:laundry_delivery/screens/pickupScreens/pickupItemSelect.dart';

import 'package:laundry_delivery/utils/colors.dart';
import 'package:laundry_delivery/utils/widgets/buttonCustom.dart';
import 'package:laundry_delivery/utils/widgets/inputFieldCustom.dart';
import 'package:provider/provider.dart';
import '../../providers/pickupProvider.dart';
import 'laundrySelectionScreen.dart';

class PickupClothScreen extends StatefulWidget {
  UserLoginResponse? userLoginResponse;


  PickupClothScreen( {this.userLoginResponse,Key? key}) : super(key: key);

  @override
  State<PickupClothScreen> createState() => _PickupClothScreenState();
}

class _PickupClothScreenState extends State<PickupClothScreen> {
  @override
  Widget build(BuildContext context) {
    PickupProvider pickupPro = Provider.of(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        title: Text(
          'Pickup Cloths',
          style: TextStyle(
              color: whiteColor, fontSize: 17, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Container(
            //     height: 43,
            //     child: Center(
            //       child: SearchBar(
            //         hintText: 'Search customer name or number',
            //         shadowColor: MaterialStateProperty.resolveWith(
            //           (state) {
            //             return Colors.transparent;
            //           },
            //         ),
            //         hintStyle: MaterialStateProperty.resolveWith((states) {
            //           return TextStyle(color: borderGreyColor);
            //         }),
            //         backgroundColor:
            //             MaterialStateProperty.resolveWith((states) {
            //           return Color(0xFFF5F5F5);
            //         }),
            //         shape: MaterialStateProperty.resolveWith((states) {
            //           return RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10));
            //         }),
            //         leading: Image.asset(
            //           'assets/dashboard_images/search.png',
            //           color: borderGreyColor,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            InputFieldCustom(
              controller: pickupPro.pickupLocationController,
              label: 'Location',
              hint: 'House / Flat / Block No',
            ),
            InputFieldCustom(
              controller: pickupPro.pickupLocationController2,
              label: null,
              hint: 'Apartment / Road / Area',
            ),
            InputFieldCustom(
              controller: pickupPro.pickupCustomerNameController,
              label: 'Name',
              hint: 'Enter Customer Name',
            ),
            InputFieldCustom(

              controller: pickupPro.pickupContactController,
              label: 'Contact Number',
              hint: 'Enter Contact Number',
            ),
            // InputFieldCustom(
            //   controller: pickupPro.pickupPacketController,
            //   label: 'Pickup packets',
            //   hint: 'Enter Pick Up Packets',
            // ),
            // InputFieldCustom(
            //   controller: pickupPro.pickupRemarksController,
            //   label: 'Remarks',
            //   hint: 'Enter Remarks...',
            //   maxLines: 4,
            //   inputType: TextInputType.multiline,
            //   minLines: 4,
            // ),
            InputFieldCustom(
              readOnly: true,
              controller: pickupPro.pickupBookingDateController,
              label: 'Booking Date',
              hint: 'Select Date',
              suffix: IconButton(
                  onPressed: () async {
                    await pickupPro.selectDate(context);
                    pickupPro.pickupBookingDateController.text =
                    "${pickupPro.selectedDate.toLocal()}".split(' ')[0];
                    setState(() {});
                  },
                  icon: Icon(Icons.calendar_month, color: borderGreyColor)),
            ),
            InputFieldCustom(
              controller: pickupPro.pickupBookingTimeController,
              readOnly: true,
              label: 'Booking Time',
              hint: 'Select Time',
              suffix: IconButton(
                icon: Icon(Icons.access_time_rounded, color: borderGreyColor),
                onPressed: () async {
                  pickupPro.getTime(context, pickupPro.pickupBookingTimeController);
                },
              ),
            ),
            InputFieldCustom(
              readOnly: true,
              controller: pickupPro.pickupDeliveryDateController,
              label: 'Delivery Date',
              hint: 'Select Date',
              suffix: IconButton(
                  onPressed: () async {
                    await pickupPro.selectDate(context);
                    pickupPro.pickupDeliveryDateController.text =
                        "${pickupPro.selectedDate.toLocal()}".split(' ')[0];
                    setState(() {});
                  },
                  icon: Icon(Icons.calendar_month, color: borderGreyColor)),
            ),
            InputFieldCustom(
              controller: pickupPro.pickupDeliveryTimeController,
              readOnly: true,
              label: 'Delivery Time',
              hint: 'Select Time',
              suffix: IconButton(
                icon: Icon(Icons.access_time_rounded, color: borderGreyColor),
                onPressed: () async {
                  pickupPro.getTime(context,pickupPro.pickupDeliveryTimeController);
                },
              ),
            ),

            CustomButton(
              label: 'Next',
              onPressed: () async {
             await  pickupPro.getAllItems();
                     Get.to(LaundrySelectionScreen());
                // await pickupPro.pickupInputValidation();
                // successSnackBar('Success', 'Submitted Successfully', context);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
