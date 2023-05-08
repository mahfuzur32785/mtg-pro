import 'dart:convert';

class CrmDetailsModel {
  CrmDetailsModel({
    required this.id,
    required this.name,
    required this.title,
    required this.ccode,
    required this.phone,
    required this.email,
    required this.companyName,
    required this.message,
    required this.userId,
    required this.cardId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.isActive,
    required this.profileImage,
    required this.connectUserId,
    required this.applicantName,
    required this.socialSecurityNumber,
    required this.dateOfBirth,
    required this.currentStreet,
    required this.currentCity,
    required this.currentState,
    required this.currentDate,
    required this.priorAddress,
    required this.priorCity,
    required this.priorState,
    required this.priorStartDate,
    required this.priorEndDate,
    required this.license,
    required this.licenseState,
    required this.signature,
    required this.signatureDate,
    required this.queryType,
    required this.purpose,
    required this.price,
    required this.downAmount,
    required this.propertyType,
    required this.location,
    required this.agent,
    required this.occupation,
    required this.currentEmployer,
    required this.annualIncome,
    required this.creditScore,
    required this.contactInfomation,
    required this.profileImageUrl,
  });

  final int? id;
  final String? name;
  final String? title;
  final dynamic ccode;
  final String? phone;
  final String? email;
  final String? companyName;
  final String? message;
  final int? userId;
  final int? cardId;
  final String? createdAt;
  final String? updatedAt;
  final dynamic createdBy;
  final int? updatedBy;
  final int isActive;
  final String profileImage;
  final dynamic connectUserId;
  final String applicantName;
  final String socialSecurityNumber;
  final String dateOfBirth;
  final String currentStreet;
  final String currentCity;
  final String currentState;
  final String currentDate;
  final String priorAddress;
  final String priorCity;
  final String priorState;
  final String priorStartDate;
  final String priorEndDate;
  final String license;
  final String licenseState;
  final String signature;
  final String signatureDate;
  final int queryType;
  final dynamic purpose;
  final dynamic price;
  final dynamic downAmount;
  final dynamic propertyType;
  final dynamic location;
  final int agent;
  final dynamic occupation;
  final dynamic currentEmployer;
  final dynamic annualIncome;
  final dynamic creditScore;
  final dynamic contactInfomation;
  final String profileImageUrl;

