import 'dart:convert';

import '../core/helper/local_storage_helper.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../api_model/booking/booking.dart';
import 'api_service.dart';

class CallBookingApi {
  static const apiName = '/booking';
  static const rootApi = ApiService.rootApi;
  final String api = rootApi + apiName;
  var log = Logger();

  String token = LocalStorageHelper.getValue("token");

  // POST: /customer
  // request: AddBooking()
  // response: bool
  Future<bool> addBooking(int customerId, AddBooking newBooking) async {
    var url = Uri.parse('$api/customer');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode(newBooking.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to add booking: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to add booking: $e');
    }
  }
}
