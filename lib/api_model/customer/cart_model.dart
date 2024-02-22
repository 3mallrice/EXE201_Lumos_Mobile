import '../partner/partner.dart';

class CartModel {
  final int medicalReportId;
  final List<PartnerService> services;

  CartModel({
    required this.medicalReportId,
    required this.services,
  });

  //toString
  @override
  String toString() {
    return 'CartModel{medicalReportId: $medicalReportId, services: $services}';
  }
}
