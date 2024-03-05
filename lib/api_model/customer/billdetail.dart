class BillDetailId {
  final int bookingId;
  final String bookingCode;
  final int status;
  final String partner;
  final int totalPrice;
  final int additionalFee;
  final String createDate;
  final String bookingDate;
  final int bookingTime;
  final String address;
  final String paymentMethod;
  final String? note;
  final double? rating;
  final String isPay;
  final List<MedServices> medicalServices;

  BillDetailId({
    required this.bookingId,
    required this.bookingCode,
    required this.status,
    required this.partner,
    required this.totalPrice,
    required this.additionalFee,
    required this.createDate,
    required this.bookingDate,
    required this.bookingTime,
    required this.address,
    required this.paymentMethod,
    this.note,
    this.rating,
    required this.isPay,
    required this.medicalServices,
  });

  factory BillDetailId.fromJson(Map<String, dynamic> json) {
    final medicalServices = (json['medicalServices'] as List)
        .map((service) => MedServices.fromJson(service))
        .toList();

    return BillDetailId(
      bookingId: json['bookingId'],
      bookingCode: json['bookingCode'],
      status: json['status'],
      partner: json['partner'],
      totalPrice: json['totalPrice'],
      additionalFee: json['additionalFee'],
      createDate: json['createDate'],
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

class MedServices {
  final String medicalName;
  final List<PService> services;

  MedServices({
    required this.medicalName,
    required this.services,
  });

  factory MedServices.fromJson(Map<String, dynamic> json) {
    final services = (json['services'] as List)
        .map((service) => PService.fromJson(service))
        .toList();

    return MedServices(
      medicalName: json['medicalName'],
      services: services,
    );
  }
}

class PService {
  final String name;
  final int price;

  PService({
    required this.name,
    required this.price,
  });

  factory PService.fromJson(Map<String, dynamic> json) {
    return PService(
      name: json['name'],
      price: json['price'],
    );
  }
}
