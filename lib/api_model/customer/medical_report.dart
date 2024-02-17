class MedicalReport {
  final int reportId;
  final int customerId;
  final String code;
  final String fullname;
  final String phone;
  final DateTime dob;
  final bool gender;
  final int pronounce;
  final int bloodType;
  final String note;
  final int status;

  MedicalReport({
    required this.reportId,
    required this.customerId,
    required this.code,
    required this.fullname,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.pronounce,
    required this.bloodType,
    required this.note,
    required this.status,
  });

  factory MedicalReport.fromJson(Map<String, dynamic> json) {
    return MedicalReport(
      reportId: json['reportId'],
      customerId: json['customerId'],
      code: json['code'],
      fullname: json['fullname'],
      phone: json['phone'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      pronounce: json['pronounce'],
      bloodType: json['bloodType'],
      note: json['note'],
      status: json['status'],
    );
  }
}
