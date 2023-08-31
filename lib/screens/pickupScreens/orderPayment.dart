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
  List<PaymentMethod> _paymentMethods = MethodData.methods;

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
                InputFieldCustom(
                  borderColor: secondaryColor,
                  label: 'Enter Reference No:',
                  controller: pickupPro.referenceNoController,
                  suffix: IconButton(
                    icon: Icon(
                      Icons.qr_code_scanner,
                    ),
                    onPressed: () {
                      pickupPro.isCreate = true;
                      Get.to(ScannerScreen());
                    },
                  ),
                ),
                InputFieldCustom(
                  label: 'Enter Collected Amount',
                  borderColor: secondaryColor,
                  controller: pickupPro.collectedAmountController,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select Payment Module',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: ExpansionPanelList(
                      elevation: 1,
                      expandedHeaderPadding: EdgeInsets.all(0),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _paymentMethods[index].isExpanded = !isExpanded;
                        });
                      },
                      children: _paymentMethods
                          .map<ExpansionPanel>((PaymentMethod method) {
                        return ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title:
                                  Text(pickupPro.selectedMethod ?? method.name),
                            );
                          },
                          body: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children:
                                  method.options.map<Widget>((String option) {
                                return ListTile(
                                  title: Text(option),
                                  onTap: () {
                                    setState(() {
                                      pickupPro.selectedMethod = option;

                                      method.isExpanded = false;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          isExpanded: method.isExpanded,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                CustomButton(
                  label: 'Book Order',
                  onPressed: () async {
                    bool trueData = await pickupPro.checkValidationForbooking();
                    if (trueData) {

                    }
                  },
                ),
              ],
            )),
      );
    });
  }
}

class PaymentMethod {
  final String name;
  final List<String> options;
  bool isExpanded;

  PaymentMethod({
    required this.name,
    required this.options,
    this.isExpanded = false,
  });
}

class MethodData {
  static List<PaymentMethod> methods = [
    PaymentMethod(
      name: 'Select Payment Mode',
      options: ['Cash', 'Credit Card', 'Online Mode'],
    ),
  ];
}
