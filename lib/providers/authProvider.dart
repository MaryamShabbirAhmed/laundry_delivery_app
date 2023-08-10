import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  TextEditingController userPhoneNumberController = TextEditingController();
bool isDriver=true;
  ///
  void disposeController() {
    emailController.clear();
    password.clear();
    repassword.clear();
    userNameController.clear();
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
      'userType': isDriver?'Driver':'Customer',
      'password': password.text??''
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
  UserLoginResponse? userLoginResponse;
  Future<bool> userLogin() async {
     // startProgress();
    Map<String, String> fields = {
      'loginId': emailController.text,
      'password': password.text
    };

    String response = await ApiServices.postMethod(fields, loginURL);
    if (response.isEmpty) {
      return false;
    }
    userLoginResponse = userLoginResponseFromJson(response);
    await StorageCRUD.saveUser(response);
    disposeController();
    return true;
  }
}
