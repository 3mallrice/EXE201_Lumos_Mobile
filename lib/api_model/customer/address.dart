import 'dart:convert';
import 'package:http/http.dart' as http;

class Address {
  final int? addressId;
  final String? code;
  final String displayName;
  final String address1;
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
    required this.address1,
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
      address1: json['address1'],
      status: json['status'],
      createdDate: json['createdDate'],
      createdBy: json['createdBy'],
      lastUpdate: json['lastUpdate'],
      updatedBy: json['updatedBy'],
      customerId: json['customerId'],
    );
  }

  String get displayAddress {
    return '$address1';
  }
}
