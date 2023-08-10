
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:laundry_delivery/providers/authProvider.dart';
import 'package:laundry_delivery/providers/dashboardProvider.dart';
import 'package:laundry_delivery/providers/historyDataProvider.dart';
import 'package:laundry_delivery/providers/pickupProvider.dart';
import 'package:provider/provider.dart';
import 'splashScreen.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool checkUser=false;



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => PickupProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: GetMaterialApp(
        title: 'Laundry Delivery',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: Scaffold(

            body: SplashScreen()

        ),
      ),
    );
  }
}
