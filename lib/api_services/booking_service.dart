import 'dart:convert';

import 'package:exe201_lumos_mobile/api_model/customer/billdetail.dart';

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
        throw Exception('${response.statusCode} - ${response.reasonPhrase}');
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
        throw Exception('${response.statusCode} - ${response.reasonPhrase}');
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
        throw Exception('${response.statusCode} - ${response.reasonPhrase}');
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
        List<Billing> list = responseData
            .map<Billing>((item) => Billing.fromJson(item))
            .toList();
        return list;
      } else {
        throw Exception('${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get bills: $e');
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
        throw Exception('${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get booking detail: $e');
    }
  }

  Future<BillDetailId> getBillingDetail(int bookingId) async {
    var url = Uri.parse('$api/bill/$bookingId');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        BillDetailId billDetail = BillDetailId.fromJson(responseData);

        return billDetail;
      } else {
        throw Exception(
            'Failed to get billing detail: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get billing detail: $e');
    }
  }

  // POST:/api/booking/{bookingId}/cancel
  // request: int bookingId, String reason
  // response: bool
  // update booking status from waiting/pending to cancel
  Future<bool> cancelBooking(int bookingId, String reason) async {
    var url = Uri.parse('$api/$bookingId/cancel');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({'cancellationReason': reason}),
      );

      if (response.statusCode == 200) {
        // final responseBody = json.decode(response.body);
        // final responseData = responseBody['data'];
        return true;
      } else {
        throw Exception('${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to cancel booking: $e');
    }
  }

  // POST:/api/booking/{bookingId}/pending
  // request: int bookingId, String paymentLinkId
  // response: bool
  // update booking status from waiting to pending
  Future<bool> pendingBooking(int bookingId, String paymentLinkId) async {
    var url = Uri.parse('$api/$bookingId/pending');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({'paymentLinkId': paymentLinkId}),
      );

      if (response.statusCode == 200) {
        // final responseBody = json.decode(response.body);
        // final responseData = responseBody['data'];
        return true;
      } else {
        throw Exception('${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to pending booking: $e');
    }
  }
}
