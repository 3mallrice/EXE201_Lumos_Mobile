import 'dart:convert';

import '../api_model/customer/bill.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../api_model/customer/booking.dart';
import '../api_model/customer/coming_booking.dart';
import '../core/helper/local_storage_helper.dart';
import 'api_service.dart';

class CallBookingApi {
  static const apiName = '/booking';
  static const rootApi = ApiService.rootApi;
  final String api = rootApi + apiName;
  var log = Logger();

  // ignore: unused_field
  final String _imgUrl = '';
  String token = LocalStorageHelper.getValue("token");

  Future<List<BookingComing>> getBookingComing() async {
    var url = Uri.parse('$api/comming');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        List<BookingComing> comingList = responseData
            .map<BookingComing>((item) => BookingComing.fromJson(item))
            .toList();
        return comingList;
      } else {
        throw Exception(
            'Failed to get coming booking: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get coming booking: $e');
    }
  }

  // POST: /customer
  // request: AddBooking()
  // response: bool
  Future<AddBookingResponse> addBooking(AddBooking newBooking) async {
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
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        AddBookingResponse addBookingResponse =
            AddBookingResponse.fromJson(responseData);
        return addBookingResponse;
      } else {
        throw Exception(
            'Failed to add booking: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to add booking: $e');
    }
  }

  Future<List<BookingComing>> getBookings() async {
    var url = Uri.parse(api);
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        List<BookingComing> list = responseData
            .map<BookingComing>((item) => BookingComing.fromJson(item))
            .toList();
        return list;
      } else {
        throw Exception(
            'Failed to get booking: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get booking: $e');
    }
  }

  Future<List<Billing>> getBillings() async {
    var url = Uri.parse('$api/bill');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        List<Billing> comingList = responseData
            .map<Billing>((item) => Billing.fromJson(item))
            .toList();
        return comingList;
      } else {
        throw Exception(
            'Failed to get billings: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get billings: $e');
    }
  }

  Future<BookingComing> getBookingDetail(int bookingId) async {
    var url = Uri.parse('$api/$bookingId/detail');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];

        return BookingComing.fromJson(responseData);
      } else {
        throw Exception(
            'Failed to get booking detail: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get booking detail: $e');
    }
  }
}
