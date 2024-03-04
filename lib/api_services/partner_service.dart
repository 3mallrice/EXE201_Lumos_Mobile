import 'dart:convert';

import '../api_model/partner/partner.dart';
import '../core/helper/local_storage_helper.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class CallPartnerApi {
  static const apiName = '/partner';
  static const rootApi = ApiService.rootApi;
  final String api = rootApi + apiName;

  // ignore: unused_field
  final String _imgUrl = '';
  String token = LocalStorageHelper.getValue("token");

  //GET: Get partner service, partner by keyword
  Future<List<Partner>> getPartnerPartnerServiceByKeyword(
      String? keyword) async {
    var url =
        keyword != "" ? Uri.parse('$api?keyword=$keyword') : Uri.parse(api);
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];
        List<Partner> partners = (responseData as List)
            .map((item) => Partner.fromJson(item))
            .toList();
        return partners;
      } else {
        throw Exception(
            'Failed to get partner by keyword: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get partner by keyword: $e');
    }
  }

  //GET: Get partner by id
  Future<Partner> getPartnerById(int id) async {
    var url = Uri.parse('$api/$id');
    token = LocalStorageHelper.getValue("token");

    try {
      http.Response response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final responseData = responseBody['data'];

        Partner partner = Partner.fromJson(responseData);

        return partner;
      } else {
        throw Exception(
            'Failed to get partner by Id: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to get partner by Id: $e');
    }
  }
}
