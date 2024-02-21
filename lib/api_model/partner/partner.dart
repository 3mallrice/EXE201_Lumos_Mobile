class Partner {
  final int? partnerId;
  final String? code;
  final String? email;
  final String? partnerName;
  final String? displayName;
  final String? address;
  final String? phone;
  final String? description;
  final String? imgUrl;
  final String? businessLicenseNumber;
  final List<PartnerService>? partnerServices;

  Partner({
    this.code,
    this.email,
    this.displayName,
    this.phone,
    this.partnerId,
    this.partnerName,
    this.address,
    this.description,
    this.businessLicenseNumber,
    this.imgUrl,
    this.partnerServices,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    List<dynamic>? servicesJson = json['partnerServices'];
    List<PartnerService>? services;
    if (servicesJson != null) {
      services =
          servicesJson.map((json) => PartnerService.fromJson(json)).toList();
    }

    return Partner(
      code: json['code'],
      email: json['email'],
      displayName: json['displayName'],
      phone: json['phone'],
      partnerId: json['partnerId'],
      partnerName: json['partnerName'],
      address: json['address'],
      description: json['description'],
      imgUrl: json['imgUrl'],
      businessLicenseNumber: json['businessLicenseNumber'],
      partnerServices: services,
    );
  }
}

class PartnerService {
  final int? serviceId;
  final String? code;
  final String? name;
  final int? duration;
  final int? status;
  final String? description;
  final int? price;

  PartnerService({
    this.serviceId,
    this.code,
    this.name,
    this.duration,
    this.status,
    this.description,
    this.price,
  });

  factory PartnerService.fromJson(Map<String, dynamic> json) {
    return PartnerService(
      serviceId: json['serviceId'],
      code: json['code'],
      name: json['name'],
      duration: json['duration'],
      status: json['status'],
      description: json['description'],
      price: json['price'],
    );
  }
}
