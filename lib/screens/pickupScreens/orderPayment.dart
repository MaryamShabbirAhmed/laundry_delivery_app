import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/providers/pickupProvider.dart';
import 'package:laundry_delivery/utils/providerVeriables.dart';
import 'package:laundry_delivery/utils/widgets/inputFieldCustom.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/buttonCustom.dart';
import '../scannerScreen.dart';

class PaymentDropdown extends StatefulWidget {
  @override
  _PaymentDropdownState createState() => _PaymentDropdownState();
}

class _PaymentDropdownState extends State<PaymentDropdown> {
  var list = ['Cash', 'Credit Card', 'Online Mode'];
int selected=-1;
  @override
  Widget build(BuildContext context) {
    return Consumer<PickupProvider>(builder: (context, pick, child) {
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
                  size: 15,
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // InputFieldCustom(
                //   borderColor: secondaryColor,
                //   label: 'Enter Reference No:',
                //   controller: pickupPro.referenceNoController,
                //   suffix: IconButton(
                //     icon: const Icon(
                //       Icons.qr_code_scanner,
                //     ),
                //     onPressed: () {
                //       pickupPro.isCreate = true;
                //       Get.to(const ScannerScreen());
                //     },
                //   ),
                // ),
                InputFieldCustom(
                  label: 'Enter Collected Amount',
                  borderColor: secondaryColor,
                  controller: pickupPro.collectedAmountController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select Payment Module',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  child: Column(
                    children: List.generate(list.length, (index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  selected=index;
                                  pickupPro.selectedMethod = list[index];
                                });
                              },
                              child: Container(
                                width: Get.width*0.9,
                                decoration: BoxDecoration(
                                  color: index==selected?Colors.blue:Colors.transparent,
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                                  child: Text(list[index],style: TextStyle(
                                    color: selected==index?Colors.white:Colors.black
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                CustomButton(
                  label: 'Book Order',
                  onPressed: () async {
                    bool trueData = await pickupPro.checkValidationForbooking();
                    if (trueData) {}
                  },
                ),
              ],
            )),
      );
    });
  }
}
