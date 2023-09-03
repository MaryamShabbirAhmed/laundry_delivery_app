import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/providers/authProvider.dart';
import 'package:laundry_delivery/screens/dashboardScreens/dashboard.dart';
import 'package:laundry_delivery/screens/userAuthScreens/signupScreen.dart';
import 'package:laundry_delivery/utils/colors.dart';
import 'package:laundry_delivery/utils/widgets/buttonCustom.dart';
import 'package:laundry_delivery/utils/widgets/snackbars.dart';
import 'package:provider/provider.dart';

import '../../utils/providerVeriables.dart';
import '../../utils/widgets/inputFieldCustom.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authData, child) {
      return SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
                height: 150,
                child: Image.asset(
                  'assets/images/logo.png',
                )),
            const SizedBox(
              height: 30,
            ),
            InputFieldCustom
              (
              borderColor: secondaryColor,
              label: 'Enter Your Email',
              controller: authPro.emailController,
              decoration: authPro.buildInputDecoration('Enter your email'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: AppTextFieldPassword(
                label: 'Enter Password',
                error: false,
                controller: authPro.password,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                      onTap: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )),
                ),
              ],
            ),
            CustomButton(

              label: 'Login',
              onPressed: () async {
                bool isValid = await authPro.checkLoginValidation();

                if (isValid) {

                  Get.to(DashboardScreen());
                  await successSnackBar(
                      'Great!', 'you are Signed In successfully');
                } else {

                }
              },
            ),
            CustomButton(
              label: 'Sign Up',
              colorButton: greenishColor,
              onPressed: () {
                Get.to(SignupScreen());
              },
            ),
          ],
        ),
      ));
    });
  }
}
