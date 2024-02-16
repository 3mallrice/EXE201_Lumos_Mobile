class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class LoginResponse {
  final String username;
  final String token;
  final String accessTokenExpiration;
  final String refreshToken;
  final String refreshTokenExpiration;

  LoginResponse({
    required this.username,
    required this.token,
    required this.accessTokenExpiration,
    required this.refreshToken,
    required this.refreshTokenExpiration,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      username: json['username'],
      token: json['token'],
      accessTokenExpiration: json['accessTokenExpiration'],
      refreshToken: json['refreshToken'],
      refreshTokenExpiration: json['refreshTokenExpiration'],
    );
  }
}
