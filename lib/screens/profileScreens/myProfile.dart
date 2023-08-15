import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:laundry_delivery/providers/pickupProvider.dart';
import 'package:laundry_delivery/screens/userAuthScreens/LoginScreen.dart';
import 'package:laundry_delivery/utils/const/consts.dart';
import 'package:laundry_delivery/utils/providerVeriables.dart';
import 'package:laundry_delivery/utils/widgets/buttonCustom.dart';
import 'package:laundry_delivery/utils/widgets/inputFieldCustom.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/userStorage.dart';

class MyProfieScreen extends StatefulWidget {
  const MyProfieScreen({Key? key}) : super(key: key);

  @override
  State<MyProfieScreen> createState() => _MyProfieScreenState();
}

class _MyProfieScreenState extends State<MyProfieScreen> {
  @override
  void initState() {
    super.initState();
    StorageCRUD.getUser();
    authPro.userProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {

                StorageCRUD.erase();
              authPro.disposeController();
                Get.offAll(LoginScreen());
              },
              icon: Icon(Icons.logout))
        ],
        shadowColor: Colors.transparent,
        backgroundColor: secondaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 123,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/backgroundProfilePage.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: whiteColor, width: 2),
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/profile.jpg',
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'EDIT',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit,
                                    size: 18, color: primaryColor))
                          ],
                        ),
                        Text(
                          StorageCRUD.getUser().data!.name.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          StorageCRUD.getUser().data!.loginId.toString(),
                          style: TextStyle(fontSize: 15, color: darkGreyColor),
                        ),
                        RatingBar(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          ratingWidget: RatingWidget(
                            full: Icon(
                              Icons.star,
                              color: primaryColor,
                            ),
                            half: Icon(
                              Icons.star_border,
                              color: primaryColor,
                            ),
                            empty: Icon(
                              Icons.star_border,
                              color: primaryColor,
                            ),
                          ),
                          itemSize: 20,
                          unratedColor: primaryColor,
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 4,
                  width: Get.width,
                  color: greyLightColor,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,top:10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_android,
                            color: primaryColor,
                            size: 17,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'MOBILE No',
                              style: TextStyle(fontSize: 12, color: darkGreyColor),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left:8.0,right:8),
                      child: IntlPhoneField(
                          flagsButtonPadding:EdgeInsets.only(top:20),
                        decoration: InputDecoration(

                          suffix: IconButton(onPressed: () {  }, icon: Padding(
                            padding: const EdgeInsets.only(right:10.0,top:15),
                            child: Icon(Icons.edit, size: 18,color: secondaryColor,),
                          ),),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent,width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          // labelText: 'Phone Number',
                          contentPadding: EdgeInsets.symmetric(vertical: 13.0),
                        ),
                        initialCountryCode: 'US', // Initial country code
                        initialValue: authPro.userPhoneNumberController.text,

                        onChanged: (phone) {
                          if (phone.isValidNumber()) {
                            authPro.userPhoneNumberController.text =
                                phone.completeNumber;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15),
                  child: Container(
                    height: 1,
                    color: borderGreyColor,
                  ),
                ),
                ProfileTile(
                  icon: Icons.person_outline,
                  title: 'EMIRATES ID NO.',
                  controller: authPro.emirateNoController,
                  // readOnly: true,
                ),

                // ProfileTile(
                //   icon: Icons.phone_android,
                //   title: 'MOBILE NUMBER',
                //   controller: authPro.userPhoneNumberController,
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15),
                  child: Container(
                    height: 1,
                    color: borderGreyColor,
                  ),
                ),
                ProfileTile(
                  isCalender: true,
                  icon: Icons.calendar_today,
                  title: 'DATE OF BIRTH',
                  controller: authPro.dobController,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15),
                  child: Container(
                    height: 1,
                    color: borderGreyColor,
                  ),
                ),
                // ProfileTile(icon: Icons.lock_outline, title: 'CURRENT PASSWORD',
                //     controller: authPro.password,
                //
                //     info: '**********' ),
                // Padding(
                //   padding:  EdgeInsets.only(left:15.0, right:15),
                //   child: Container(height:1, color: borderGreyColor,),
                // ),
                // ProfileTile(icon: Icons.lock_outline, title: 'NEW PASSWORD', info: '**********' ),
                // Padding(
                //   padding:  EdgeInsets.only(left:15.0, right:15),
                //   child: Container(height:1,color: borderGreyColor,),
                // ),
                // ProfileTile(icon: Icons.lock_outline, title: 'CONFIRM PASSWORD', info: '**********' ),

                CustomButton(
                  label: 'UPDATE',
                  onPressed: () async {
                    await authPro.userUpdate();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class ProfileTile extends StatelessWidget {
  IconData icon;

  String title;

  bool? readOnly;

  bool isCalender;
  bool isEdit;

  TextEditingController? controller;

  ProfileTile(
      {Key? key,
      required this.icon,
      required this.title,
      this.readOnly,
      this.isCalender = false,
      this.isEdit = true,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: primaryColor,
                    size: 17,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 12, color: darkGreyColor),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                      flex: 8,
                      child: InputFieldCustom(
                        readOnly: readOnly,
                        borderColor: Colors.transparent,
                        suffix: isEdit
                            ? Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    onPressed: () async {
                                      if (isCalender) {
                                        await pickupPro.selectDate(context);
                                        authPro.dobController.text =
                                            "${pickupPro.selectedDate.toLocal()}"
                                                .split(' ')[0];
                                        authPro.notifyListeners();
                                      }
                                    },
                                    icon: Icon(Icons.edit,
                                        size: 18, color: primaryColor)),
                              )
                            : SizedBox(),
                        labelColor: darkGreyColor,
                        controller: controller,
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
