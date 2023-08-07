import 'package:flutter/material.dart';
import 'package:laundry_delivery/utils/widgets/buttonCustom.dart';
import 'package:laundry_delivery/utils/widgets/snackbars.dart';

import '../../utils/widgets/inputFieldCustom.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _validateEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }
  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      errorText: _validateEmail(_emailController.text) ? null : 'Invalid email',
    );
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40,),
      Container(
          height: 150,
          child: Image.asset('assets/images/logo.png',)),
          SizedBox(height: 30,),
      InputFieldCustom(
        label: 'Enter Your Email',
        controller: _emailController,
        decoration: _buildInputDecoration('Enter your email'),
      ),
      InputFieldCustom(
        label: 'Enter Your Password',
        controller: password,



      ),
          AppTextFieldPassword(label: 'Enter Password',error: false,),
          CustomButton(label: 'Login'
          ,
          onPressed: (){
            if (_validateEmail(_emailController.text)) {

              successSnackBar('Great!', 'you are logged in successfully');








            } else {
             errorSnackBar('Error', 'Invalid Email Format');

            }
          },
          ),
        ],
      ),
    ));
  }
}
