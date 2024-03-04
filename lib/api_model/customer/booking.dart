class AddBooking {
  final int partnerId;
  final int paymentId;
  final DateTime bookingDate;
  final int dayOfWeek;
  final int bookingTime;
  final String address;
  final String note;
  final List<BookingCart> cartModel;

  AddBooking({
    required this.partnerId,
    required this.paymentId,
    required this.bookingDate,
    required this.dayOfWeek,
    required this.bookingTime,
    required this.address,
    required this.note,
    required this.cartModel,
  });

  Map<String, dynamic> toJson() {
    return {
      "partnerId": partnerId,
      "paymentId": paymentId,
      "bookingDate": bookingDate.toIso8601String(),
      "dayOfWeek": dayOfWeek,
      "bookingTime": bookingTime,
      "address": address,
      "note": note,
      "cartModel": cartModel.map((cart) => cart.toJson()).toList(),
    };
  }
}

class BookingCart {
  final int reportId;
  final List<int> services;

  BookingCart({
    required this.reportId,
    required this.services,
  });

  Map<String, dynamic> toJson() {
    return {
      "reportId": reportId,
      "services": services,
    };
  }
}

class AddBookingResponse {
  final int bookingId;
  final int totalPrice;

  AddBookingResponse({
    required this.bookingId,
    required this.totalPrice,
  });

  factory AddBookingResponse.fromJson(Map<String, dynamic> json) {
    return AddBookingResponse(
      bookingId: json['bookingId'],
      totalPrice: json['totalPrice'],
    );
  }
}
