class SignUp {
  final String email;
  final String fullname;
  final String password;
  final String rePassword;
  final int pronounce = 0;
  final String phone;

  SignUp({
    required this.email,
    required this.fullname,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullname': fullname,
      'pronounce': pronounce,
      'password': password,
      'rePassword': rePassword,
      'phone': phone,
    };
  }
}
