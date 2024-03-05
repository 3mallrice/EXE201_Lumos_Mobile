import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_model/payment/payment.dart';
import '../core/helper/local_storage_helper.dart';
import 'api_service.dart';

class CallPaymentAPI {
  static const apiName = '/payment';
  static const rootApi = ApiService.rootApi;
  final String api = rootApi + apiName;

  String paymentApiLink = 'https://api-merchant.payos.vn/v2/payment-requests';

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
    var url = Uri.parse(api);
    token = LocalStorageHelper.getValue("token");
    final requestBody = json.encode(addPayment.toJson());

    try {
      http.Response response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
          body: requestBody);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        return AddPaymentResponse.fromJson(responseData);
      } else {
        throw Exception(
            'Failed to add payment: ${response.statusCode} - ${response.reasonPhrase}\n${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add payment: $e');
    }
  }

  //GET: Get payment by PaymentLinkId
  Future<CheckPayment> getPaymentByPaymentLinkId(String paymentLinkId) async {
    var url = Uri.parse("$paymentApiLink/$paymentLinkId");
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'x-client-id': '2b13d4e0-5fac-42c7-b09b-5c3580d17a7f',
        'x-api-key': '2c2991da-1a34-47d9-8902-dbe38b24146d',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final responseData = responseBody['data'];
        CheckPayment payment = CheckPayment.fromJson(responseData);
        return payment;
      } else {
        throw Exception(
            'Failed to get payment by PaymentLinkId: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get payment by PaymentLinkId: $e');
    }
  }

  //POST: Cancel payment
  Future<CheckPayment> cancelPayment(
      String paymentLinkId, String cancellationReason) async {
    var url = Uri.parse("$paymentApiLink/$paymentLinkId/cancel");
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'x-client-id': '2b13d4e0-5fac-42c7-b09b-5c3580d17a7f',
            'x-api-key': '2c2991da-1a34-47d9-8902-dbe38b24146d',
            'Content-Type': 'application/json'
          },
          body: json.encode(
            {
              'cancellationReason': cancellationReason,
            },
          ));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final responseData = responseBody['data'];
        CheckPayment payment = CheckPayment.fromJson(responseData);
        return payment;
      } else {
        throw Exception(
            'Failed to cancel payment: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to cancel payment: $e');
    }
  }
}
