class BookingComing {
  final int? bookingId;
  final int? status;
  final String? partner;
  final String? bookingDate;
  final int? bookingTime;
  final String? address;
  final String? paymentMethod;
  final List<MedicalService> medicalServices;
  final String? note;
  final String? code;

  BookingComing(
      {this.bookingId,
      this.status,
      this.partner,
      this.bookingDate,
      this.bookingTime,
      this.address,
      this.paymentMethod,
      required this.medicalServices,
      this.code,
      this.note});

  factory BookingComing.fromJson(Map<String, dynamic> json) {
    return BookingComing(
      bookingId: json['bookingId'],
      status: json['status'],
      partner: json['partner'],
      bookingDate: json['bookingDate'],
      bookingTime: json['bookingTime'],
      address: json['address'],
      paymentMethod: json['paymentMethod'],
      medicalServices: (json['medicalServices'] as List<dynamic>?)
              ?.map((medicalServiceJson) =>
                  MedicalService.fromJson(medicalServiceJson))
              .toList() ??
          [],
      note: json['note'],
      code: json['bookingCode'],
    );
  }
}

class MedicalService {
  final String? medicalName;
  final List<Service> services;

  MedicalService({
    this.medicalName,
    required this.services,
  });

  factory MedicalService.fromJson(Map<String, dynamic> json) {
    return MedicalService(
      medicalName: json['medicalName'],
      services: (json['services'] as List<dynamic>?)
              ?.map((serviceJson) => Service.fromJson(serviceJson))
              .toList() ??
          [],
    );
  }
}

class Service {
  final int? serviceId;
  final String? name;
  final String? code;
  final int? duration;
  final int? status;
  final String? description;
  final int? price;
  final int? bookedQuantity;
  final double? rating;
  final dynamic categories;

  Service({
    this.serviceId,
    this.name,
    this.code,
    this.duration,
    this.status,
    this.description,
    this.price,
    this.bookedQuantity,
    this.rating,
    this.categories,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['serviceId'],
      name: json['name'],
      code: json['code'],
      duration: json['duration'],
      status: json['status'],
      description: json['description'],
      price: json['price'],
      bookedQuantity: json['bookedQuantity'],
      rating: json['rating'],
      categories: json['categories'],
    );
  }
}
