import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/snackbars.dart';
import '../../utils/widgets/statusWidget.dart';
import 'historyTiles.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedIndex = 0;

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
                  height: 40,
                  width: 100,
                  color: Color(0x59FFFFFF),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/dashboard_images/search2.png',
                      color: darkGreyColor,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 55,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: historyTypeList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectedIndex = index;
                       if (index == 1) {
                          historyType = 'Pending';

                        } else if (index == 2) {
                          historyType = 'Due';

                        } else if (index == 3) {
                          historyType = 'process';

                        }
                        else
                          {
                            historyType = historyTypeList[index];

                          }

                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? primaryColor
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              historyTypeList[index],
                              style: TextStyle(
                                color: selectedIndex == index
                                    ? whiteColor
                                    : blackColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: Get.height,
              child: ListView.builder(
                  itemCount: listHistoryTile.length,
                  itemBuilder: (builder, index) {
                    if(listHistoryTile[index]['orderStatus']=='Pending')
                    {
                      historyColor=orangeLightColor;
                    }
                    else if(listHistoryTile[index]['orderStatus']=='Due')
                    {
                      historyColor=redColor;
                    }
                    else if(listHistoryTile[index]['orderStatus']=='process')
                    {
                      historyColor=yellowColor;
                    }
                    return historyType == 'Order History'
                        ? Padding(
                            padding: EdgeInsets.all(8.0),
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
                                        status: listHistoryTile[index]
                                            ['orderStatus'],
                                        backgroundColor: historyColor),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ListViewInfoWidget(
                                          title: 'Order No',
                                          info: listHistoryTile[index]
                                              ['orderNo']),
                                      ListViewInfoWidget(
                                          title: 'Name: ',
                                          info: listHistoryTile[index]['name']),
                                      ListViewInfoWidget(
                                          title: 'Contact No: ',
                                          info: listHistoryTile[index]
                                              ['ContactNo']),
                                      ListViewInfoWidget(
                                          title: 'Address No: ',
                                          info: listHistoryTile[index]
                                              ['addressNo']),
                                      ListViewInfoWidget(
                                          title: 'No of cloths: ',
                                          info: listHistoryTile[index]
                                              ['noOfCloths']),
                                      ListViewInfoWidget(
                                          title: 'Payment: ',
                                          info: listHistoryTile[index]
                                              ['payment']),
                                      ListViewInfoWidget(
                                          title: 'time: ',
                                          info: listHistoryTile[index]['time']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : historyType == listHistoryTile[index]['orderStatus']
                            ? Padding(
                                padding: EdgeInsets.all(8.0),
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
                                            status: listHistoryTile[index]
                                                ['orderStatus'],
                                            backgroundColor: historyColor),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ListViewInfoWidget(
                                              title: 'Order No',
                                              info: listHistoryTile[index]
                                                  ['orderNo']),
                                          ListViewInfoWidget(
                                              title: 'Name: ',
                                              info: listHistoryTile[index]
                                                  ['name']),
                                          ListViewInfoWidget(
                                              title: 'Contact No: ',
                                              info: listHistoryTile[index]
                                                  ['ContactNo']),
                                          ListViewInfoWidget(
                                              title: 'Address No: ',
                                              info: listHistoryTile[index]
                                                  ['addressNo']),
                                          ListViewInfoWidget(
                                              title: 'No of cloths: ',
                                              info: listHistoryTile[index]
                                                  ['noOfCloths']),
                                          ListViewInfoWidget(
                                              title: 'Payment: ',
                                              info: listHistoryTile[index]
                                                  ['payment']),
                                          ListViewInfoWidget(
                                              title: 'time: ',
                                              info: listHistoryTile[index]
                                                  ['time']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox();
                  }),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
  void historyColors(){
if(historyType=='Pending')
  {
    historyColor=orangeLightColor;
  }
else if(historyType=='Due')
{
  historyColor=orangeLightColor;
}
else if(historyType=='process')
{
  historyColor=orangeLightColor;
}
  }


  List<String> historyTypeList = [
    'Order History',
    // 'Payment History',
    'Pending Delivery',
    'Due Delivery',
    'Process at store',
  ];
}

String historyType = 'Order History';
Color historyColor = orangeLightColor;
