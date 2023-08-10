import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/providers/pickupProvider.dart';
import 'package:laundry_delivery/utils/widgets/buttonCustom.dart';
import 'package:provider/provider.dart';

import '../../itemsDialogueBox.dart';

class PickupItemSelectionScreen extends StatefulWidget {
  PickupItemSelectionScreen({Key? key}) : super(key: key);

  @override
  State<PickupItemSelectionScreen> createState() =>
      _PickupItemSelectionScreenState();
}

class _PickupItemSelectionScreenState extends State<PickupItemSelectionScreen> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<PickupProvider>(
      builder: (context, pickupPro, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            bottomNavigationBar: Row(
              children: [
                Container(
                    width: Get.width / 1.2,
                    child: CustomButton(
                      label: 'Submit',
                      onPressed: () {
                        // _showBottomSheet(context);

                      },
                    )),
                InkWell(
                  onTap: (){
                    _showBottomSheet(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.arrow_upward_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  pickupPro.getAllItemsResponse != null ?
                  Container(
                    height: 280,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of columns in the grid
                          mainAxisSpacing: 6.0, // Spacing between rows
                          crossAxisSpacing: 6.0, // Spacing between columns
                        ),
                        itemCount: pickupPro.getAllItemsResponse!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.white,
                            child: Stack(
                              children: [
                                InkWell(
                                    onTap: () {
                                      // itemQuantity[index] = itemQuantity[index] + 1;
                                      // itemsNameSelected.add(itemsName[index]);
                                      // print(itemQuantity[index].toString());
                                      // setState(() {});
                                      // Get.to(DialogBoxRating(items:pickupPro.getAllItemsResponse!.data![index]));

                                    },
                                    child: Center(
                                        child: Image.network(pickupPro.getAllItemsResponse!.data![index].icon.toString()))),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    pickupPro.getAllItemsResponse!.data![index].name.toString(),
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                if (itemQuantity[index] > 0)
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: Container(
                                            width: 45,
                                            height: 22,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Align(
                                                child: Text(
                                              itemQuantity[index].toString(),
                                              style: TextStyle(color: Colors.white),
                                            )),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (itemQuantity[index] > 0) {
                                              itemQuantity[index] =
                                                  itemQuantity[index] - 1;
                                              setState(() {});
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Container(
                                              width: 45,
                                              height: 22,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: Align(
                                                  child: Text(
                                                '-',
                                                style:
                                                    TextStyle(color: Colors.blue),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }, // Number of items in your grid,
                      ),
                    ),
                  )
                      :
                      Container(),
                  // Container(
                  //   height: 500,
                  //   child: ListView.builder(
                  //     itemCount: itemsNameSelected.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return ListTile(
                  //         title: Text(itemsNameSelected[index]),
                  //         subtitle: Text('Subtitle for Item $index'),
                  //         leading: Icon(Icons.circle),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  List<String> itemsName = [
    'Large Flat Rate Bag',
    'Laundry',
    'Towels',
    'Bags',
    'Bedding',
  ];
  List<String> itemsNameSelected = [];
  List<String> itemsimage = [
    'https://dafgr1y3h3vlw.cloudfront.net/ic/b/9.png',
    'https://dafgr1y3h3vlw.cloudfront.net/ic/b/113.png',
    'https://dafgr1y3h3vlw.cloudfront.net/ic/b/109.png',
    'https://dafgr1y3h3vlw.cloudfront.net/ic/b/7.png',
    'https://dafgr1y3h3vlw.cloudfront.net/ic/b/116.png',
  ];
  List<int> itemQuantity = [0, 0, 0, 0, 0, 0];

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: Get.height, // Adjust the height as needed
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Payement',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.dangerous_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: DropdownButton<String>(
                      hint: Text('Select Payment Method'),
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue;
                          print(selectedValue);
                        });
                      },
                      items: <String>['Pay by Cash', 'Pay by Card']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SubTotal',
                      style: TextStyle(),
                    ),
                    Text(
                      'PKR 20.20',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Fee',
                      style: TextStyle(),
                    ),
                    Text(
                      'PKR 20.20',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey,
                width: Get.width,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(),
                    ),
                    Text(
                      'PKR 40.40',
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text('BottomSheet Content'),
          //     ElevatedButton(
          //       onPressed: () {
          //         // Perform an action when the button is tapped
          //       },
          //       child: Text('Button'),
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
