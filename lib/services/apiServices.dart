import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:laundry_delivery/utils/widgets/snackbars.dart';

import '../responses/getAllItemsResponse.dart';
import 'apiURL.dart';

class ApiServices {

 static final headers = {'Content-Type': 'application/json'};

  static Future<String> postMethod(Map<String, dynamic> fields,
      @required String feedURL,) async {
    http.Request request = http.Request('POST', Uri.parse(baseURL + feedURL));
    request.headers.addAll(headers);
    if (fields.isNotEmpty && fields != null) {
      request.body=jsonEncode(fields);
    }
    http.StreamedResponse response = await request.send();
    String result = await response.stream.bytesToString();
    if (response.statusCode == 200 || response.statusCode == 201) {
      return result;
    }
    else {
      dynamic parsed = jsonDecode(result);
      logger.i(parsed['message'].toString());
      await errorSnackBar('error!', parsed['message'].toString());
      return "";
    }


    // return "";
  }

  static Future<String> getMethod(@required String feedURL,) async {
    http.Request request=http.Request('GET', Uri.parse(baseURL+feedURL));
     request.headers.addAll(headers);

             http.StreamedResponse  response= await request.send();
    String result= await response.stream.bytesToString();
     if(response.statusCode==200 || response.statusCode==201)
       {
           return result;
       }
     else
       {
         dynamic parsed = jsonDecode(result);
         errorSnackBar('error!', 'something is wrong');
         return "";
       }
  }

 // static Future<GetAllItemsResponse> fetchAllItems() async {
 //   // Fetch your data here from the server
 //   final response = await http.get(Uri.parse(baseURL+getAllItemsURL));
 //   if (response.statusCode == 200) {
 //     final Map<String, dynamic> responseData = json.decode(response.body);
 //     return GetAllItemsResponse.fromJson(responseData);
 //   } else {
 //     throw Exception('Failed to load items');
 //   }
 // }
}