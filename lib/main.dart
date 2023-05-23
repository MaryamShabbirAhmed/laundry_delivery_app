import 'package:flutter/material.dart';
import 'package:laundry_delivery/providers/dashboardProvider.dart';
import 'package:laundry_delivery/screens/dashboardScreens/dashboard.dart';
import 'package:laundry_delivery/screens/dashboardScreens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {




    return MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (_)=> DashboardProvider()),

        ],
    child:
      MaterialApp(
        title: 'Laundry Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  DashboardScreen(),
      ),
    );




  }
}

