import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/providers/pickupProvider.dart';
import 'package:laundry_delivery/utils/colors.dart';
import 'package:laundry_delivery/utils/providerVeriables.dart';
import 'package:laundry_delivery/utils/widgets/buttonCustom.dart';
import 'package:laundry_delivery/utils/widgets/inputFieldCustom.dart';
import 'package:provider/provider.dart';
import '../../utils/widgets/snackbars.dart';
import '../dashboardScreens/dashboard.dart';
class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PickupProvider>(builder: (context, pick, child) {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              // Get.to(DashboardScreen(index: 0,));

              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: whiteColor,
              size: 15,
            ),
          ),
          centerTitle: true,
          backgroundColor: secondaryColor,
          title: Text(
            'Order Details',
            style: TextStyle(
              color: whiteColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: pickupPro.data != null
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Created By: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16
                            ),
                          ),
                          Text('  ${pick.data!.createdBy ?? ''} ', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top:5,bottom:5),
                      child: Container(
                        color: secondaryColor,
                        height: 1,
                        width: Get.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Booking Date: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,fontSize: 16
                            ),
                          ),
                          Text(
                              '${pick.data!.bookingDate!.month.toString() + '-' + pick.data!.bookingDate!.day.toString() + '-' + pick.data!.bookingDate!.year.toString() ?? ''} ', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top:5,bottom:5),
                      child: Container(
                        color: secondaryColor,
                        height: 1,
                        width: Get.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Date: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,fontSize: 16
                            ),
                          ),
                          Text(
                              '${pick.data!.deliveryDate!.month.toString() + '-'
                                  + pick.data!.deliveryDate!.day.toString() + '-'
                                  + pick.data!.deliveryDate!.year.toString() ?? ''} ', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top:5,bottom:5),
                      child: Container(
                        color: secondaryColor,
                        height: 1,
                        width: Get.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'total Price: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,fontSize: 16
                            ),
                          ),
                          Text('  ${pick.data!.totalPrice ?? ''} ', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top:5,bottom:5),
                      child: Container(
                        color: secondaryColor,
                        height: 1,
                        width: Get.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'payment Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,fontSize: 16
                                ),

                              ),
                              Icon(Icons.edit,size: 15,),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                openDialog('paymentStatus');
                              },
                              child: Text(
                                  ' ${pickupPro.paymentStatus != '' ?
                                  pickupPro.paymentStatus : pick.data!.paymentStatus ?? ''} ',
                                style: TextStyle(fontSize: 16),),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top:5,bottom:5),
                      child: Container(
                        color: secondaryColor,
                        height: 1,
                        width: Get.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Collected Payment: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,fontSize: 16
                                ),
                              ),
                              Icon(Icons.edit,size: 15,),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                // pickupPro.collectedAmountController.clear();
                                addAmountDialog();
                              },
                              child: Text(
                                  '  ${pickupPro.payment != '0' ?
                                  pickupPro.collectedAmountController.text :
                                  pick.data!.collectedPayment ?? ''} ', style: TextStyle(fontSize: 16),),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top:5,bottom:5),
                      child: Container(
                        color: secondaryColor,
                        height: 1,
                        width: Get.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'isPaid: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,fontSize: 16
                            ),
                          ),
                          Text(
                              '  ${pick.data!.isPaid! ? 'Paid' : 'Not Paid'} ', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top:5,bottom:5),
                      child: Container(
                        color: secondaryColor,
                        height: 1,
                        width: Get.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Selected Payment Type: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,fontSize: 16
                                ),
                              ),
                              Icon(Icons.edit,size: 15,),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                openDialog('paymentType');
                              },
                              child: Text(
                                  ' ${pickupPro.paymentType != '' ? pickupPro.paymentType :
                                  pick.data!.selectedPaymentType ?? ''} ', style: TextStyle(fontSize: 16),),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top:5,bottom:5),
                      child: Container(
                        color: secondaryColor,
                        height: 1,
                        width: Get.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Order Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,fontSize: 16
                                ),
                              ),
                              Icon(Icons.edit,size: 15,),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                openDialog('orderStatus');
                              },
                              child: Text(
                                  ' ${pickupPro.orderStatus != ''
                                      ? pickupPro.orderStatus : pick.data!.status ?? ''} ', style: TextStyle(fontSize: 16),),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top:5,bottom:5),
                      child: Container(
                        color: secondaryColor,
                        height: 1,
                        width: Get.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reference Id: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,fontSize: 16
                            ),
                          ),
                          Text('  ${pick.data!.referenceId ?? ''} ', style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8,top:5,bottom:5),
                      child: Container(
                        color: secondaryColor,
                        height: 1,
                        width: Get.width,
                      ),
                    ),
                    CustomButton(
                      label: 'Update Order',
                      onPressed: () {

                        pickupPro.updateOrder();


                      },
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: secondaryColor,
                  ),
                ),
        ),
      ));
    });
  }

  List<String> statusOptions = [
    "Pending",
    "Processing",
    "Picked from Shop",
    "On the Way",
    "Delivered",
    "Rejected",
  ];
  List<String> paymentStatusOptions = [
    "Pending",
    "cash paid",
    "due",
    "paid online",
  ];
  List<String> paymentTypeOptions = [
    "cash",
    "credit card",
    "online mode",
  ];

  void openDialog(String boxType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(boxType == 'orderStatus'
              ? "Change Order Status"
              : boxType == 'paymentStatus'
                  ? 'Change Payment Status'
                  : 'Change Payment Type'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ExpansionTile(
                  title: Text(boxType == 'orderStatus'
                      ? "Order Status"
                      : boxType == 'paymentStatus'
                          ? 'Payment Status'
                          : 'Payment Type'),
                  children: boxType == 'orderStatus'
                      ? statusOptions.map((option) {
                          return ListTile(
                            title: Text(option),
                            onTap: () {
                              setState(() {
                                pickupPro.orderStatus = option;
                                logger.i(pickupPro.orderStatus);
                              });
                              Navigator.pop(context);
                            },
                          );
                        }).toList()
                      : boxType == 'paymentStatus'
                          ? paymentStatusOptions.map((option) {
                              return ListTile(
                                title: Text(option),
                                onTap: () {
                                  setState(() {
                                    pickupPro.paymentStatus = option;
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }).toList()
                          : paymentTypeOptions.map((option) {
                              return ListTile(
                                title: Text(option),
                                onTap: () {
                                  setState(() {
                                    pickupPro.paymentType = option;
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void addAmountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Collected Amount'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputFieldCustom(
                  label: 'Add Amount',
                  borderColor: secondaryColor,
                  controller: pickupPro.collectedAmountController,
                  onChange: (value) {
                    pickupPro.payment = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Add Amount",
                      style: TextStyle(color: secondaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {});

                      pickupPro.collectedAmountController.clear();
                      pickupPro.payment = '';
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancle",
                      style: TextStyle(color: redColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
  void isPaidDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Collected Amount'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputFieldCustom(
                  label: 'Add Amount',
                  borderColor: secondaryColor,
                  controller: pickupPro.collectedAmountController,
                  onChange: (value) {
                    pickupPro.payment = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Add Amount",
                      style: TextStyle(color: secondaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {});

                      pickupPro.collectedAmountController.clear();
                      pickupPro.payment = '';
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancle",
                      style: TextStyle(color: redColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
