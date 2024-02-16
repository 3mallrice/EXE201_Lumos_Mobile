class ApiService {
  static const String rootApi = 'http://54.252.239.12/api';
}

class ApiResponse<T> {
  final int statusCode;
  final String message;
  final T data;

  ApiResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }
}
