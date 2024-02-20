import '../../representation/member/partner_service_list.dart';

class CartModel {
  final int medicalReportId;
  final List<Service> services;

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
