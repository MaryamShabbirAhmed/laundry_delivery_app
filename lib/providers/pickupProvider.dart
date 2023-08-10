import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry_delivery/utils/widgets/snackbars.dart';

import '../responses/bookingResponse.dart';
import '../responses/getAllItemsResponse.dart';
import '../responses/userLoginResponse.dart';
import '../screens/pickupScreens/pickupCloth.dart';
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
  DateTime selectedDate = DateTime.now();
  TextEditingController emailController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();

  void disposePickup() {
    pickupLocationController.clear();
    pickupLocationController2.clear();
    pickupDeliveryTimeController.clear();
    pickupDeliveryDateController.clear();
    pickupContactController.clear();
    pickupCustomerNameController.clear();
    pickupPacketController.clear();
    pickupRemarksController.clear();
    selectedDate = DateTime.now();
  }

  Future<void> pickupInputValidation() async {
    if (pickupLocationController.text.isEmpty ||
        pickupDeliveryDateController.text.isEmpty ||
        pickupDeliveryTimeController.text.isEmpty ||
        pickupLocationController2.text.isEmpty ||
        pickupRemarksController.text.isEmpty ||
        pickupPacketController.text.isEmpty ||
        pickupCustomerNameController.text.isEmpty ||
        pickupContactController.text.isEmpty) {
      await errorSnackBar('error', 'fields are empty');
    } else {
      await successSnackBar('success', 'successfully submitted');
    }
  }

  UserLoginResponse? userLoginResponse;
  String? userID;
    void customerAvailableData(){
      pickupCustomerNameController.text=userLoginResponse!.data!.name.toString()??'';
      pickupContactController.text=userLoginResponse!.data!.mobileNumber.toString()??'';
      userID=userLoginResponse!.data!.id.toString()?? '';
    }
  Future<bool> searchCustomer() async {
    startProgress();
    Map<String, String> fields = {
      'mobileNumber': userPhoneNumberController.text
    };
    String response = await ApiServices.postMethod(fields, getUserByNumberURL);
    stopProgress();
    if (response.isEmpty) {
      return false;
    }
    userLoginResponse = userLoginResponseFromJson(response);

    customerAvailableData();
    Get.to(PickupClothScreen(
      userLoginResponse: userLoginResponse,
    ));
    notifyListeners();
    return true;
  }

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
      dateSelect.text =
          formattedTime; //set the value of text field.
    } else {
      print("Time is not selected");
    }
    notifyListeners();
  }

  ///
  GetAllItemsResponse getAllItemsResponse=GetAllItemsResponse();
    Future<bool> getAllItems() async {
       String response=await ApiServices.getMethod(getAllItemsURL);
       if(response.isEmpty)
         {
          return false;
         }
       getAllItemsResponse=getAllItemsResponseFromJson(response);
       AllItemsList=getAllItemsResponse.data!;
       notifyListeners();
       return true;
     }



  List<Datum> selectedItems = [];
  List<Datum> selectedItemsList = [];

  void toggleItemSelection(Datum item) {
  if (selectedItems.contains(item)) {
  selectedItems.remove(item);
  } else {
  selectedItems.add(item);
  }
  notifyListeners();
  }

  List<Datum> AllItemsList = [];

  int getTotalPrice() {
    selectedItemsList = [];
    int totalPrice = 0;
    for(Datum data in AllItemsList){
      for(final item in data.laundryItems??[]){
        if(item.quantity>0)
        {
          // logger.e("${item.pricePerItem} ${item.quantity} $totalPrice");
        selectedItemsList.add(item);
        }


        totalPrice += (int.parse(item.pricePerItem.toString()) ?? 0) * (int.parse(item.quantity.toString()) ?? 0);


      }
    }
    // notifyListeners();

    return totalPrice;
  }
///

Future<bool> checkValidationForbooking() async {
if( pickupBookingDateController.text.isEmpty
    ||  pickupBookingTimeController.text.isEmpty
    ||  pickupDeliveryDateController.text.isEmpty
    ||  pickupDeliveryTimeController.text.isEmpty
    ||  pickupLocationController.text.isEmpty
    || userID ==null
   || selectedItemsList==[]
)
    {
      errorSnackBar('Error', 'Something is missing');
      print(pickupBookingDateController.text);
      print(pickupBookingTimeController.text);
      print(pickupDeliveryDateController.text);
      print(pickupDeliveryTimeController.text);
      print(pickupLocationController.text);
      print(userID);
      print(pickupBookingDateController.text);
      print(selectedItemsList);
      return false;
    }

return await sendBookingOrder();
}


  ///
  Future<bool> sendBookingOrder() async {
    startProgress();
    getTotalPrice();

    // Construct the order data using the selected items and quantities
    dynamic bookingOrder = {
      "bookingDate": pickupBookingDateController.text,
      "bookingTime": pickupBookingTimeController.text,
      "deliveryDate": pickupDeliveryDateController.text,
      "deliveryTime": pickupDeliveryTimeController.text,
      "pickUpLatLng": "pickUpLatLng",
      "pickUpAddress": pickupLocationController.text+pickupLocationController2.text,
      "userId": userID??'',
      "totalPrice": getTotalPrice(),
      "createdBy": StorageCRUD.getUser().data!.id.toString(),
      "items": selectedItemsList
          .map((item) => {
        "pricePerItem": item.pricePerItem,
        "itemName": item.name,
        "laundryItemId": item.id,
        "quantity": item.quantity.toString(),
        "subPrice": ((item.pricePerItem ?? 0) * (item.quantity ?? 0)).toString(),
      })
          .toList(),
    };


    String response=await ApiServices.postMethod(bookingOrder, bookOrderURL);
    stopProgress();
    if(response.isEmpty)
      {
        return false;
      }
    successSnackBar('Done', boodOrderResponseFromJson(response).message.toString());

    disposePickup();
    return true;

  }
  
  
}
