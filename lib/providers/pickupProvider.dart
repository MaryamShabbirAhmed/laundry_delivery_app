import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry_delivery/utils/widgets/snackbars.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../responses/bookingResponse.dart';
import '../responses/getAllItemsResponse.dart';
import '../responses/getOrderByRefIdResponse.dart';
import '../responses/updateResponse.dart';
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
  TextEditingController referenceNoController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController emailController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController collectedAmountController = TextEditingController();
  String? selectedMethod;
  List<Datum> selectedItems = [];
  List<Datum> selectedItemsList = [];
  UserLoginResponse? userLoginResponse;
  String? userID;
  GetAllItemsResponse getAllItemsResponse=GetAllItemsResponse();
  List<Datum> AllItemsList = [];
  BarcodeCapture? barcode;
  bool isCreate=false;
  bool  isGet=true;

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
    collectedAmountController.text='0';
    selectedDate = DateTime.now();
    selectedMethod=null;
  }
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
  void toggleItemSelection(Datum item) {
  if (selectedItems.contains(item)) {
  selectedItems.remove(item);
  } else {
  selectedItems.add(item);
  }
  notifyListeners();
  }
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
    ||  referenceNoController.text.isEmpty
    ||  pickupLocationController.text.isEmpty
    || userID ==null
|| collectedAmountController.text.isEmpty
|| selectedMethod==null
   || selectedItemsList==[]
)
    {
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
      "referenceId": referenceNoController.text,
      "pickUpLatLng": "pickUpLatLng",
      "pickUpAddress": pickupLocationController.text+pickupLocationController2.text,
      "collectedPayment":collectedAmountController.text,
      "selectedPaymentType":selectedMethod,
      "userId": userID.toString()??'',
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

boodOrderResponse=boodOrderResponseFromJson(response);
logger.i(boodOrderResponse);
    await successSnackBar('Done', 'Order Created');
    disposePickup();

    return true;

  }

  GetOrderByRefIdResponse? getOrderByRefIdResponse;
  OrderData? data;
  String? refCode;
Future<bool> getOrderByRefId({String? displayValue})async{
refCode=displayValue;

    String response=await ApiServices.getMethod(getOrderByRefIdURL+'?referenceId=${displayValue}');

    if(response.isEmpty)
      {
        return false;
      }
    getOrderByRefIdResponse=getOrderByRefIdResponseFromJson(response);

    logger.i(getOrderByRefIdResponse!.data.toString());


if(getOrderByRefIdResponse!.data==null)
  {
    errorSnackBar('Error', 'No Data Found!');
    return false;
  }
    data= getOrderByRefIdResponse!.data;
notifyListeners();
    return true;
}
///



  String orderStatus = "";
  String paymentStatus = "";
  String paymentType = "";
  String payment = "0";



  UpdateOrderResponse? updateOrderResponse;
Future<bool> updateOrder()async{
  startProgress();
  bool isPaid=false;
  logger.i(data!.collectedPayment);
  if(int.parse(data!.collectedPayment.toString())!=0 )
    {
      if(int.parse(data!.collectedPayment.toString())>int.parse(payment) &&int.parse(payment)!=0)
        {
          errorSnackBar('Error', 'Amount is less than previous');
          return false;
        }

    }
  if(int.parse(data!.totalPrice.toString())<=int.parse(payment) && data!.isPaid!=true)
    {
      isPaid=true;
    }
if(orderStatus=='Delivered')
  {
    if(!isPaid && data!.isPaid!=false)
      {
        errorSnackBar('Error', 'Payment is not collected ');
        return false;
      }
  }

  Map<String,dynamic> body={
    "id":data!.id.toString(),
    "status":orderStatus,
    "isPaid":isPaid,
    "paymentStatus":paymentStatus,
    "collectedPayment":payment,
    "selectedPaymentType":paymentType,
    "userId":data!.userId.toString()

  };
  String response = await ApiServices.postMethod(body,updateOrderUrl);
stopProgress();
successSnackBar('Great!', 'Order Updated');
  if(response.isEmpty)
  {
    return false;
  }
  updateOrderResponse=updateOrderResponseFromJson(response);
  logger.e(refCode);
await getOrderByRefId(displayValue: refCode);


return true;
}
















}
