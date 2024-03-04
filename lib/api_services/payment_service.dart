import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_model/payment/payment.dart';
import '../core/helper/local_storage_helper.dart';
import 'api_service.dart';

class CallPaymentAPI {
  static const apiName = '/payment';
  static const rootApi = ApiService.rootApi;
  final String api = rootApi + apiName;

  // ignore: unused_field
  final String _imgUrl = '';
  String token = LocalStorageHelper.getValue("token");

  //GET: Get all payment
  Future<List<Payment>> getAllPayment() async {
    var url = Uri.parse("$api/method");
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        List<Payment> payments = (responseData as List)
            .map((item) => Payment.fromJson(item))
            .toList();
        return payments;
      } else {
        throw Exception(
            'Failed to get all payment: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get all payment: $e');
    }
  }

  //POST: Add payment
  Future<AddPaymentResponse> addPayment(AddPayment addPayment) async {
    var url = Uri.parse("$api/method");
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
          body: json.encode(addPayment.toJson()));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        return AddPaymentResponse.fromJson(responseData);
      } else {
        throw Exception(
            'Failed to add payment: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to add payment: $e');
    }
  }
}
