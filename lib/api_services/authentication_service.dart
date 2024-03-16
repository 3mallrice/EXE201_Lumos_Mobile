import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_model/authentication/login.dart';
import '../api_model/authentication/signup.dart';
import '../core/helper/local_storage_helper.dart';
import 'api_service.dart';

class CallAuthenticationApi {
  static const apiName = 'auth';
  static const rootApi = ApiService.rootApi;
  final String api = "$rootApi/$apiName";

  // ignore: unused_field
  final String _imgUrl = '';
  String token = "";

  //POST: /login
  //request: email, password
  //response: LoginResponse (token, accessTokenExpiration, refreshToken, refreshTokenExpiration)
  Future<UserDetails> login(String email, String password) async {
    try {
      LoginRequest request = LoginRequest(email: email, password: password);

      var url = Uri.parse('$api/login');
      var body = jsonEncode(request.toJson());

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final loginData = responseData['data'];
        token = loginData['token'];
        UserDetails userDetails =
            UserDetails.fromJson(loginData['userDetails']);

        LocalStorageHelper.setValue("token", token);
        return userDetails;
      } else {
        throw Exception(
            'Failed to login: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  //POST: /sign-out
  Future<bool> signOut() async {
    var url = Uri.parse('$api/sign-out');
    http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      token = "";
      return true;
    } else {
      throw Exception(
          'Failed to sign out: $response.statusCode - ${response.reasonPhrase}');
    }
  }

  // POST: /register
  // request: SingUp(email, fullname, password, rePassword, phone)
  // response: true or false
  Future<int> register(String email, String fullname, String password,
      String rePassword, String phone) async {
    try {
      var url = Uri.parse('$api/register');
      SignUp request = SignUp(
        email: email,
        fullname: fullname,
        password: password,
        confirmPassword: rePassword,
        phone: phone,
      );
      var body = jsonEncode(request.toJson());

      http.Response response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 409) {
        return response.statusCode;
      } else {
        throw Exception(
            'Failed to register: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }
}
