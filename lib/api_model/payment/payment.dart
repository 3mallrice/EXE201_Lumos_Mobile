// ignore_for_file: constant_identifier_names

class Payment {
  final int paymentId;
  final String name;
  final int status;

  Payment({
    required this.paymentId,
    required this.name,
    required this.status,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['paymentId'],
      name: json['name'],
      status: json['status'],
    );
  }
}

class AddPayment {
  final String buyerName;
  final String buyerEmail;
  final String buyerPhone;
  final String buyerAddress;
  final int bookingId;
  final String description;

  AddPayment({
    required this.buyerName,
    required this.buyerEmail,
    required this.buyerPhone,
    required this.buyerAddress,
    required this.bookingId,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'buyerName': buyerName,
      'buyerEmail': buyerEmail,
      'buyerPhone': buyerPhone,
      'buyerAddress': buyerAddress,
      'bookingId': bookingId,
      'description': description,
    };
  }

  //to string
  @override
  String toString() {
    return 'AddPayment{buyerName: $buyerName, buyerEmail: $buyerEmail, buyerPhone: $buyerPhone, buyerAddress: $buyerAddress, bookingId: $bookingId, description: $description}';
  }
}

class AddPaymentResponse {
  final String bin;
  final String accountNumber;
  final int amount;
  final String description;
  final int orderCode;
  final String currency;
  final String paymentLinkId;
  final String status;
  final String checkoutUrl;
  final String qrCode;

  AddPaymentResponse({
    required this.bin,
    required this.accountNumber,
    required this.amount,
    required this.description,
    required this.orderCode,
    required this.currency,
    required this.paymentLinkId,
    required this.status,
    required this.checkoutUrl,
    required this.qrCode,
  });

  factory AddPaymentResponse.fromJson(Map<String, dynamic> json) {
    return AddPaymentResponse(
      bin: json['bin'],
      accountNumber: json['accountNumber'],
      amount: json['amount'],
      description: json['description'],
      orderCode: json['orderCode'],
      currency: json['currency'],
      paymentLinkId: json['paymentLinkId'],
      status: json['status'],
      checkoutUrl: json['checkoutUrl'],
      qrCode: json['qrCode'],
    );
  }

  //to string
  @override
  String toString() {
    return 'AddPaymentResponse{bin: $bin, accountNumber: $accountNumber, amount: $amount, description: $description, orderCode: $orderCode, currency: $currency, paymentLinkId: $paymentLinkId, status: $status, checkoutUrl: $checkoutUrl, qrCode: $qrCode}';
  }
}

//check status
class CheckPayment {
  final String id;
  final int orderCode;
  final int amount;
  final int amountPaid;
  final int amountRemaining;
  final String status;
  final DateTime createdAt;
  final DateTime? canceledAt;
  final String? cancellationReason;

  CheckPayment({
    required this.id,
    required this.orderCode,
    required this.amount,
    required this.amountPaid,
    required this.amountRemaining,
    required this.status,
    required this.createdAt,
    this.canceledAt,
    this.cancellationReason,
  });

  factory CheckPayment.fromJson(Map<String, dynamic> json) {
    return CheckPayment(
      id: json['id'] as String,
      orderCode: json['orderCode'] as int,
      amount: json['amount'] as int,
      amountPaid: json['amountPaid'] as int,
      amountRemaining: json['amountRemaining'] as int,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      canceledAt: json['canceledAt'] != null
          ? DateTime.parse(json['canceledAt'] as String)
          : null,
      cancellationReason: json['cancellationReason'] as String?,
    );
  }

  //to string
  @override
  String toString() {
    return 'CheckPayment{id: $id, orderCode: $orderCode, amount: $amount, amountPaid: $amountPaid, amountRemaining: $amountRemaining, status: $status, createdAt: $createdAt, canceledAt: $canceledAt, cancellationReason: $cancellationReason}';
  }
}

// PAID - Đã thanh toán
// PENDING - Chờ thanh toán
// PROCESSING - Đang xử lý
// CANCELLED - Đã hủy
class PaymentStatus {
  static const String PAID = 'PAID';
  static const String PENDING = 'PENDING';
  static const String PROCESSING = 'PROCESSING';
  static const String CANCELLED = 'CANCELLED';
  static const String EXPIRED = 'EXPIRED';
}
