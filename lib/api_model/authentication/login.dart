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

class UserDetails {
  final int? id;
  final String fullname;
  final String email;
  final String code;
  final int role;
  final String phone;
  final int pronounce;
  final String lastUpdate;
  final String lastLogin;
  final String imgUrl;

  UserDetails({
    this.id,
    required this.fullname,
    required this.email,
    required this.code,
    required this.role,
    required this.phone,
    required this.pronounce,
    required this.lastUpdate,
    required this.lastLogin,
    required this.imgUrl,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      code: json['code'],
      role: json['role'],
      phone: json['phone'],
      pronounce: json['pronounce'],
      lastUpdate: json['lastUpdate'],
      lastLogin: json['lastLogin'],
      imgUrl: json['imgUrl'],
    );
  }
}
