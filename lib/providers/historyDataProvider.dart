


import 'package:flutter/cupertino.dart';
import 'package:laundry_delivery/services/apiServices.dart';
import 'package:laundry_delivery/utils/userStorage.dart';
import '../responses/getAllOrdersById.dart';
import '../responses/getDashboardDetailsResponse.dart';
import '../services/apiURL.dart';
import '../utils/widgets/snackbars.dart';

class HistoryProvider extends ChangeNotifier{

  // ListDataResponse? listDataResponse;
  //
  // void listData(){listDataResponseFromJson(listHistoryTile);}

  GetAllOrdersByIdResponse? getAllOrdersByIdResponse;

  Future<bool> getOrderHistory() async {

    String response=await ApiServices.postMethod({'createdBy':'2'},getAllOrderByIdURL );
    if(response.isEmpty)
      {
        return false;
      }
    getAllOrdersByIdResponse=getAllOrdersByIdResponseFromJson(response);
logger.i(getAllOrdersByIdResponse!.data!.length);

    notifyListeners();
return true;
  }

///
  GetDashboardOrdersResponse? getDashboardOrdersResponse;
  Future<bool> getDashboardDetail() async {
Map<String,dynamic> body={
  "createdBy": StorageCRUD.getUser().data!.id.toString(),
  "deliveryDate": "2023-08-10",
  "bookingDate": "2023-08-09",
  "page": 0,
  "limit": 100,
  "status":"pending"
};
    String response=await ApiServices.postMethod(body,getDashboardDetailURL );

    if(response.isEmpty)
      {
        return false;
      }
    getDashboardOrdersResponse=getDashboardOrdersResponseFromJson(response);
notifyListeners();
    return true;
  }


}