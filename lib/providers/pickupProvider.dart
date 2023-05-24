import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry_delivery/utils/widgets/snackbars.dart';

class PickupProvider extends ChangeNotifier{

  TextEditingController pickupCustomerNameController=TextEditingController();
  TextEditingController pickupLocationController2=TextEditingController();
  TextEditingController pickupLocationController=TextEditingController();
  TextEditingController pickupContactController=TextEditingController();
  TextEditingController pickupRemarksController=TextEditingController();
  TextEditingController pickupPacketController=TextEditingController();
  TextEditingController pickupDeliveryDateController=TextEditingController();
  TextEditingController pickupDeliveryTimeController=TextEditingController();
  DateTime selectedDate = DateTime.now();


  void disposePickup(){

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
    if(
    pickupLocationController.text.isEmpty ||
    pickupDeliveryDateController.text.isEmpty ||
    pickupDeliveryTimeController.text.isEmpty ||
    pickupLocationController2.text.isEmpty ||
    pickupRemarksController.text.isEmpty ||
    pickupPacketController.text.isEmpty ||
    pickupCustomerNameController.text.isEmpty ||
    pickupContactController.text.isEmpty

    ){
  await errorSnackBar('error', 'fields are empty');
    }
else
  {
   await successSnackBar('success','successfully submitted');
  }


}














  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {

        selectedDate = picked;
        pickupDeliveryDateController.text="${picked.toLocal()}".split(' ')[0];

    }
    notifyListeners();
  }
Future<void> getTime(var context) async {
  TimeOfDay? pickedTime =  await showTimePicker(
    initialTime: TimeOfDay.now(),
    context: context,
  );
  if(pickedTime != null ){
    print(pickedTime.format(context));
    DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());

    print(parsedTime);
    String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
    print(formattedTime);
   pickupDeliveryTimeController.text = formattedTime; //set the value of text field.

  }else{
    print("Time is not selected");
  }
  notifyListeners();

}

}
