import 'api_service.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

class CallAuthenticationApi {
  static const apiName = 'authentication';
  static const rootApi = ApiService.rootApi;
  final String api = rootApi + apiName;
  // ignore: unused_field
  final String _imgUrl = '';
  String token = "";
}
