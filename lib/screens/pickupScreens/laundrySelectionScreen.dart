import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/services/apiServices.dart';
import 'package:laundry_delivery/services/apiURL.dart';
import 'package:laundry_delivery/utils/colors.dart';
import 'package:laundry_delivery/utils/providerVeriables.dart';
import 'package:laundry_delivery/utils/widgets/buttonCustom.dart';
import 'package:provider/provider.dart';

import '../../providers/pickupProvider.dart';
import '../../responses/getAllItemsResponse.dart';
import 'package:http/http.dart' as http;

class LaundrySelectionScreen extends StatefulWidget {
  @override
  _LaundrySelectionScreenState createState() => _LaundrySelectionScreenState();
}

class _LaundrySelectionScreenState extends State<LaundrySelectionScreen> {
  late Future<GetAllItemsResponse> futureItems;

  @override
  void initState() {
    super.initState();
    futureItems = pickupPro.getAllItems();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: whiteColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: secondaryColor,
          title: Text(
            'Laundry Selection',
            style: TextStyle(
              color: whiteColor,
            ),
          ),
        ),
        body: FutureBuilder<GetAllItemsResponse>(
          future: futureItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data?.data == null) {
              return Center(child: Text('No data available'));
            } else {
              List<Datum> allLaundryItems = snapshot.data!.data!;

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ExpansionPanelList(
                        elevation: 1,
                        expandedHeaderPadding: EdgeInsets.all(0),
                        expansionCallback: (int index, bool isExpanded) {
                          final item = allLaundryItems[index];
                          Provider.of<PickupProvider>(context, listen: false)
                              .toggleItemSelection(item);
                        },
                        children:
                            allLaundryItems.map<ExpansionPanel>((Datum item) {
                          return ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: Text(item.name ?? ''),
                              );
                            },
                            body: Column(
                              children: [
                                // ListTile(
                                //   title: Text('Price per item: \$${item.pricePerItem ?? 0}'),
                                //   trailing: Row(
                                //     mainAxisSize: MainAxisSize.min,
                                //     children: [
                                //       IconButton(
                                //         icon: Icon(Icons.remove),
                                //         onPressed: () {
                                //           // Decrease quantity
                                //         },
                                //       ),
                                //       Text(item.quantity.toString()),
                                //       IconButton(
                                //         icon: Icon(Icons.add),
                                //         onPressed: () {
                                //           // Increase quantity
                                //         },
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: item.laundryItems?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final laundry = item.laundryItems![index];
                                    return ListTile(
                                      title: Text(laundry.name ?? ''),
                                      subtitle: Text(
                                          'Price: \$${laundry.pricePerItem ?? 0}'),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              if (laundry.quantity! > 0) {
                                                laundry.quantity =
                                                    laundry.quantity! - 1;
                                              }
                                             pickupPro.notifyListeners();
                                            },
                                          ),
                                          Text(laundry.quantity.toString()),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              laundry.quantity =
                                                  laundry.quantity! + 1;
                                              pickupPro.notifyListeners();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            isExpanded: Provider.of<PickupProvider>(context)
                                .selectedItems
                                .contains(item),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16.0),
                      CustomButton(
                        label: 'Book Order',
                        onPressed: () async {
                          await pickupPro.sendBookingOrder();
                        },
                      ),
                      Text('Total Price: \$${pickupPro.getTotalPrice()}')
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class LaundryItemWidget extends StatelessWidget {
  final Datum laundryItem;

  LaundryItemWidget({required this.laundryItem});

  @override
  Widget build(BuildContext context) {
    final laundrySelectionModel = Provider.of<PickupProvider>(context);

    return ListTile(
      title: Text('Price per item: \$${laundryItem.pricePerItem ?? 0}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              if (laundryItem.quantity! > 0) {
                laundrySelectionModel.toggleItemSelection(laundryItem);
                laundryItem.quantity = laundryItem.quantity! - 1;
              }
            },
          ),
          Text(laundryItem.quantity.toString()),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              laundrySelectionModel.toggleItemSelection(laundryItem);
              laundryItem.quantity = laundryItem.quantity! + 1;
            },
          ),
        ],
      ),
    );
  }
}

// class _LaundrySelectionScreenState extends State<LaundrySelectionScreen> {
//   // ... Previous code ...
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Laundry Selection'),
//       ),
//       body: FutureBuilder<GetAllItemsResponse>(
//         future: futureItems,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data?.data == null) {
//             return Center(child: Text('No data available'));
//           } else {
//             List<Datum> allLaundryItems = snapshot.data!.data!;
//
//             return SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     ExpansionPanelList(
//                       elevation: 1,
//                       expandedHeaderPadding: EdgeInsets.all(0),
//                       expansionCallback: (int index, bool isExpanded) {
//                         final item = allLaundryItems[index];
//                         Provider.of<PickupProvider>(context, listen: false)
//                             .toggleItemSelection(item);
//                       },
//                       children: allLaundryItems.map<ExpansionPanel>((Datum item) {
//                         return ExpansionPanel(
//                           headerBuilder: (BuildContext context, bool isExpanded) {
//                             return ListTile(
//                               title: Text(item.name ?? ''),
//                             );
//                           },
//                           body: Column(
//                             children: [
//                               ListTile(
//                                 title: Text('Price per item: \$${item.pricePerItem ?? 0}'),
//                                 trailing: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       icon: Icon(Icons.remove),
//                                       onPressed: () {
//                                         // Decrease quantity
//                                       },
//                                     ),
//                                     Text(item.quantity.toString()),
//                                     IconButton(
//                                       icon: Icon(Icons.add),
//                                       onPressed: () {
//                                         // Increase quantity
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: item.laundryItems?.length ?? 0,
//                                 itemBuilder: (context, index) {
//                                   final laundry = item.laundryItems![index];
//                                   return ListTile(
//                                     title: Text(laundry.name ?? ''),
//                                     subtitle: Text('Price: \$${laundry.pricePerItem ?? 0}'),
//                                     trailing: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         IconButton(
//                                           icon: Icon(Icons.remove),
//                                           onPressed: () {
//                                             // Decrease quantity
//                                           },
//                                         ),
//                                         Text(laundry.quantity.toString()),
//                                         IconButton(
//                                           icon: Icon(Icons.add),
//                                           onPressed: () {
//                                             // Increase quantity
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                           isExpanded: Provider.of<PickupProvider>(context)
//                               .selectedItems
//                               .contains(item),
//                         );
//                       }).toList(),
//                     ),
//                     SizedBox(height: 16.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         sendBookingOrder(context);
//                       },
//                       child: Text('Book Order'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// ... Remaining code ...
