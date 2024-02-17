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
  final UserDetails userDetails;

  LoginResponse({
    required this.username,
    required this.token,
    required this.accessTokenExpiration,
    required this.refreshToken,
    required this.refreshTokenExpiration,
    required this.userDetails,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      username: json['username'],
      token: json['token'],
      accessTokenExpiration: json['accessTokenExpiration'],
      refreshToken: json['refreshToken'],
      refreshTokenExpiration: json['refreshTokenExpiration'],
      userDetails: UserDetails.fromJson(json['userdetails']),
    );
  }
}

class UserDetails {
  final String email;
  final String code;
  final int role;
  final int status;
  final String createdDate;
  final String? createdBy;
  final String lastUpdate;
  final String updatedBy;
  final String imgUrl;

  UserDetails({
    required this.email,
    required this.code,
    required this.role,
    required this.status,
    required this.createdDate,
    this.createdBy,
    required this.lastUpdate,
    required this.updatedBy,
    required this.imgUrl,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      email: json['email'],
      code: json['code'],
      role: json['role'],
      status: json['status'],
      createdDate: json['createdDate'],
      createdBy: json['createdBy'],
      lastUpdate: json['lastUpdate'],
      updatedBy: json['updatedBy'],
      imgUrl: json['imgUrl'],
    );
  }
}
