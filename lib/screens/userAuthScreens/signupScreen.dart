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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 150,
                  child: Image.asset(
                    'assets/images/logo.png',
                  )),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
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
                    contentPadding: EdgeInsets.symmetric(vertical: 13.0),
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
                label: 'Enter Your Name',
                controller: authPro.userNameController,
              ),
              InputFieldCustom(
                label: 'Enter Your Email',
                controller: authPro.emailController,
                decoration: authPro.buildInputDecoration('Enter your email'),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8),
                child: AppTextFieldPassword(
                  label: 'Enter Password',
                  error: false,
                  controller: authPro.password,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8),
                child: AppTextFieldPassword(
                  label: 'Re-Enter Password',
                  error: false,
                  controller: authPro.repassword,
                ),
              ),
              CustomButton(
                label: 'Sign Up',
                colorButton: greenishColor,
                onPressed: () async {
                  bool isValid = await authPro.checkSignUpValidation();
                  if (isValid) {
                    Get.offAll(DashboardScreen());
                    successSnackBar('Great!', 'you are Signed Up successfully');

                  }
                },
              ),
            ],
          ),
        ),
      ));
    });
  }
}
