import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///
            Container(
              height: 170,
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: AssetImage('assets/images/profile.jpg')),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: Get.width / 1.8,
                              child: Center(
                                child: SearchBar(
                                  hintText: 'search customer or mobile no',
                                  hintStyle: MaterialStateProperty.resolveWith((states) {
                                    return TextStyle(color: borderGreyColor, fontSize: 13);
                                  }),
                                  shape: MaterialStateProperty.resolveWith((states) {
                                    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
                                  }),
// padding: MaterialStateProperty.resolveWith((states) {return EdgeInsets.only(bottom:0);}),
                                 trailing: [
                                    Image.asset('assets/dashboard_images/search.png'),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.add,
                                      color: primaryColor,
                                    ),
                                  )),
                            ),
                            Image.asset(
                                'assets/dashboard_images/notification.png'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Hello,',
                      style: TextStyle(color: whiteColor, fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Dreke Doyal,',
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),

            ///delivery ///pickup
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Get.width / 2.3,
                    decoration: BoxDecoration(
                      color: greyLightColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 5.0,
                        bottom: 5,
                      ),
                      child: Center(
                          child: Text(
                        'Delivery',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                    ),
                  ),
                  Container(
                    width: Get.width / 2.3,
                    decoration: BoxDecoration(
                      color: greyLightColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 5.0,
                        bottom: 5,
                      ),
                      child: Center(
                          child: Text(
                        'Pickup',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                    ),
                  ),
                ],
              ),
            ),

            ///dashboard
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 13),
              child: Text(
                'Dashboard',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),

            ///dashboard option box
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                dashboardCard(
                  backgroundColor: pinkColor,
                  title: 'Total Pickups',
                  icon: 'assets/dashboard_images/totalPickup.png',
                  number: '03',
                ),
                dashboardCard(
                  backgroundColor: blueShineColor,
                  title: 'Pending Pickups',
                  icon: 'assets/dashboard_images/pendingPickup.png',
                  number: '03',
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  dashboardCard(
                    backgroundColor: purpleColor,
                    title: 'Completed Pickups',
                    icon: 'assets/dashboard_images/completedickup.png',
                    number: '03',
                  ),
                  dashboardCard(
                    backgroundColor: orangeDarkColor,
                    title: 'Old Pending Pickups',
                    icon: 'assets/dashboard_images/oldPickup.png',
                    number: '02',
                  ),
                ],
              ),
            ),

            ///financials
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 13),
              child: Text(
                'Financials',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),

            ///financials box
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FinancialsCard(
                  backgroundColor: greenishLightColor,
                  title: 'Total cash in hands',
                  titleColor: greenishColor,
                  icon: 'assets/dashboard_images/financialMoney.png',
                  number: '5000',
                ),
                FinancialsCard(
                  backgroundColor: greenishLightColor,
                  title: 'Pending cash',
                  titleColor: greenishColor,
                  icon: 'assets/dashboard_images/pendingcash.png',
                  number: '2000',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FinancialsCard(
                  backgroundColor: yellowLightColor,
                  title: 'Pickup pending from store',
                  titleColor: orangeLightColor,
                  icon: 'assets/dashboard_images/storepending.png',
                  number: '10',
                ),
                FinancialsCard(
                  backgroundColor: blueLightColor,
                  title: 'Total deliveries today',
                  titleColor: blueDarkColor,
                  icon: 'assets/dashboard_images/totaldeliveries.png',
                  number: '20',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FinancialsCard(
                  backgroundColor: redLightColor,
                  title: 'Delivery pending in van',
                  titleColor: redColor,
                  icon: 'assets/dashboard_images/vanpending.png',
                  number: '5',
                ),
                FinancialsCard(
                  backgroundColor: greenLightColor,
                  title: 'Over due Deliveries ',
                  titleColor: greenColor,
                  icon: 'assets/dashboard_images/overdue.png',
                  number: '10',
                ),
              ],
            ),
          ],
        )),
      ),
    ));
  }
}

class dashboardCard extends StatelessWidget {
  String number;

  Color backgroundColor;

  String title;

  String icon;

  dashboardCard(
      {Key? key,
      required this.backgroundColor,
      required this.title,
      required this.icon,
      required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: Get.width / 2.3,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  number,
                  style: TextStyle(fontSize: 20, color: whiteColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(icon),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FinancialsCard extends StatelessWidget {
  String number;

  Color backgroundColor;
  Color titleColor;

  String title;

  String icon;

  FinancialsCard({
    Key? key,
    required this.backgroundColor,
    required this.title,
    required this.icon,
    required this.number,
    required this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height:84,
        width: Get.width / 2.3,
        height: 120,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    number,
                    style: TextStyle(
                        fontSize: 20,
                        color: blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(icon),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
