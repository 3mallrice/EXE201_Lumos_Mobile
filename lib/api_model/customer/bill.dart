class Billing {
  final int id;
  final String bookingCode;
  final int status;
  final String partnerName;
  final int totalPrice;
  final String bookingDate;
  final int bookingTime;
  final String note;

  Billing({
    required this.id,
    required this.bookingCode,
    required this.status,
    required this.partnerName,
    required this.totalPrice,
    required this.bookingDate,
    required this.bookingTime,
    required this.note,
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      id: json['bookingId'],
      bookingCode: json['bookingCode'],
      status: json['status'],
      partnerName: json['partnerName'],
      totalPrice: json['totalPrice'],
      bookingDate: json['bookingDate'],
      bookingTime: json['bookingTime'],
      note: json['note'],
    );
  }
}
