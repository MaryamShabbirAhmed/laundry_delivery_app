import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/responses/userLoginResponse.dart';
import 'package:laundry_delivery/screens/pickupScreens/pickupItemSelect.dart';

import 'package:laundry_delivery/utils/colors.dart';
import 'package:laundry_delivery/utils/providerVeriables.dart';
import 'package:laundry_delivery/utils/widgets/buttonCustom.dart';
import 'package:laundry_delivery/utils/widgets/inputFieldCustom.dart';
import 'package:provider/provider.dart';
import '../../providers/pickupProvider.dart';
import '../../utils/widgets/snackbars.dart';
import 'laundrySelectionScreen.dart';

class PickupClothScreen extends StatefulWidget {
  UserLoginResponse? userLoginResponse;

  PickupClothScreen({this.userLoginResponse, Key? key}) : super(key: key);

  @override
  State<PickupClothScreen> createState() => _PickupClothScreenState();
}

class _PickupClothScreenState extends State<PickupClothScreen> {
  bool _isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    pickupPro.getServiceAreas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PickupProvider pickupPro = Provider.of(context, listen: false);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
        title: Text(
          'Booking Details',
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
            ExpansionTile(
              title: Text(
                  pickupPro.pickupLocationController.text.isNotEmpty?
                  pickupPro.pickupLocationController.text
                      :
                  'Service Areas'),
              onExpansionChanged: (expanded) {
                setState(() {
                  _isExpanded = expanded;
                });
              },
              children: [
                if (pickupPro.getServiceAreasResponse != null &&
                    pickupPro.getServiceAreasResponse!.data != null)
                  _isExpanded
                      ? SizedBox(
                    // Wrap the list in a container to set the height when expanded
                    height: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        children: pickupPro
                            .getServiceAreasResponse!.data!
                            .map((area) {
                          return InkWell(
                            onTap: (){
                              pickupPro.pickupLocationController.text=area.address.toString();
                              setState(() {

                              });
                            },


                            child: ListTile(
                              title: Text(
                                area.address.toString(),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                      : SingleChildScrollView(
                    // Use a SingleChildScrollView without a height when not expanded
                    child: Column(
                      children: pickupPro
                          .getServiceAreasResponse!.data!
                          .map((area) {
                        return ListTile(
                          title: Text(
                            area.address.toString(),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                else
                  Container(),
              ],
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
                  pickupPro.getTime(
                      context, pickupPro.pickupBookingTimeController);
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
                  pickupPro.getTime(
                      context, pickupPro.pickupDeliveryTimeController);
                },
              ),
            ),

            CustomButton(
              label: 'Next',
              onPressed: () async {
                await pickupPro.getAllItems();
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
