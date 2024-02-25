import 'dart:convert';
import '../api_model/authentication/login.dart';
import '../api_model/authentication/signup.dart';
import '../core/helper/local_storage_helper.dart';
import 'api_service.dart';
import 'package:http/http.dart' as http;

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
  Future<LoginResponse> login(String email, String password) async {
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
        final userdetailData = loginData['userdetails'];
        UserDetails userDetails = UserDetails(
          id: userdetailData['id'],
          username: loginData['username'],
          code: userdetailData['code'],
          email: userdetailData['email'],
          role: userdetailData['role'],
          status: userdetailData['status'],
          createdDate: userdetailData['createdDate'],
          createdBy: userdetailData['createdBy'],
          lastUpdate: userdetailData['lastUpdate'],
          updatedBy: userdetailData['updatedBy'],
          imgUrl: userdetailData['imgUrl'],
        );
        LoginResponse loginResponse = LoginResponse(
          username: loginData['username'],
          accessTokenExpiration: loginData['accessTokenExpiration'],
          token: loginData['token'],
          userDetails: userDetails,
        );
        // save login userdetail to
        token = loginResponse.token;
        LocalStorageHelper.setValue("token", token);
        return loginResponse;
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
