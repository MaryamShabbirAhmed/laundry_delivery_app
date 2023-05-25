import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/utils/widgets/buttonCustom.dart';

import '../utils/colors.dart';

class MyProfieScreen extends StatefulWidget {
  const MyProfieScreen({Key? key}) : super(key: key);

  @override
  State<MyProfieScreen> createState() => _MyProfieScreenState();
}

class _MyProfieScreenState extends State<MyProfieScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 153,
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
                  padding: EdgeInsets.only(top: 80.0),
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
                          'Vikas Kumar Ray',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'vikaskumar@gmail.com',
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
            Container(
              height: 4,
              width: Get.width,
              color: greyLightColor,
            ),
            
            ProfileTile(icon: Icons.person_outline, title: 'EMIRATES ID NO.', info: '#1980989',isEdit:false ),
            Padding(
              padding:  EdgeInsets.only(left:15.0, right:15),
              child: Container(height: 1,color: borderGreyColor,),
            ),
            ProfileTile(icon: Icons.phone_android, title: 'MOBILE NUMBER', info: '9876543210' ),
            Padding(
              padding:  EdgeInsets.only(left:15.0, right:15),
              child: Container(height: 1,color: borderGreyColor,),
            ),
            ProfileTile(icon: Icons.calendar_today, title: 'DATE OF BIRTH', info: '19-01-1976' ),
            Padding(
              padding:  EdgeInsets.only(left:15.0, right:15),
              child: Container(height: 1,color: borderGreyColor,),
            ),
            ProfileTile(icon: Icons.lock_outline, title: 'CURRENT PASSWORD', info: '**********' ),
            Padding(
              padding:  EdgeInsets.only(left:15.0, right:15),
              child: Container(height:1, color: borderGreyColor,),
            ),
            ProfileTile(icon: Icons.lock_outline, title: 'NEW PASSWORD', info: '**********' ),
            Padding(
              padding:  EdgeInsets.only(left:15.0, right:15),
              child: Container(height:1,color: borderGreyColor,),
            ),
            ProfileTile(icon: Icons.lock_outline, title: 'CONFIRM PASSWORD', info: '**********' ),

            CustomButton(label: 'UPDATE'),
          ],
        ),
      ),
    ));
  }
}
class ProfileTile extends StatelessWidget {
  IconData icon;

  String title;

  String info;

  bool isEdit;


   ProfileTile({Key? key, required this.icon, required this.title, required this.info, this.isEdit=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                        padding: const EdgeInsets.only(left:20.0),
                        child: Text(title, style: TextStyle(fontSize:12,color: darkGreyColor),),
                      ),
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left:45.0),
                    child: Text(info,style: TextStyle(fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
            ),
            if(isEdit)
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit,
                      size: 18, color: primaryColor)),
            )
          ],
        ));
  }
}
