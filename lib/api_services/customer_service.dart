import 'dart:convert';

import 'package:exe201_lumos_mobile/api_model/customer/address.dart';
import 'package:exe201_lumos_mobile/api_model/customer/medical_report.dart';
import 'package:exe201_lumos_mobile/core/helper/local_storage_helper.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'api_service.dart';

class CallCustomerApi {
  static const apiName = '/customer';
  static const rootApi = ApiService.rootApi;
  final String api = rootApi + apiName;
  var log = Logger();

  // ignore: unused_field
  final String _imgUrl = '';
  String token = LocalStorageHelper.getValue("token");

  //GET: /{id}/medical-report: Get all medical report
  //request: customerId
  //response: List<MedicalReport>
  Future<List<MedicalReport>> getMedicalReport(int customerId) async {
    var url = Uri.parse('$api/$customerId/medical-report');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        List<MedicalReport> medicalReports = responseData
            .map<MedicalReport>((item) => MedicalReport.fromJson(item))
            .toList();
        return medicalReports;
      } else {
        throw Exception(
            'Failed to get medical report: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get medical report: $e');
    }
  }

  //POST: medical-report
  Future<bool> addNewMedicalReport(
      int customerId, MedicalReport newReport) async {
    var url = Uri.parse('$api/medical-report');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'fullName': newReport.fullname,
          'phone': newReport.phone,
          'dob': newReport.dob.toIso8601String(),
          'gender': newReport.gender,
          'pronounce': newReport.pronounce,
          'bloodType': newReport.bloodType,
          'note': newReport.note,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        log.i('New medical report added: $responseData[\'message\']');
        return true;
      } else {
        throw Exception(
            'Failed to add new medical report: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      log.i("Failed to add new medical report: $e");
      throw Exception('Failed to add new medical report: $e');
    }
  }

  Future<MedicalReport> getMedicalReportById(int reportId) async {
    var url = Uri.parse('$api/medical-report/$reportId');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        MedicalReport medicalReport = MedicalReport.fromJson(responseData);
        return medicalReport;
      } else {
        throw Exception(
            'Failed to get medical report: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get medical report: $e');
    }
  }

  Future<List<Address>> getCustomerAddress(int customerId) async {
    var url = Uri.parse('$api/$customerId/address');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        List<Address> addressList = responseData
            .map<Address>((item) => Address.fromJson(item))
            .toList();
        return addressList;
      } else {
        throw Exception(
            'Failed to get address: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get address: $e');
    }
  }

  //POST: medical-report
  Future<bool> addNewAddress(int customerId, Address newAddress) async {
    var url = Uri.parse('$api/address');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'displayName': newAddress.displayName,
          'address': newAddress.address,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        return responseData['statusCode'] == 'success' ? true : false;
      } else {
        throw Exception(
            'Failed to add new address: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      log.i("Failed to add new address: $e");
      throw Exception('Failed to add new address: $e');
    }
  }
}
