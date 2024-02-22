class Address {
  final int? addressId;
  final String? code;
  final String displayName;
  final String address;
  final int? status;
  final String? createdDate;
  final String? createdBy;
  final String? lastUpdate;
  final String? updatedBy;
  final int customerId;

  Address({
    this.addressId,
    this.code,
    required this.displayName,
    required this.address,
    this.status,
    this.createdDate,
    this.createdBy,
    this.lastUpdate,
    this.updatedBy,
    required this.customerId,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressId: json['addressId'],
      code: json['code'],
      displayName: json['displayName'],
      address: json['address1'],
      status: json['status'],
      createdDate: json['createdDate'],
      createdBy: json['createdBy'],
      lastUpdate: json['lastUpdate'],
      updatedBy: json['updatedBy'],
      customerId: json['customerId'],
    );
  }
}
