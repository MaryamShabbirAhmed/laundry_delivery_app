import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry_delivery/utils/widgets/snackbars.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../responses/bookingResponse.dart';
import '../responses/getAllItemsResponse.dart';
import '../responses/getCustomerSearchResponse.dart';
import '../responses/getOrderByRefIdResponse.dart';
import '../responses/getServiceAreasResponse.dart';
import '../responses/updateResponse.dart';
import '../responses/userLoginResponse.dart';
import '../services/apiServices.dart';
import '../services/apiURL.dart';
import '../utils/const/consts.dart';
import '../utils/userStorage.dart';

class PickupProvider extends ChangeNotifier {
  TextEditingController pickupCustomerNameController = TextEditingController();
  TextEditingController pickupLocationController2 = TextEditingController();
  TextEditingController pickupLocationController = TextEditingController();
  TextEditingController pickupContactController = TextEditingController();
  TextEditingController pickupRemarksController = TextEditingController();
  TextEditingController pickupPacketController = TextEditingController();
  TextEditingController pickupDeliveryDateController = TextEditingController();
  TextEditingController pickupBookingDateController = TextEditingController();
  TextEditingController pickupDeliveryTimeController = TextEditingController();
  TextEditingController pickupBookingTimeController = TextEditingController();
  TextEditingController referenceNoController = TextEditingController();
  TextEditingController searchByName = TextEditingController();
  TextEditingController searchByMobile = TextEditingController();
  TextEditingController searchByAddress = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController emailController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController collectedAmountController = TextEditingController();
  String? selectedMethod;
  List<Datum> selectedItems = [];
  List<Datum> selectedItemsList = [];
  UserLoginResponse? userLoginResponse;
  String? userID;
  GetAllItemsResponse getAllItemsResponse = GetAllItemsResponse();
  List<Datum> AllItemsList = [];
  BarcodeCapture? barcode;
  bool isCreate = false;
  bool isGet = true;

  void disposePickup() {
    pickupLocationController.clear();
    pickupLocationController2.clear();
    pickupDeliveryTimeController.clear();
    pickupBookingTimeController.clear();
    pickupDeliveryDateController.clear();
    pickupBookingDateController.clear();
    pickupContactController.clear();
    pickupCustomerNameController.clear();
    pickupPacketController.clear();
    pickupRemarksController.clear();
    referenceNoController.clear();
    collectedAmountController.text = '0';
    selectedDate = DateTime.now();
    selectedMethod = null;
  }

  void customerAvailableData() {
    // pickupCustomerNameController.text=getCustomerSearchResponse.data;
    // pickupContactController.text=userLoginResponse!.data!.mobileNumber.toString()??'';
    userID = userLoginResponse?.data?.id.toString() ?? '';
  }

  GetCustomerSearchResponse? getCustomerSearchResponse;

  Future<bool> searchCustomer() async {
    startProgress();

    Map<String, String> fields = {
      "userType": "customer",
      "page": "0",
      "limit": "1000"
    };

    if (searchByMobile.text.isNotEmpty) {
      fields['mobileNumber'] = searchByMobile.text;
    }
    if (searchByName.text.isNotEmpty) {
      fields['name'] = searchByName.text;
    }
    if (searchByAddress.text.isNotEmpty) {
      fields['address'] = searchByAddress.text;
    }

    String? response = await ApiServices.post(getUserBySearchURL, body: fields);
    stopProgress();
    if (response == null) {
      return false;
    }
    getCustomerSearchResponse = getCustomerSearchResponseFromJson(response);
    notifyListeners();
    return true;
  }

  GetServiceAreasResponse? getServiceAreasResponse;

  Future<bool> getServiceAreas() async {
    String response = await ApiServices.getMethod(getServiceAreasURL);
    if (response.isEmpty) {
      return false;
    }

    getServiceAreasResponse = getServiceAreasResponseFromJson(response);
    notifyListeners();
    return true;
  }

