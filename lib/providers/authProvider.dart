import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/services/apiServices.dart';
import 'package:laundry_delivery/services/apiURL.dart';
import 'package:laundry_delivery/utils/widgets/snackbars.dart';

import '../responses/userLoginResponse.dart';
import '../utils/const/consts.dart';
import '../utils/userStorage.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repassword = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
bool isDriver=true;
  ///
  void disposeController() {
    emailController.clear();
    password.clear();
    repassword.clear();
    userNameController.clear();
    addressController.clear();
    userPhoneNumberController.clear();
  }

  ///
  bool checkUser() {

bool check=StorageCRUD.box.hasData(StorageKeys.userData);
  return check;
  }
  ///
  bool validateEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  ///
  InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      errorText: validateEmail(emailController.text) ? null : 'Invalid email',
    );
  }

  ///
  Future<bool> checkSignUpValidation() async {
    if (!validateEmail(emailController.text)) {
      errorSnackBar('Error!', 'Enter valid email..');
      return false;
    }

   if(isDriver){
     if (password.text.isEmpty || repassword.text.isEmpty) {
       errorSnackBar('Error!', 'Enter passwords..');
       return false;
     }
     if (password.text != repassword.text) {
       errorSnackBar('Error!', 'mismatch passwords..');
       return false;
     }
   }
    if (userNameController.text.isEmpty) {
      errorSnackBar('Error!', 'Enter Name..');
      return false;
    }
    if (addressController.text.isEmpty) {
      errorSnackBar('Error!', 'Enter Address..');
      return false;
    }
    if (emailController.text.isEmpty) {
      errorSnackBar('Error!', 'Enter Email..');
      return false;
    }
    if (userPhoneNumberController.text.isEmpty) {
      errorSnackBar('Error!', 'Enter Phone Number..');
      return false;
    }

    return await userSignup();
  }
  Future<bool> userSignup() async {
    startProgress();
    Map<String, String> fields = {
      'loginId': emailController.text,
      'name': userNameController.text,
      'mobileNumber': userPhoneNumberController.text,
      'address': addressController.text,
      'userType': isDriver?'Driver':'Customer',
      'password': password.text
    };

    String response = await ApiServices.postMethod(fields, signupURL);
    stopProgress();
    if (response.isEmpty) {
      return false;
    }
    userLoginResponse = userLoginResponseFromJson(response);
    if(isDriver)
      {    await StorageCRUD.saveUser(response);
      }

    disposeController();
    return true;
  }
  ///
  Future<bool> checkLoginValidation() async {
    if (!validateEmail(emailController.text)) {
      errorSnackBar('Error!', 'Enter valid email..');
      return false;
    }

    if (password.text.isEmpty) {
      errorSnackBar('Error!', 'Enter password..');
      return false;
    }

    if (emailController.text.isEmpty) {
      errorSnackBar('Error!', 'Enter Email..');
      return false;
    }


    return  await userLogin();
  }
///
  UserLoginResponse? userLoginResponse;
  Future<bool> userLogin() async {
     startProgress();
    Map<String, String> fields = {
      'loginId': emailController.text,
      'password': password.text
    };

    String response = await ApiServices.postMethod(fields, loginURL);
    stopProgress();
    if (response.isEmpty) {
      return false;
    }
    userLoginResponse = userLoginResponseFromJson(response);
    await StorageCRUD.saveUser(response);
    disposeController();
    return true;
  }
  ///

  Future userProfile()async{
     addressController.text=StorageCRUD.getUser().data!.address=='null'?'':StorageCRUD.getUser().data!.address.toString();
    userPhoneNumberController.text=StorageCRUD.getUser().data!.mobileNumber.toString();
    userNameController.text=StorageCRUD.getUser().data!.name.toString();
    emailController.text=StorageCRUD.getUser().data!.loginId.toString();
    // password.text=StorageCRUD.getUser().data!.pass.toString();


   }
  ///
  Future<bool> checkUpdateUserValidation() async {
    if (!validateEmail(emailController.text)) {
      errorSnackBar('Error!', 'Enter valid email..');
      return false;
    }

    if(isDriver){
      if (password.text.isEmpty || repassword.text.isEmpty) {
        errorSnackBar('Error!', 'Enter passwords..');
        return false;
      }
      if (password.text != repassword.text) {
        errorSnackBar('Error!', 'mismatch passwords..');
        return false;
      }
    }
    if (userNameController.text.isEmpty) {
      errorSnackBar('Error!', 'Enter Name..');
      return false;
    } if (addressController.text.isEmpty) {
      errorSnackBar('Error!', 'Enter EMIRATE NO..');
      return false;
    }
    if (emailController.text.isEmpty) {
      errorSnackBar('Error!', 'Enter Email..');
      return false;
    }
    if (userPhoneNumberController.text.isEmpty) {
      errorSnackBar('Error!', 'Enter Phone Number..');
      return false;
    }

    return await userSignup();
  }
  Future<bool> userUpdate() async {
    isDriver=true;
    startProgress();
    Map<String, String> fields = {
      'userId': StorageCRUD.getUser().data!.id.toString(),
      'name': userNameController.text,
      'mobileNumber': userPhoneNumberController.text,
      'address': addressController.text,

    };
    String response = await ApiServices.postMethod(fields, updateUserURL);
    stopProgress();
    if (response.isEmpty) {
      return false;
    }
    userLoginResponse = userLoginResponseFromJson(response);
    if(isDriver)
    {    await StorageCRUD.saveUser(response);
    }

Get.back();

   successSnackBar('Great!', 'Profile updated successfully');
    disposeController();
    return true;
  }

}
