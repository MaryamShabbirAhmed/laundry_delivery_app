// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:laundry_delivery/responses/getAllItemsResponse.dart';
// import 'package:provider/provider.dart';
//
//
// class DialogBoxRating extends StatefulWidget {
//   Datum? items;
//
//    DialogBoxRating({ Key? key, this.items}) : super(key: key);
//
//   @override
//   State<DialogBoxRating> createState() => _DialogBoxRatingState();
// }
//
// class _DialogBoxRatingState extends State<DialogBoxRating> {
//   @override
//   Widget build(BuildContext context) {
//
//     var b = Get.width / 375;
//     var h = Get.height / 812;
//     return Consumer(builder: (builder, data, child) {
//       return Dialog(
//         insetPadding: EdgeInsets.symmetric(horizontal: b * 15),
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(b * 4),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children:
//        [
//          Container(
//            height: 280,
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: GridView.builder(
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 3, // Number of columns in the grid
//                  mainAxisSpacing: 6.0, // Spacing between rows
//                  crossAxisSpacing: 6.0, // Spacing between columns
//                ),
//                itemCount: items.le,
//                itemBuilder: (BuildContext context, int index) {
//                  return Container(
//                    color: Colors.white,
//                    child: Stack(
//                      children: [
//                        InkWell(
//                            onTap: () {
//                              // itemQuantity[index] = itemQuantity[index] + 1;
//                              // itemsNameSelected.add(itemsName[index]);
//                              // print(itemQuantity[index].toString());
//                              // setState(() {});
//                              Get.to(DialogBoxRating(items:pickupPro.getAllItemsResponse!.data![index]));
//
//                            },
//                            child: Center(
//                                child: Image.network(pickupPro.getAllItemsResponse!.data![index].icon.toString()))),
//                        Padding(
//                          padding: const EdgeInsets.all(4.0),
//                          child: Text(
//                            pickupPro.getAllItemsResponse!.data![index].name.toString(),
//                            style: TextStyle(fontWeight: FontWeight.w500),
//                          ),
//                        ),
//                        if (itemQuantity[index] > 0)
//                          Align(
//                            alignment: Alignment.bottomCenter,
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: [
//                                Padding(
//                                  padding: EdgeInsets.all(3.0),
//                                  child: Container(
//                                    width: 45,
//                                    height: 22,
//                                    decoration: BoxDecoration(
//                                        color: Colors.blue,
//                                        borderRadius:
//                                        BorderRadius.circular(10)),
//                                    child: Align(
//                                        child: Text(
//                                          itemQuantity[index].toString(),
//                                          style: TextStyle(color: Colors.white),
//                                        )),
//                                  ),
//                                ),
//                                InkWell(
//                                  onTap: () {
//                                    if (itemQuantity[index] > 0) {
//                                      itemQuantity[index] =
//                                          itemQuantity[index] - 1;
//                                      setState(() {});
//                                    }
//                                  },
//                                  child: Padding(
//                                    padding: EdgeInsets.all(3.0),
//                                    child: Container(
//                                      width: 45,
//                                      height: 22,
//                                      decoration: BoxDecoration(
//                                          color: Colors.white,
//                                          borderRadius:
//                                          BorderRadius.circular(10)),
//                                      child: Align(
//                                          child: Text(
//                                            '-',
//                                            style:
//                                            TextStyle(color: Colors.blue),
//                                          )),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                      ],
//                    ),
//                  );
//                }, // Number of items in your grid,
//              ),
//            ),
//          ),
//             // Padding(
//             //   padding: EdgeInsets.fromLTRB(b * 30, h * 30, b * 30, h * 30),
//             //   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             //     Text(
//             //       "Select Item",
//             //       style: TextStyle(
//             //         fontSize: 24,
//             //         fontWeight: FontWeight.w700,
//             //         letterSpacing: 0.5,
//             //       ),
//             //     ),
//             //
//             //
//             //
//             //
//             //   ]),
//             // ),
//           ],
//         ),
//       );
//     });
//   }
// }