  CrmDetailsModel copyWith({
    int? id,
    String? name,
    String? title,
    dynamic ccode,
    String? phone,
    String? email,
    String? companyName,
    String? message,
    int? userId,
    int? cardId,
    String? createdAt,
    String? updatedAt,
    dynamic createdBy,
    int? updatedBy,
    int? isActive,
    String? profileImage,
    dynamic connectUserId,
    String? applicantName,
    String? socialSecurityNumber,
    String? dateOfBirth,
    String? currentStreet,
    String? currentCity,
    String? currentState,
    String? currentDate,
    String? priorAddress,
    String? priorCity,
    String? priorState,
    String? priorStartDate,
    String? priorEndDate,
    String? license,
    String? licenseState,
    String? signature,
    String? signatureDate,
    int? queryType,
    dynamic purpose,
    dynamic price,
    dynamic downAmount,
    dynamic propertyType,
    dynamic location,
    int? agent,
    dynamic occupation,
    dynamic currentEmployer,
    dynamic annualIncome,
    dynamic creditScore,
    dynamic contactInfomation,
    String? profileImageUrl,

  }) =>
      CrmDetailsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        title: title ?? this.title,
        ccode: ccode ?? this.ccode,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        companyName: companyName ?? this.companyName,
        message: message ?? this.message,
        userId: userId ?? this.userId,
        cardId: cardId ?? this.cardId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        isActive: isActive ?? this.isActive,
        profileImage: profileImage ?? this.profileImage,
        connectUserId: connectUserId ?? this.connectUserId,
        applicantName: applicantName ?? this.applicantName,
        socialSecurityNumber: socialSecurityNumber ?? this.socialSecurityNumber,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        currentStreet: currentStreet ?? this.currentStreet,
        currentCity: currentCity ?? this.currentCity,
        currentState: currentState ?? this.currentState,
        currentDate: currentDate ?? this.currentDate,
        priorAddress: priorAddress ?? this.priorAddress,
        priorCity: priorCity ?? this.priorCity,
        priorState: priorState ?? this.priorState,
        priorStartDate: priorStartDate ?? this.priorStartDate,
        priorEndDate: priorEndDate ?? this.priorEndDate,
        license: license ?? this.license,
        licenseState: licenseState ?? this.licenseState,
        signature: signature ?? this.signature,
        signatureDate: signatureDate ?? this.signatureDate,
        queryType: queryType ?? this.queryType,
        purpose: purpose ?? this.purpose,
        price: price ?? this.price,
        downAmount: downAmount ?? this.downAmount,
        propertyType: propertyType ?? this.propertyType,
        location: location ?? this.location,
        agent: agent ?? this.agent,
        occupation: occupation ?? this.occupation,
        currentEmployer: currentEmployer ?? this.currentEmployer,
        annualIncome: annualIncome ?? this.annualIncome,
        creditScore: creditScore ?? this.creditScore,
        contactInfomation: contactInfomation ?? this.contactInfomation,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,

      );

  factory CrmDetailsModel.fromRawJson(String str) => CrmDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CrmDetailsModel.fromJson(Map<String, dynamic> json) => CrmDetailsModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    title: json["title"] ?? '',
    ccode: json["ccode"] ?? '',
    phone: json["phone"] ?? '',
    email: json["email"] ?? '',
    companyName: json["company_name"] ?? '',
    message: json["message"] ?? '',
    userId: json["user_id"] ?? 0,
    cardId: json["card_id"] ?? 0,
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    createdBy: json["created_by"] ?? '',
    updatedBy: json["updated_by"] ?? 0,
    isActive: json["is_active"] ?? 0,
    profileImage: json["profile_image"] ?? '',
    connectUserId: json["connect_user_id"] ?? '',
    applicantName: json["applicant_name"] ?? '',
    socialSecurityNumber: json["social_security_number"] ?? '',
    dateOfBirth: json["date_of_birth"] ?? '',
    currentStreet: json["current_street"] ?? '---',
    currentCity: json["current_city"] ?? '---',
    currentState: json["current_state"] ?? '---',
    currentDate: json["current_date"] ?? '',
    priorAddress: json["prior_address"] ?? '---',
    priorCity: json["prior_city"] ?? '---',
    priorState: json["prior_state"] ?? '',
    priorStartDate: json["prior_start_date"] ?? '',
    priorEndDate: json["prior_end_date"] ?? '',
    license: json["license"] ?? '',
    licenseState: json["license_state"] ?? '',
    signature: json["signature"] ?? '',
    signatureDate: json["signature_date"] ?? '',
    queryType: json["query_type"] ?? 0,
    purpose: json["purpose"] ?? '',
    price: json["price"] ?? '',
    downAmount: json["down_amount"] ?? '',
    propertyType: json["property_type"] ?? '',
    location: json["location"] ?? '',
    agent: json["agent"] ?? 0,
    occupation: json["occupation"] ?? '',
    currentEmployer: json["current_employer"] ?? '',
    annualIncome: json["annual_income"] ?? '',
    creditScore: json["credit_score"] ?? '',
    contactInfomation: json["contact_infomation"] ?? '',
    profileImageUrl: json["profile_image_url"] ?? '',

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "ccode": ccode,
    "phone": phone,
    "email": email,
    "company_name": companyName,
    "message": message,
    "user_id": userId,
    "card_id": cardId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "is_active": isActive,
    "profile_image": profileImage,
    "connect_user_id": connectUserId,
    "applicant_name": applicantName,
    "social_security_number": socialSecurityNumber,
    "date_of_birth": dateOfBirth,
    "current_street": currentStreet,
    "current_city": currentCity,
    "current_state": currentState,
    "current_date": currentDate,
    "prior_address": priorAddress,
    "prior_city": priorCity,
    "prior_state": priorState,
    "prior_start_date": priorStartDate,
    "prior_end_date": priorEndDate,
    "license": license,
    "license_state": licenseState,
    "signature": signature,
    "signature_date": signatureDate,
    "query_type": queryType,
    "purpose": purpose,
    "price": price,
    "down_amount": downAmount,
    "property_type": propertyType,
    "location": location,
    "agent": agent,
    "occupation": occupation,
    "current_employer": currentEmployer,
    "annual_income": annualIncome,
    "credit_score": creditScore,
    "contact_infomation": contactInfomation,
    "profile_image_url": profileImageUrl,

  };
}
