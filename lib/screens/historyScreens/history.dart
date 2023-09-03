import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/providers/historyDataProvider.dart';
import 'package:laundry_delivery/screens/historyScreens/orderDetails.dart';
import 'package:laundry_delivery/utils/providerVeriables.dart';
import 'package:provider/provider.dart';
import '../../responses/getOrderByRefIdResponse.dart';
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
  DateTime datenow = DateTime.now();
  String daysAgo = ' Days Ago';

  @override
  void initState() {
    historyPro.getOrderHistory();
    super.initState();
  }

  List<String> historyTypeList = [
    'All Orders',
    'pending',
    'delivered',
    'rejected',
  ];
  String historyType = 'All Orders';

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Customer History',
            style: TextStyle(color: whiteColor),
          ),
          backgroundColor: secondaryColor,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                    height: 30,
                    width: Get.width / 1.5,
                    child: Center(
                      child: SearchBar(
                        leading: Image.asset(
                          'assets/dashboard_images/search.png',
                          color: darkGreyColor,
                        ),
                        hintText: 'search customer or mobile no',
                        hintStyle:
                        MaterialStateProperty.resolveWith((states) {
                          return TextStyle(
                              color: darkGreyColor, fontSize: 13);
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
                          return const Color(0x59FFFFFF);
                        }),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 100,
                  color: const Color(0x59FFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/dashboard_images/search2.png',
                      color: darkGreyColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: data.getAllOrdersByIdResponse?.data?.length ?? 0,
                  itemBuilder: (builder, index) {
                    OrderData? orderData = data.getAllOrdersByIdResponse
                        ?.data?[index];
                    if (orderData == null) {
                      return Container();
                    }
                    if (historyType == "All Orders") {
                      return orderItem(orderData);
                    }
                    if (historyType == orderData.status) {
                      return orderItem(orderData);
                    }
                    else {
                      return Container();
                    }
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    });
  }

  Widget orderItem(OrderData? order) {
    return InkWell(
      onTap: () {
        pickupPro.orderData = order;
        Get.to(const OrderDetails());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
              boxShadow: const [
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StatusWidget(
                      status: order?.status ??
                          "".toString(),
                      backgroundColor: order?.status == "pending"
                          ? Colors.blue
                          : order?.status == "delivered" ? Colors.green : order
                          ?.status == "rejected" ? Colors.red:Colors.blue,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  ListViewInfoWidget(
                      title: 'Order No',
                      info: order?.id
                          .toString()),
                  ListViewInfoWidget(title: 'Name: ', info: 'customer name'),
                  ListViewInfoWidget(
                      title: 'Pickup Address : ',
                      info: order?.pickUpAddress
                          .toString()),
                  ListViewInfoWidget(
                      title: 'No of cloths: ',
                      info: order?.orderDetails!.length
                          .toString()),
                  ListViewInfoWidget(
                      title: 'Payment: ',
                      info: order?.paymentStatus
                          .toString()),
                  ListViewInfoWidget(
                      title: 'time: ',
                      info: order?.createdAt.toString()
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
