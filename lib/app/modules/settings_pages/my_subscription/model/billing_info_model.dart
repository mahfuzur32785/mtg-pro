import 'dart:convert';

class BillingInfoModel {
  BillingInfoModel({
    required this.status,
    required this.success,
    required this.code,
    required this.message,
    required this.description,
    required this.data,
  });

  final int status;
  final bool success;
  final int code;
  final String message;
  final String description;
  final Data data;

  BillingInfoModel copyWith({
    int? status,
    bool? success,
    int? code,
    String? message,
    String? description,
    Data? data,
  }) =>
      BillingInfoModel(
        status: status ?? this.status,
        success: success ?? this.success,
        code: code ?? this.code,
        message: message ?? this.message,
        description: description ?? this.description,
        data: data ?? this.data,
      );

  factory BillingInfoModel.fromJson(String str) => BillingInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BillingInfoModel.fromMap(Map<String, dynamic> json) => BillingInfoModel(
    status: json["status"],
    success: json["success"],
    code: json["code"],
    message: json["message"],
    description: json["description"],
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "success": success,
    "code": code,
    "message": message,
    "description": description,
    "data": data.toMap(),
  };
}

class Data {
  Data({
    required this.billingZipcode,
    required this.billingCountry,
    required this.billingEmail,
  });

  final String billingZipcode;
  final String billingCountry;
  final String billingEmail;

  Data copyWith({
    String? billingZipcode,
    String? billingCountry,
    String? billingEmail,
  }) =>
      Data(
        billingZipcode: billingZipcode ?? this.billingZipcode,
        billingCountry: billingCountry ?? this.billingCountry,
        billingEmail: billingEmail ?? this.billingEmail,
      );

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    billingZipcode: json["billing_zipcode"] ?? '',
    billingCountry: json["billing_country"] ?? '',
    billingEmail: json["billing_email"]?? '',
  );

  Map<String, dynamic> toMap() => {
    "billing_zipcode": billingZipcode,
    "billing_country": billingCountry,
    "billing_email": billingEmail,
  };
}
