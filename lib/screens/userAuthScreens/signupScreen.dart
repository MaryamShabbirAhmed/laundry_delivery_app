import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:laundry_delivery/providers/authProvider.dart';
import 'package:laundry_delivery/screens/dashboardScreens/dashboard.dart';
import 'package:laundry_delivery/utils/widgets/buttonCustom.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../utils/providerVeriables.dart';
import '../../utils/widgets/inputFieldCustom.dart';
import '../../utils/widgets/snackbars.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authData, child) {
      return SafeArea(
          child: Scaffold(

            appBar:
            authPro.isDriver?
                AppBar(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  leading: Container(),
                )
                :
            AppBar(
              backgroundColor: secondaryColor,
              title: Text('Add new Customer', style: TextStyle(color: whiteColor),),
              centerTitle: true,
              leading: IconButton( onPressed: () {  Get.back();}, icon: Icon(Icons.arrow_back_ios, color: whiteColor,),),

            ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              authPro.isDriver ?
              Container(
                  height: 150,
                  child: Image.asset(
                    'assets/images/logo.png',
                  )):
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntlPhoneField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Phone Number',
                    contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
                  ),
                  initialCountryCode: 'US', // Initial country code
                  onChanged: (phone) {
                    if (phone.isValidNumber()) {
                      authPro.userPhoneNumberController.text =
                          phone.completeNumber;
                    }
                  },
                ),
              ),
              InputFieldCustom(
                borderColor: secondaryColor,
                label:  authPro.isDriver? 'Enter Your Name': 'Enter Customer Name',
                controller: authPro.userNameController,
              ),
              InputFieldCustom(
                borderColor: secondaryColor,
                label:  authPro.isDriver?'Enter Your Address':'Enter Customer Address',
                controller: authPro.addressController,
              ),
              InputFieldCustom(
                borderColor: secondaryColor,

                label:  authPro.isDriver?'Enter Your Email':'Enter Customer Email',
                controller: authPro.emailController,
                decoration: authPro.buildInputDecoration('Enter your email'),
              ),

              if(authPro.isDriver)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: AppTextFieldPassword(
                  label: 'Enter Password',
                  error: false,
                  controller: authPro.password,
                ),
              ),
              if(authPro.isDriver)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: AppTextFieldPassword(
                  label: 'Re-Enter Password',
                  error: false,
                  controller: authPro.repassword,
                ),
              ),
              CustomButton(
                label: authPro.isDriver?'Sign Up':'Add Customer',
                colorButton: greenishColor,
                onPressed: () async {
                  bool isValid = await authPro.checkSignUpValidation();
                  if (isValid) {
                    if(authData.isDriver) {
                      authData.isDriver=false;
                      Get.offAll(DashboardScreen());
                      successSnackBar(
                          'Great!', 'you are Signed Up successfully');
                    }
                    else
                      {
                        Get.back();
                        successSnackBar(
                            'Great!', 'Customer has been created!');
                      }
                  }
                },
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ));
    });
  }
}
