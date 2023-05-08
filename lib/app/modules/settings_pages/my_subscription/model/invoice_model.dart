import 'dart:convert';

class InvoiceModel {
  InvoiceModel({
    required this.id,
    required this.gobizTransactionId,
    required this.transactionDate,
    required this.transactionId,
    required this.userId,
    required this.planId,
    required this.orderId,
    required this.description,
    required this.paymentGatewayName,
    required this.transactionCurrency,
    required this.transactionAmount,
    required this.invoiceNumber,
    required this.invoicePrefix,
    required this.invoiceDetails,
    required this.paymentStatus,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String gobizTransactionId;
  final String transactionDate;
  final String transactionId;
  final String userId;
  final int planId;
  final int orderId;
  final String description;
  final String paymentGatewayName;
  final String transactionCurrency;
  final String transactionAmount;
  final String invoiceNumber;
  final String invoicePrefix;
  final String invoiceDetails;
  final String paymentStatus;
  final String status;
  final String createdAt;
  final String updatedAt;

  InvoiceModel copyWith({
    int? id,
    String? gobizTransactionId,
    String? transactionDate,
    String? transactionId,
    String? userId,
    int? planId,
    int? orderId,
    String? description,
    String? paymentGatewayName,
    String? transactionCurrency,
    String? transactionAmount,
    String? invoiceNumber,
    String? invoicePrefix,
    String? invoiceDetails,
    String? paymentStatus,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) =>
      InvoiceModel(
        id: id ?? this.id,
        gobizTransactionId: gobizTransactionId ?? this.gobizTransactionId,
        transactionDate: transactionDate ?? this.transactionDate,
        transactionId: transactionId ?? this.transactionId,
        userId: userId ?? this.userId,
        planId: planId ?? this.planId,
        orderId: orderId ?? this.orderId,
        description: description ?? this.description,
        paymentGatewayName: paymentGatewayName ?? this.paymentGatewayName,
        transactionCurrency: transactionCurrency ?? this.transactionCurrency,
        transactionAmount: transactionAmount ?? this.transactionAmount,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        invoicePrefix: invoicePrefix ?? this.invoicePrefix,
        invoiceDetails: invoiceDetails ?? this.invoiceDetails,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory InvoiceModel.fromJson(String str) => InvoiceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromMap(Map<String, dynamic> json) => InvoiceModel(
    id: json["id"] ?? 0,
    gobizTransactionId: json["gobiz_transaction_id"] ?? '',
    transactionDate:json["transaction_date"] ?? '',
    transactionId: json["transaction_id"] ?? '',
    userId: json["user_id"] ?? '',
    planId: json["plan_id"] ?? 0,
    orderId: json["order_id"] ?? 0,
    description: json["desciption"] ?? '',
    paymentGatewayName: json["payment_gateway_name"] ?? '',
    transactionCurrency: json["transaction_currency"] ?? '',
    transactionAmount: json["transaction_amount"] ?? '',
    invoiceNumber: json["invoice_number"] ?? '',
    invoicePrefix: json["invoice_prefix"] ?? '',
    invoiceDetails: json["invoice_details"] ?? '',
    paymentStatus: json["payment_status"] ?? '',
    status: json["status"] ?? '',
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "gobiz_transaction_id": gobizTransactionId,
    "transaction_date": transactionDate,
    "transaction_id": transactionId,
    "user_id": userId,
    "plan_id": planId,
    "order_id": orderId,
    "desciption": description,
    "payment_gateway_name": paymentGatewayName,
    "transaction_currency": transactionCurrency,
    "transaction_amount": transactionAmount,
    "invoice_number": invoiceNumber,
    "invoice_prefix": invoicePrefix,
    "invoice_details": invoiceDetails,
    "payment_status": paymentStatus,
    "status": status,
    "created_at": createdAt,
  };
}