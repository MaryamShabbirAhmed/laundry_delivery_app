import 'package:get/get.dart';
import 'package:laundry_delivery/providers/authProvider.dart';
import 'package:provider/provider.dart';
import '../providers/dashboardProvider.dart';
import '../providers/historyDataProvider.dart';
import '../providers/pickupProvider.dart';




DashboardProvider dashboardPro = Provider.of(Get.context!, listen:false);
AuthProvider authPro = Provider.of(Get.context!, listen:false);
PickupProvider pickupPro = Provider.of(Get.context!, listen:false);
HistoryProvider historyPro = Provider.of(Get.context!, listen:false);

