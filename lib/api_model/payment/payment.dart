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
      'orderId': bookingId,
      'description': description,
    };
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
