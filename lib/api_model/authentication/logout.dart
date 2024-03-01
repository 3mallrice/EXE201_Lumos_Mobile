class AddBooking {
  final int partnerId;
  final int paymentId;
  final int totalPrice;
  final DateTime bookingDate;
  final int dayOfWeek;
  final int bookingTime;
  final String address;
  final String note;
  final List<BookingCart> cartModel;

  AddBooking({
    required this.partnerId,
    required this.paymentId,
    required this.totalPrice,
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
      "totalPrice": totalPrice,
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
  final List<Service> services;

  BookingCart({
    required this.reportId,
    required this.services,
  });

  Map<String, dynamic> toJson() {
    return {
      "reportId": reportId,
      "services": services.map((service) => service.toJson()).toList(),
    };
  }
}

class Service {
  final int serviceId;
  final double price;

  Service({
    required this.serviceId,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "serviceId": serviceId,
      "price": price,
    };
  }
}
