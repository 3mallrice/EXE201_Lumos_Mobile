import 'dart:convert';
import '../api_model/authentication/login.dart';
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
          refreshToken: loginData['refreshToken'],
          refreshTokenExpiration: loginData['refreshTokenExpiration'],
          token: loginData['token'],
          userDetails: userDetails,
        );
        // save login userdetail to
        token = loginResponse.token;
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
      return true;
    } else {
      throw Exception(
          'Failed to sign out: $response.statusCode - ${response.reasonPhrase}');
    }
  }
}
