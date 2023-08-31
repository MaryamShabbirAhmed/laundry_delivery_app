import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:laundry_delivery/providers/pickupProvider.dart';
import 'package:laundry_delivery/screens/pickupScreens/laundrySelectionScreen.dart';
import 'package:laundry_delivery/screens/pickupScreens/pickupCloth.dart';
import 'package:laundry_delivery/screens/userAuthScreens/signupScreen.dart';
import 'package:laundry_delivery/utils/colors.dart';
import 'package:laundry_delivery/utils/providerVeriables.dart';
import 'package:laundry_delivery/utils/widgets/inputFieldCustom.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/buttonCustom.dart';
import '../../utils/widgets/snackbars.dart';

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
          title: Text(
            'Search Customer',
            style: TextStyle(color: whiteColor),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, color: whiteColor, size: 15),
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InputFieldCustom(
                        borderColor: secondaryColor,
                        controller: pickupPro.searcKeyWord,
                      )),
                  pickupPro.getCustomerSearchResponse != null &&
                          pickupPro.getCustomerSearchResponse!.data!.length != 0
                      ? Container(
                          height: Get.height / 1.8,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: Get.height / 1.8,
                                  child: ListView.builder(
                                      itemCount: pickupPro
                                                  .getCustomerSearchResponse !=
                                              null
                                          ? pickupPro.getCustomerSearchResponse!
                                                  .data!.length ??
                                              0
                                          : 0,
                                      itemBuilder: (context, index) {

                                        return InkWell(
                                          onTap: () {
                                            pickupPro
                                                    .pickupCustomerNameController
                                                    .text =
                                                pickupPro
                                                    .getCustomerSearchResponse!
                                                    .data![index]
                                                    .name
                                                    .toString();
                                            pickupPro.pickupContactController
                                                    .text =
                                                pickupPro
                                                    .getCustomerSearchResponse!
                                                    .data![index]
                                                    .mobileNumber
                                                    .toString();
                                            pickupPro.userID = pickupPro
                                                    .getCustomerSearchResponse!
                                                    .data![index]
                                                    .id
                                                    .toString() ??
                                                '';
                                            pickupPro.searcKeyWord.clear();
                                            pickupPro.getCustomerSearchResponse=null;
                                            Get.to(PickupClothScreen());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: greenishColor),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          pickupPro.getCustomerSearchResponse !=
                                                                  null
                                                              ? pickupPro.getCustomerSearchResponse!
                                                                          .data! !=
                                                                      []
                                                                  ? pickupPro
                                                                              .getCustomerSearchResponse!
                                                                              .data![
                                                                                  index]
                                                                              .name !=
                                                                          null
                                                                      ? pickupPro
                                                                          .getCustomerSearchResponse!
                                                                          .data![
                                                                              index]
                                                                          .name
                                                                          .toString()
                                                                      : ''
                                                                  : ''
                                                              : '',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        Text(
                                                          pickupPro.getCustomerSearchResponse !=
                                                                  null
                                                              ? pickupPro.getCustomerSearchResponse!
                                                                          .data! !=
                                                                      []
                                                                  ? pickupPro
                                                                              .getCustomerSearchResponse!
                                                                              .data![
                                                                                  index]
                                                                              .mobileNumber !=
                                                                          null
                                                                      ? pickupPro
                                                                          .getCustomerSearchResponse!
                                                                          .data![
                                                                              index]
                                                                          .mobileNumber
                                                                          .toString()
                                                                      : ''
                                                                  : ''
                                                              : '',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      pickupPro.getCustomerSearchResponse !=
                                                              null
                                                          ? pickupPro.getCustomerSearchResponse!
                                                                      .data! !=
                                                                  []
                                                              ? pickupPro
                                                                          .getCustomerSearchResponse!
                                                                          .data![
                                                                              index]
                                                                          .address !=
                                                                      null
                                                                  ? pickupPro
                                                                      .getCustomerSearchResponse!
                                                                      .data![
                                                                          index]
                                                                      .address
                                                                      .toString()
                                                                  : 'No address Found'
                                                              : 'No address Found'
                                                          : 'No address Found',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Text('Search by Name, Address or mobile No'),
                        )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                      authPro.isDriver = false;
                      Get.to(SignupScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    });
  }
}
