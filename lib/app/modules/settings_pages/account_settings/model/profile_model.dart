import 'dart:convert';

class ProfileModel {
  ProfileModel({
    required this.id,
    required this.name,
    required this.lname,
    required this.email,
    required this.username,
    required this.billingCountryCode,
    required this.roleId,
    required this.userType,
    required this.emailVerified,
    required this.profileImage,
    required this.planId,
    required this.planValidity,
    required this.planActivationDate,
    required this.billingName,
    required this.billingAddress,
    required this.billingCity,
    required this.billingState,
    required this.billingZipcode,
    required this.billingCountry,
    required this.billingPhone,
    required this.billingEmail,
    required this.status,
    required this.stripeCustomerId,
    required this.gender,
    required this.countryCode,
    required this.ccode,
    required this.phone,
    required this.avatar,
    required this.provider,
    required this.socialId,
    required this.dob,
    required this.designation,
    required this.companyName,
    required this.companyWebsiteLink,
    required this.activeCardId,
    required this.connectionTitle,
    required this.userDisclaimer,
    required this.isNotify,
    required this.planDuration,
    required this.remainingDays,
  });

  final int id;
  final String name;
  final String lname;
  final String email;
  final String username;
  final String billingCountryCode;
  final int roleId;
  final int userType;
  final int emailVerified;
  final String profileImage;
  final String planId;
  final String planValidity;
  final String planActivationDate;
  final String billingName;
  final String billingAddress;
  final String billingCity;
  final String billingState;
  final String billingZipcode;
  final String billingCountry;
  final String billingPhone;
  final String billingEmail;
  final int status;
  final dynamic stripeCustomerId;
  final String gender;
  final String countryCode;
  final String ccode;
  final String phone;
  final String avatar;
  final String provider;
  final dynamic socialId;
  final String dob;
  final String designation;
  final String companyName;
  final String companyWebsiteLink;
  final int activeCardId;
  final String connectionTitle;
  final String userDisclaimer;
  final int isNotify;
  final String planDuration;
  final int remainingDays;

  ProfileModel copyWith({
    int? id,
    String? name,
    String? lname,
    String? email,
    String? username,
    String? billingCountryCode,
    int? roleId,
    int? userType,
    int? emailVerified,
    String? profileImage,
    String? planId,
    String? planValidity,
    String? planActivationDate,
    String? billingName,
    String? billingAddress,
    String? billingCity,
    String? billingState,
    String? billingZipcode,
    String? billingCountry,
    String? billingPhone,
    String? billingEmail,
    int? status,
    dynamic stripeCustomerId,
    String? gender,
    String? countryCode,
    String? ccode,
    String? phone,
    String? avatar,
    String? provider,
    dynamic socialId,
    String? dob,
    String? designation,
    String? companyName,
    String? companyWebsiteLink,
    int? activeCardId,
    String? connectionTitle,
    String? userDisclaimer,
    int? isNotify,
    String? planDuration,
    int? remainingDays,
  }) =>
      ProfileModel(
        id: id ?? this.id,
        name: name ?? this.name,
        lname: lname ?? this.lname,
        email: email ?? this.email,
        username: username ?? this.username,
        billingCountryCode: billingCountryCode ?? this.billingCountryCode,
        roleId: roleId ?? this.roleId,
        userType: userType ?? this.userType,
        emailVerified: emailVerified ?? this.emailVerified,
        profileImage: profileImage ?? this.profileImage,
        planId: planId ?? this.planId,
        planValidity: planValidity ?? this.planValidity,
        planActivationDate: planActivationDate ?? this.planActivationDate,
        billingName: billingName ?? this.billingName,
        billingAddress: billingAddress ?? this.billingAddress,
        billingCity: billingCity ?? this.billingCity,
        billingState: billingState ?? this.billingState,
        billingZipcode: billingZipcode ?? this.billingZipcode,
        billingCountry: billingCountry ?? this.billingCountry,
        billingPhone: billingPhone ?? this.billingPhone,
        billingEmail: billingEmail ?? this.billingEmail,
        status: status ?? this.status,
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
        gender: gender ?? this.gender,
        countryCode: countryCode ?? this.countryCode,
        ccode: ccode ?? this.ccode,
        phone: phone ?? this.phone,
        avatar: avatar ?? this.avatar,
        provider: provider ?? this.provider,
        socialId: socialId ?? this.socialId,
        dob: dob ?? this.dob,
        designation: designation ?? this.designation,
        companyName: companyName ?? this.companyName,
        companyWebsiteLink: companyWebsiteLink ?? this.companyWebsiteLink,
        activeCardId: activeCardId ?? this.activeCardId,
        connectionTitle: connectionTitle ?? this.connectionTitle,
        userDisclaimer: userDisclaimer ?? this.userDisclaimer,
        isNotify: isNotify ?? this.isNotify,
        planDuration: planDuration ?? this.planDuration,
        remainingDays: remainingDays ?? this.remainingDays,
      );

