import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:laundry_delivery/providers/pickupProvider.dart';
import 'package:laundry_delivery/screens/pickupScreens/pickupCloth.dart';
import 'package:laundry_delivery/screens/userAuthScreens/signupScreen.dart';
import 'package:laundry_delivery/utils/colors.dart';
import 'package:laundry_delivery/utils/providerVeriables.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/buttonCustom.dart';


class SearchCustomer extends StatefulWidget {
  const SearchCustomer({Key? key}) : super(key: key);

  @override
  State<SearchCustomer> createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  @override

  @override
  Widget build(BuildContext context) {
    return Consumer<PickupProvider>(builder: (context, pickupPro, child) {
      return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: secondaryColor,
              title: Text('Search Customer', style: TextStyle(color: whiteColor),),
              centerTitle: true,
              leading: IconButton( onPressed: () {  Get.back();}, icon: Icon(Icons.arrow_back_ios, color: whiteColor, size: 15),),

            ),
            body: Column(
              children: [
                SizedBox(
                  height: 100,
                ),

                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: IntlPhoneField(

                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Phone Number',
                      contentPadding: EdgeInsets.symmetric(vertical: 13.0),
                    ),
                    initialCountryCode: 'US', // Initial country code
                    onChanged: (phone) {
                      if( phone.isValidNumber()){
                        pickupPro.userPhoneNumberController.text =
                            phone.completeNumber;
                      }


                    },
                  ),
                ),


                CustomButton(
                  label: 'Search',
                  onPressed: () async {
                    pickupPro.searchCustomer();
                  },
                ),
                CustomButton(
                  label: 'Add New Customer',
                  colorButton: greenishColor,
                  onPressed: () async {
                    authPro.isDriver=false;
                  Get.to(SignupScreen());
                  },
                ),

              ],
            ),
          ));
    });
  }
}
