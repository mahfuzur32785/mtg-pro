import 'dart:convert';

class CrmListResponseModel {
  CrmListResponseModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int currentPage;
  final List<CrmModel> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final int to;
  final int total;

  CrmListResponseModel copyWith({
    int? currentPage,
    List<CrmModel>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      CrmListResponseModel(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory CrmListResponseModel.fromRawJson(String str) => CrmListResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CrmListResponseModel.fromJson(Map<String, dynamic> json) => CrmListResponseModel(
    currentPage: json["current_page"]??0,
    data: List<CrmModel>.from(json["data"].map((x) => CrmModel.fromJson(x))),
    firstPageUrl: json["first_page_url"]??'',
    from: json["from"] ?? 0,
    lastPage: json["last_page"]??0,
    lastPageUrl: json["last_page_url"]??'',
    nextPageUrl: json["next_page_url"],
    path: json["path"]??'',
    perPage: json["per_page"]?? 0,
    prevPageUrl: json["prev_page_url"]??'',
    to: json["to"] ?? 0,
    total: json["total"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class CrmModel {
  CrmModel({
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
    required this.userImage,
    required this.profileImageUrl,
    required this.isSelect,
  });

  final int id;
  final String name;
  final String title;
  final dynamic ccode;
  final String phone;
  final String email;
  final String companyName;
  final String message;
  final int userId;
  final int cardId;
  final String createdAt;
  final String updatedAt;
  final dynamic createdBy;
  final int updatedBy;
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
  final String purpose;
  final String price;
  final String downAmount;
  final String propertyType;
  final String location;
  final int agent;
  final String occupation;
  final String currentEmployer;
  final String annualIncome;
  final String creditScore;
  final dynamic contactInfomation;
  final String userImage;
  final String profileImageUrl;
  final bool isSelect;

  CrmModel copyWith({
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
    String? purpose,
    String? price,
    String? downAmount,
    String? propertyType,
    String? location,
    int? agent,
    String? occupation,
    String? currentEmployer,
    String? annualIncome,
    String? creditScore,
    dynamic contactInfomation,
    String? userImage,
    String? profileImageUrl,
    bool? isSelect,
  }) =>
      CrmModel(
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
        userImage: userImage ?? this.userImage,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        isSelect: isSelect ?? this.isSelect,
      );

  factory CrmModel.fromRawJson(String str) => CrmModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CrmModel.fromJson(Map<String, dynamic> json) => CrmModel(
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
    createdAt: json["created_at"] ?? DateTime.now().toString(),
    updatedAt: json["updated_at"]?? "",
    createdBy: json["created_by"] ?? '',
    updatedBy: json["updated_by"] ?? 0,
    isActive: json["is_active"] ?? 0,
    profileImage: json["profile_image"]  ?? '',
    connectUserId: json["connect_user_id"]  ?? '',
    applicantName: json["applicant_name"]  ?? '',
    socialSecurityNumber: json["social_security_number"]  ?? '',
    dateOfBirth: json["date_of_birth"]  ?? '',
    currentStreet: json["current_street"]  ?? '',
    currentCity: json["current_city"]  ?? '',
    currentState: json["current_state"]  ?? '',
    currentDate: json["current_date"] ?? '',
    priorAddress: json["prior_address"] ?? '',
    priorCity: json["prior_city"] ?? '',
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
    agent: json["agent"] ?? '',
    occupation: json["occupation"] ?? '',
    currentEmployer: json["current_employer"] ?? '',
    annualIncome: json["annual_income"] ?? '',
    creditScore: json["credit_score"] ?? '',
    contactInfomation: json["contact_infomation"] ?? '',
    userImage: json["user_image"] ?? '',
    profileImageUrl: json["profile_image_url"] ?? '',
      isSelect: json['isSelect'] ?? false,
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
    "user_image": userImage,
    "profile_image_url": profileImageUrl,
    "isSelect": isSelect,
  };
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String url;
  final String label;
  final bool active;

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) =>
      Link(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] ?? '',
    label: json["label"] ?? '',
    active: json["active"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
