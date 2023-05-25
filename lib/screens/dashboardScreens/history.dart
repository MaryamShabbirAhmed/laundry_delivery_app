import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/statusWidget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        leadingWidth: 180,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Row(
            children: [
              Icon(Icons.arrow_back_ios, color: primaryColor, size: 15),
              Text(
                'Customer History',
                style: TextStyle(
                    fontSize: 15,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    height: 30,
                    width: Get.width / 1.5,
                    child: Center(
                      child: SearchBar(
                        leading: Image.asset(
                          'assets/dashboard_images/search.png',
                          color: darkGreyColor,
                        ),
                        hintText: 'search customer or mobile no',
                        hintStyle: MaterialStateProperty.resolveWith((states) {
                          return TextStyle(color: darkGreyColor, fontSize: 13);
                        }),
                        shape: MaterialStateProperty.resolveWith((states) {
                          return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5));
                        }),
                        shadowColor: MaterialStateProperty.resolveWith(
                          (state) {
                            return Colors.transparent;
                          },
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          return Color(0x59FFFFFF);
                        }),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Color(0x59FFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/dashboard_images/search.png',
                      color: darkGreyColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            listViewTile[0],
            listViewTile[1],
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  List<ListviewTile> listViewTile = [
    ListviewTile(status: 'Pending', backgroundColor: orangeLightColor),
    ListviewTile(status: 'Paid', backgroundColor: greenColor),
    ListviewTile(status: 'Paid', backgroundColor: greenColor),
  ];
}

class ListViewInfoWidget extends StatelessWidget {
  String? title;

  String? info;

  ListViewInfoWidget({Key? key, this.title, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 25),
                children: <TextSpan>[
                  TextSpan(
                      text: title,
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: info,
                      style: TextStyle(color: darkGreyColor, fontSize: 25)),
                ],
              ),
              textScaleFactor: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class ListviewTile extends StatelessWidget {
  String status;
  Color backgroundColor;

  ListviewTile({Key? key, required this.status, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Color(0xffDDDDDD),
                blurRadius: 3,
                spreadRadius: 1.1,
                offset: Offset(0.0, 0.0),
              )
            ]),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: StatusWidget(
                  status: status, backgroundColor: backgroundColor),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                ListViewInfoWidget(title: 'Order No', info: '10'),
                ListViewInfoWidget(title: 'Name: ', info: 'Vikas Kumar Ray'),
                ListViewInfoWidget(title: 'Contact No: ', info: '987654321'),
                ListViewInfoWidget(
                    title: 'Address No: ',
                    info:
                        'OvalEdge India Private Limited Manjeera Trinity Corporate, #321KPBH, Phase 3, Hyderabad -500072'),
                ListViewInfoWidget(title: 'No of cloths: ', info: '05'),
                ListViewInfoWidget(title: 'Payment: ', info: '500 rs'),
                ListViewInfoWidget(title: 'Payment type: ', info: 'cash'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
