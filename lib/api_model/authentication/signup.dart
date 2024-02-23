class SignUp {
  final String email;
  final String fullname;
  final String password;
  final String confirmPassword;
  final String phone;

  SignUp({
    required this.email,
    required this.fullname,
    required this.password,
    required this.confirmPassword,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullname': fullname,
      'password': password,
      'confirmPassword': confirmPassword,
      'phone': phone,
    };
  }
}