  ///
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      pickupDeliveryDateController.text = "${picked.toLocal()}".split(' ')[0];
    }
    notifyListeners();
  }

  ///
  Future<void> getTime(var context, TextEditingController dateSelect) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (pickedTime != null) {
      print(pickedTime.format(context));
      DateTime parsedTime =
          DateFormat.jm().parse(pickedTime.format(context).toString());

      print(parsedTime);
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
      print(formattedTime);
      dateSelect.text = formattedTime; //set the value of text field.
    } else {
      print("Time is not selected");
    }
    notifyListeners();
  }

  ///
  Future<bool> getAllItems() async {
    String response = await ApiServices.getMethod(getAllItemsURL);
    if (response.isEmpty) {
      return false;
    }
    getAllItemsResponse = getAllItemsResponseFromJson(response);
    AllItemsList = getAllItemsResponse.data!;
    notifyListeners();
    return true;
  }

  ///
  void toggleItemSelection(Datum item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    notifyListeners();
  }

  ///
  void toggleLocationSelection(String item) {
    notifyListeners();
  }

  ///
  int getTotalPrice() {
    selectedItemsList = [];
    int totalPrice = 0;
    for (Datum? data in AllItemsList) {
      for (final item in data?.laundryItems ?? []) {
        if (item.quantity > 0) {
          selectedItemsList.add(item);
        }

        totalPrice += (int.parse(item.pricePerItem.toString() ?? "0")) *
            (int.parse(item.quantity.toString()) ?? 0);
      }
    }
    // notifyListeners();

    return totalPrice;
  }

  ///
  Future<bool> checkValidationForbooking() async {
    if (pickupBookingDateController.text.isEmpty ||
        pickupBookingTimeController.text.isEmpty ||
        pickupDeliveryDateController.text.isEmpty ||
        pickupDeliveryTimeController.text.isEmpty ||
        // pickupLocationController.text.isEmpty ||
        userID == null ||
        collectedAmountController.text.isEmpty ||
        selectedMethod == null ||
        selectedItemsList == []) {
      errorSnackBar('Error', 'Something is missing');
      return false;
    }
    return await sendBookingOrder();
  }

  ///

  BoodOrderResponse? boodOrderResponse;

  Future<bool> sendBookingOrder() async {
    startProgress();
    getTotalPrice();
    dynamic bookingOrder = {
      "bookingDate": pickupBookingDateController.text,
      "bookingTime": pickupBookingTimeController.text,
      "deliveryDate": pickupDeliveryDateController.text,
      "deliveryTime": pickupDeliveryTimeController.text,
      "pickUpLatLng": "pickUpLatLng",
      "pickUpAddress": pickupLocationController.text,
      "collectedPayment": collectedAmountController.text,
      "selectedPaymentType": selectedMethod,
      "userId": userID.toString() ?? '',
      "totalPrice": getTotalPrice(),
      "createdBy": StorageCRUD.getUser().data!.id.toString(),
      "items": selectedItemsList
          .map((item) => {
                "pricePerItem": item.pricePerItem,
                "itemName": item.name,
                "laundryItemId": item.id,
                "quantity": item.quantity.toString(),
                "subPrice": ((item.pricePerItem ?? 0) * (item.quantity ?? 0))
                    .toString(),
              })
          .toList(),
    };

    String response = await ApiServices.postMethod(bookingOrder, bookOrderURL);

    stopProgress();
    Get.back();
    Get.back();
    Get.back();
    if (response.isEmpty) {
      return false;
    }

    boodOrderResponse = boodOrderResponseFromJson(response);
    logger.i(boodOrderResponse);
    await successSnackBar('Done', 'Order Created');
    disposePickup();

    return true;
  }

  GetOrderByRefIdResponse? getOrderByRefIdResponse;
  OrderData? orderData;
  String? refCode;

  Future<bool> getOrderByRefId({String? displayValue}) async {
    refCode = displayValue;

    String response = await ApiServices.getMethod(
        getOrderByRefIdURL + '?referenceId=${displayValue}');

    if (response.isEmpty) {
      return false;
    }
    getOrderByRefIdResponse = getOrderByRefIdResponseFromJson(response);

    logger.i(getOrderByRefIdResponse!.data.toString());

    if (getOrderByRefIdResponse!.data == null) {
      errorSnackBar('Error', 'No Data Found!');
      return false;
    }
    orderData = getOrderByRefIdResponse!.data![0];
    notifyListeners();
    return true;
  }

  ///

  String orderStatus = "";
  String paymentStatus = "";
  String paymentType = "";
  String payment = "0";

  UpdateOrderResponse? updateOrderResponse;

  Future<bool> updateOrder() async {
    startProgress();
    bool isPaid = false;
    logger.i(orderData!.isPaid);
    if (int.parse(orderData!.collectedPayment.toString()) != 0) {
      if (int.parse(orderData!.collectedPayment.toString()) > int.parse(payment) &&
          int.parse(payment) != 0) {
        errorSnackBar('Error', 'Amount is less than previous');
        stopProgress();
        return false;
      }
    }
    if (int.parse(orderData!.totalPrice.toString()) <= int.parse(payment) &&
        orderData!.isPaid != true) {
      isPaid = true;
    }
    if (orderStatus == 'Delivered') {
      if (!isPaid && orderData!.isPaid == false) {
        stopProgress();
        errorSnackBar('Error', 'Payment is not collected ');

        return false;
      }
    }

    Map<String, dynamic> body = {
      "id": orderData!.id.toString(),
      "status": orderStatus.toLowerCase(),
      "isPaid": isPaid,
      "paymentStatus": paymentStatus.toLowerCase(),
      "collectedPayment": payment,
      "selectedPaymentType": paymentType.toLowerCase(),
      "userId": orderData!.userId.toString()
    };
    print(body);
    String response = await ApiServices.postMethod(body, updateOrderUrl);
    stopProgress();
    successSnackBar('Great!', 'Order Updated');
    if (response.isEmpty) {
      return false;
    }
    updateOrderResponse = updateOrderResponseFromJson(response);

    if(refCode!=null) {
      await getOrderByRefId(displayValue: refCode);
    }

    return true;
  }
}
