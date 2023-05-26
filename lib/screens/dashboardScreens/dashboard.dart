import 'package:flutter/material.dart';
import 'package:laundry_delivery/screens/dashboardScreens/home.dart';
import 'package:laundry_delivery/screens/scannerScreen.dart';

import '../../utils/colors.dart';
import '../../utils/widgets/snackbars.dart';
import '../historyScreens/history.dart';

class DashboardScreen extends StatefulWidget {
  var index;

  DashboardScreen({Key? key, this.index = 0}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> screens = [];

  @override
  void initState() {
    screens = [
      HomeScreen(),
      HistoryScreen(),
      ScannerScreen(),
    ];

    super.initState();
  }

  int index = 0;
  List<NavigationModel> icons = [
    NavigationModel(
        icon: Image.asset(
      'assets/dashboard_images/home.png',
      color: primaryColor,
    )),
    NavigationModel(icon: Image.asset('assets/dashboard_images/recent.png')),
    NavigationModel(icon: Image.asset('assets/dashboard_images/scanner.png')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 60,
          child: BottomNavigationBar(
            currentIndex: index,
            selectedFontSize: 12,
            selectedItemColor: primaryColor,
            unselectedItemColor: borderGreyColor,
            items: icons.map((e) {
              return BottomNavigationBarItem(icon: e.icon, label: e.label);
            }).toList(),
            onTap: (indexMenu) {
              setState(() {
                index = indexMenu;

              });
            },
          ),
        ),
        body: PageStorage(
          bucket: bucket,
          child: screens[index],
        ));
  }
}

class NavigationModel {
  var icon;
  String? label;

  NavigationModel({required this.icon, this.label = ''});
}