  factory ProfileModel.fromJson(String str) => ProfileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    lname: json["lname"] ?? '',
    email: json["email"] ?? '',
    username: json["username"] ?? '',
    billingCountryCode: json["billing_country_code"] ?? '',
    roleId: json["role_id"] ?? 0,
    userType: json["user_type"] ?? 0,
    emailVerified: json["email_verified"] ?? 0,
    profileImage: json["profile_image"] ?? '',
    planId: json["plan_id"] ?? '',
    planValidity: json["plan_validity"] ?? '',
    planActivationDate: json["plan_activation_date"] ?? '',
    billingName: json["billing_name"] ?? '',
    billingAddress: json["billing_address"] ?? '',
    billingCity: json["billing_city"] ?? '',
    billingState: json["billing_state"] ?? '',
    billingZipcode: json["billing_zipcode"] ?? '',
    billingCountry: json["billing_country"] ?? '',
    billingPhone: json["billing_phone"] ?? '',
    billingEmail: json["billing_email"] ?? '',
    status: json["status"] ?? 0,
    stripeCustomerId: json["stripe_customer_id"],
    gender: json["gender"] ?? '',
    countryCode: json["country_code"] ?? '',
    ccode: json["ccode"] ?? '',
    phone: json["phone"] ?? '',
    avatar: json["avatar"] ?? '',
    provider: json["provider"] ?? '',
    socialId: json["social_id"] ?? '',
    dob: json["dob"] ?? '',
    designation: json["designation"] ?? '',
    companyName: json["company_name"] ?? '',
    companyWebsiteLink: json["company_websitelink"] ?? '',
    activeCardId: json["active_card_id"] ?? 0,
    connectionTitle: json["connection_title"] ?? '',
    userDisclaimer: json["user_disclaimer"] ?? '',
    isNotify: json["is_notify"] ?? 0,
    planDuration: json["plan_duration"] ?? '',
    remainingDays: json["remainng_days"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "lname": lname,
    "email": email,
    "username": username,
    "billing_country_code": billingCountryCode,
    "role_id": roleId,
    "user_type": userType,
    "email_verified": emailVerified,
    "profile_image": profileImage,
    "plan_id": planId,
    "plan_validity": planValidity,
    "plan_activation_date": planActivationDate,
    "billing_name": billingName,
    "billing_address": billingAddress,
    "billing_city": billingCity,
    "billing_state": billingState,
    "billing_zipcode": billingZipcode,
    "billing_country": billingCountry,
    "billing_phone": billingPhone,
    "billing_email": billingEmail,
    "status": status,
    "stripe_customer_id": stripeCustomerId,
    "gender": gender,
    "country_code": countryCode,
    "ccode": ccode,
    "phone": phone,
    "avatar": avatar,
    "provider": provider,
    "social_id": socialId,
    "dob": dob,
    "designation": designation,
    "company_name": companyName,
    "company_websitelink": companyWebsiteLink,
    "active_card_id": activeCardId,
    "connection_title": connectionTitle,
    "user_disclaimer": userDisclaimer,
    "is_notify": isNotify,
    "plan_duration": planDuration,
    "remainng_days": remainingDays,
  };
}