import 'package:flutter/cupertino.dart';
import 'package:laundry_delivery/services/apiServices.dart';
import 'package:laundry_delivery/utils/userStorage.dart';
import '../responses/getDashboardDetailsResponse.dart';
import '../responses/getOrderByRefIdResponse.dart';
import '../services/apiURL.dart';
import '../utils/widgets/snackbars.dart';

class HistoryProvider extends ChangeNotifier {

  GetOrderByRefIdResponse? getAllOrdersByIdResponse;

  Future<bool> getOrderHistory() async {
    String response = await ApiServices.postMethod(
        {'createdBy': "2"}, getAllOrderByIdURL);
        // {'createdBy': StorageCRUD.getUser().data!.id}, getAllOrderByIdURL);
    if (response.isEmpty) {
      return false;
    }
    getAllOrdersByIdResponse = getOrderByRefIdResponseFromJson(response);
    logger.i(getAllOrdersByIdResponse!.data!.length);

    notifyListeners();
    return true;
  }

  GetDashboardOrdersResponse? getDashboardOrdersResponse;

  Future<bool> getDashboardDetail() async {
    Map<String, dynamic> body = {
      "createdBy": StorageCRUD.getUser().data!.id.toString(),
      "deliveryDate": DateTime.now().toString().split(" ")[0],
      "bookingDate": DateTime.now().subtract(const Duration(days: 30)).toString().split(" ")[0],
      "page": 0,
      "limit": 100
    };
    String response = await ApiServices.postMethod(body, getDashboardDetailURL);

    logger.e(response);
    if (response.isEmpty) {
      return false;
    }
    getDashboardOrdersResponse = getDashboardOrdersResponseFromJson(response);
    notifyListeners();
    return true;
  }

}
