import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_delivery/providers/authProvider.dart';
import 'package:laundry_delivery/screens/dashboardScreens/dashboard.dart';
import 'package:laundry_delivery/screens/userAuthScreens/LoginScreen.dart';
import 'package:provider/provider.dart';

import 'utils/widgets/snackbars.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin  {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  );
  @override
  void initState() {
    checkStates();
    super.initState();
  }

  checkStates() async {
    bool _user = await Provider.of<AuthProvider>(context, listen: false).checkUser();

    _controller.animateTo(1, curve: Curves.easeInCirc);

    await Future.delayed(Duration(milliseconds: 4000));
    if (!_user) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => DashboardScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    var h = Get.height / 812;
    var b = Get.width / 375;
    return Scaffold(
      body:
      ScaleTransition(
        alignment: Alignment.center,
        scale: _controller,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: b * 30),
            width: b * 350,
            // height: h * 300,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',


                ),

              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }
}