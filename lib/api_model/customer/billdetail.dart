class BillDetailId {
  final int bookingId;
  final String bookingCode;
  final int status;
  final String partner;
  final int totalPrice;
  final int additionalFee;
  final String bookingDate;
  final int bookingTime;
  final String address;
  final String paymentMethod;
  final String note;
  final dynamic rating;
  final String isPay;
  final List<MedicalServices> medicalServices;

  BillDetailId({
    required this.bookingId,
    required this.bookingCode,
    required this.status,
    required this.partner,
    required this.totalPrice,
    required this.additionalFee,
    required this.bookingDate,
    required this.bookingTime,
    required this.address,
    required this.paymentMethod,
    required this.note,
    required this.rating,
    required this.isPay,
    required this.medicalServices,
  });

  factory BillDetailId.fromJson(Map<String, dynamic> json) {
    final medicalServices = (json['medicalServices'] as List)
        .map((service) => MedicalServices.fromJson(service))
        .toList();

    return BillDetailId(
      bookingId: json['bookingId'],
      bookingCode: json['bookingCode'],
      status: json['status'],
      partner: json['partner'],
      totalPrice: json['totalPrice'],
      additionalFee: json['additionalFee'],
      bookingDate: json['bookingDate'],
      bookingTime: json['bookingTime'],
      address: json['address'],
      paymentMethod: json['paymentMethod'],
      note: json['note'],
      rating: json['rating'],
      isPay: json['isPay'],
      medicalServices: medicalServices,
    );
  }
}

class MedicalServices {
  final String medicalName;
  final List<Servicess> services;

  MedicalServices({
    required this.medicalName,
    required this.services,
  });

  factory MedicalServices.fromJson(Map<String, dynamic> json) {
    final services = (json['services'] as List)
        .map((service) => Servicess.fromJson(service))
        .toList();

    return MedicalServices(
      medicalName: json['medicalName'],
      services: services,
    );
  }
}

class Servicess {
  final String name;
  final int price;

  Servicess({
    required this.name,
    required this.price,
  });

  factory Servicess.fromJson(Map<String, dynamic> json) {
    return Servicess(
      name: json['name'],
      price: json['price'],
    );
  }
}
