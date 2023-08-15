import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/providers/historyDataProvider.dart';
import 'package:laundry_delivery/utils/providerVeriables.dart';
import 'package:provider/provider.dart';
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
  DateTime datenow= DateTime.now();
  String daysAgo=' Days Ago';
void initState(){

  historyPro.getOrderHistory();


  super.initState();

}
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, histryPro,child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Customer History', style: TextStyle(color: whiteColor),),
            backgroundColor: secondaryColor,
            // leading: IconButton(
            //   onPressed: () {
            //     Get.back();
            //   },
            //   icon:  Icon(Icons.arrow_back_ios, color: whiteColor, size: 15),
            // ),
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
                            historyType = historyTypeList[index];
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
                histryPro.getAllOrdersByIdResponse!=null
                ?Container(
                  height: Get.height,
                  child: ListView.builder(
                      itemCount: histryPro.getAllOrdersByIdResponse!.data!.length,
                      itemBuilder: (builder, index) {
                        if(histryPro.getAllOrdersByIdResponse!.data![index].status=='pending')
                        {
                          historyColor=orangeLightColor;
                        }
                        else if(histryPro.getAllOrdersByIdResponse!.data![index].status=='rejected')
                        {
                          historyColor=redColor;
                        }
                        else if(histryPro.getAllOrdersByIdResponse!.data![index].status=='on the way')
                        {
                          historyColor=yellowColor;
                        }
                        else if(histryPro.getAllOrdersByIdResponse!.data![index].status=='delivered')
                        {
                          historyColor=greenishColor;
                        }
                        else if(histryPro.getAllOrdersByIdResponse!.data![index].status=='picked from shop')
                        {
                          historyColor=orangeLightColor;
                        }
                        return
                          historyType == 'Order History'
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
                                            status: histryPro.getAllOrdersByIdResponse!.data![index].status.toString(),

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
                                              info:  histryPro.getAllOrdersByIdResponse!.data![index].id.toString()),
                                          ListViewInfoWidget(
                                              title: 'Total Payment: ',
                                              info:  histryPro.getAllOrdersByIdResponse!.data![index].totalPrice.toString()),

                                          ListViewInfoWidget(
                                              title: 'Selected Payment Type: ',
                                              info: historyPro.getAllOrdersByIdResponse!.data![index].selectedPaymentType),
                                          ListViewInfoWidget(
                                              title: 'Pickup Address : ',
                                              info: histryPro.getAllOrdersByIdResponse!.data![index].pickUpAddress.toString()),
                                          ListViewInfoWidget(
                                              title: 'No of cloths: ',
                                              info: histryPro.getAllOrdersByIdResponse!.data![index].orderDetails!.length.toString()),
                                          ListViewInfoWidget(
                                              title: 'Payment: ',
                                              info: histryPro.getAllOrdersByIdResponse!.data![index].paymentStatus.toString()),
                                          ListViewInfoWidget(
                                              title: 'time: ',
                                              info:"${DateTime.now().difference( histryPro.getAllOrdersByIdResponse!.data![index].createdAt!).inDays.toString()}  Day(s) Ago",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )

///
                            : historyType == histryPro.getAllOrdersByIdResponse!.data![index].status.toString()
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
                                                status: histryPro.getAllOrdersByIdResponse!.data![index].status.toString(),
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
                                                  info:  histryPro.getAllOrdersByIdResponse!.data![index].id.toString()),
                                              ListViewInfoWidget(
                                                  title: 'Name: ',
                                                  info: 'customer name'),
                                              ListViewInfoWidget(
                                                  title: 'Contact No: ',
                                                  info: listHistoryTile[index]
                                                      ['ContactNo']),
                                              ListViewInfoWidget(
                                                  title: 'Pickup Address : ',
                                                  info: histryPro.getAllOrdersByIdResponse!.data![index].pickUpAddress.toString()),
                                              ListViewInfoWidget(
                                                  title: 'No of cloths: ',
                                                  info: histryPro.getAllOrdersByIdResponse!.data![index].orderDetails!.length.toString()),
                                              ListViewInfoWidget(
                                                  title: 'Payment: ',
                                                  info: histryPro.getAllOrdersByIdResponse!.data![index].paymentStatus.toString()),
                                              ListViewInfoWidget(
                                                title: 'time: ',
                                                info:"${DateTime.now().difference( histryPro.getAllOrdersByIdResponse!.data![index].createdAt!).inDays.toString()}  Day(s) Ago",
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox();
                      }),
                )
                :
                    Center(child: CircularProgressIndicator(color: secondaryColor,))
                ,
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
  void historyColors(){
if(historyType=='pending')
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
    'pending',
    'processing',
    'on the way',
    'picked from shop',
    'delivered',
    'rejected',
  ];
}

String historyType = 'Order History';
Color historyColor = orangeLightColor;
