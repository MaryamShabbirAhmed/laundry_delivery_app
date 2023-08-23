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

 static Future<String> getWithBodyMethod(Map<String, dynamic> fields,@required String feedURL,) async {
   http.Request request=http.Request('GET', Uri.parse(baseURL+feedURL));
   request.headers.addAll(headers);
request.body=jsonEncode(fields);
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

}