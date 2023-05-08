import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mtgpro/app/modules/login/model/user_plan_details.dart';

class UserProfileModel extends Equatable {
  final String name;
  final String email;
  final String username;
  final dynamic gender;
  final dynamic dob;
  final String profileImage;
  final dynamic socialId;
  final dynamic provider;
  final int status;
  final int roleId;
  final int userType;
  final int planId;
  final UserPlanDetails planDetails;
  final String planValidity;
  final String planActivationDate;
  final String term;
  final String billingCountry;
  final String billingCountryCode;
  final String billingState;
  final String billingCity;
  final dynamic billingZipcode;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;
  final int cardCount;
  final String userDisclaimer;
  final int housingLogoView;
  final int disclaimerView;
  final int formView;
  final int creditAuthorization;
  final String nmlsId;
  final int nmlsView;
  final int quickApplication;

  const UserProfileModel({
    required this.name,
    required this.email,
    required this.username,
    required this.gender,
    required this.dob,
    required this.profileImage,
    required this.socialId,
    required this.provider,
    required this.status,
    required this.roleId,
    required this.userType,
    required this.planId,
    required this.planDetails,
    required this.planValidity,
    required this.planActivationDate,
    required this.term,
    required this.billingCountry,
    required this.billingCountryCode,
    required this.billingState,
    required this.billingCity,
    required this.billingZipcode,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.cardCount,
    required this.userDisclaimer,
    required this.housingLogoView,
    required this.disclaimerView,
    required this.formView,
    required this.creditAuthorization,
    required this.nmlsId,
    required this.nmlsView,
    required this.quickApplication,
  });

  UserProfileModel copyWith({
    String? name,
    String? email,
    String? username,
    dynamic gender,
    dynamic dob,
    String? profileImage,
    dynamic socialId,
    dynamic provider,
    int? status,
    int? roleId,
    int? userType,
    int? planId,
    UserPlanDetails? planDetails,
    String? planValidity,
    String? planActivationDate,
    String? term,
    String? billingCountry,
    String? billingCountryCode,
    String? billingState,
    String? billingCity,
    dynamic billingZipcode,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
    int? cardCount,
    String? userDisclaimer,
    int? housingLogoView,
    int? disclaimerView,
    int? formView,
    int? creditAuthorization,
    String? nmlsId,
    int? nmlsView,
    int? quickApplication,
  }) {
    return UserProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      profileImage: profileImage ?? this.profileImage,
      socialId: socialId ?? this.socialId,
      provider: provider ?? this.provider,
      status: status ?? this.status,
      roleId: roleId ?? this.roleId,
      userType: userType ?? this.userType,
      planId: planId ?? this.planId,
      planDetails: planDetails ?? this.planDetails,
      planValidity: planValidity ?? this.planValidity,
      planActivationDate: planActivationDate ?? this.planActivationDate,
      term: term ?? this.term,
      billingCountry: billingCountry ?? this.billingCountry,
      billingCountryCode: billingCountryCode ?? this.billingCountryCode,
      billingState: billingState ?? this.billingState,
      billingCity: billingCity ?? this.billingCity,
      billingZipcode: billingZipcode ?? this.billingZipcode,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      cardCount: cardCount ?? this.cardCount,
      userDisclaimer: userDisclaimer ?? this.userDisclaimer,
      housingLogoView: housingLogoView ?? this.housingLogoView,
      disclaimerView: disclaimerView ?? this.disclaimerView,
      formView: formView ?? this.formView,
      creditAuthorization: creditAuthorization ?? this.creditAuthorization,
      nmlsId: nmlsId ?? this.nmlsId,
      nmlsView: nmlsView ?? this.nmlsView,
      quickApplication: quickApplication ?? this.quickApplication,
    );
  }

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "username": username,
    "gender": gender,
    "dob": dob,
    "profile_image_url": profileImage,
    "social_id": socialId,
    "provider": provider,
    "status": status,
    "role_id": roleId,
    "user_type": userType,
    "plan_id": planId,
    "plan_details": planDetails.toMap(),
    "plan_validity": planValidity,
    "plan_activation_date": planActivationDate,
    "term": term,
    "billing_country": billingCountry,
    "billing_country_code": billingCountryCode,
    "billing_state": billingState,
    "billing_city": billingCity,
    "billing_zipcode": billingZipcode,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
    "card_count": cardCount,
    "user_disclaimer": userDisclaimer,
    "housing_logo_view": housingLogoView,
    "disclaimer_view": disclaimerView,
    "form_view": formView,
    "credit_authorization": creditAuthorization,
    "nmls_id": nmlsId,
    "nmls_view": nmlsView,
    "quick_application": quickApplication,
  };

  factory UserProfileModel.fromMap(Map<String, dynamic> json) => UserProfileModel(
    name: json["name"] ?? '',
    email: json["email"] ?? '',
    username: json["username"] ?? '',
    gender: json["gender"],
    dob: json["dob"],
    profileImage: json["profile_image_url"] ?? '',
    socialId: json["social_id"],
    provider: json["provider"],
    status: json["status"] ?? 0,
    roleId: json["role_id"] ?? 0,
    userType: json["user_type"] ?? 0,
    planId: json["plan_id"] ?? 0,
    planDetails: UserPlanDetails.fromMap(json["plan_details"]),
    planValidity: json["plan_validity"] ?? '0',
    planActivationDate: json["plan_activation_date"] ?? '',
    term: json["term"],
    billingCountry: json["billing_country"] ?? '',
    billingCountryCode: json["billing_country_code"] ?? '',
    billingState: json["billing_state"] ?? '',
    billingCity: json["billing_city"] ?? '',
    billingZipcode: json["billing_zipcode"] ?? '',
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"] ?? 0,
    cardCount: json["card_count"] ?? 0,
    userDisclaimer: json["user_disclaimer"] ?? '',
    housingLogoView: json["housing_logo_view"] ?? 0,
    disclaimerView: json["disclaimer_view"] ?? 0,
    formView: json["form_view"] ?? 0,
    creditAuthorization: json["credit_authorization"] ?? 0,
    nmlsId: json["nmls_id"] ?? '',
    nmlsView: json["nmls_view"] ?? 0,
    quickApplication: json["quick_application"] ?? 0,
  );

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileModel(id: $id, name: $name, username: $username, gender: $gender, dob: $dob, profile_image: $profileImage, email: $email, social_id: $socialId, provider: $provider, status: $status, role_id: $roleId, user_type: $userType, plan_id: $planId, plan_details: $planDetails, plan_validity: $planValidity, plan_activation_date: $planActivationDate, term: $term, billing_country: $billingCountry, billing_country_code: $billingCountryCode, billing_state: $billingState, billing_city: $billingCity, billing_zipcode: $billingZipcode, created_at: $createdAt, updated_at: $updatedAt, card_count: $cardCount, user_disclaimer: $userDisclaimer, "housing_logo_view": $housingLogoView, disclaimer_view: $disclaimerView, form_view: $formView, credit_authorization: $creditAuthorization, nmls_id: $nmlsId, nmls_view: $nmlsView, quick_application: $quickApplication)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      username,
      email,
      gender,
      dob,
      profileImage,
      socialId,
      provider,
      status,
      roleId,
      userType,
      planId,
      planDetails,
      planValidity,
      planActivationDate,
      term,
      billingCountry,
      billingCountryCode,
      billingState,
      billingCity,
      billingZipcode,
      cardCount,
      createdAt,
      updatedAt,
      userDisclaimer,
      housingLogoView,
      disclaimerView,
      formView,
      creditAuthorization,
      nmlsId,
      nmlsView,
      quickApplication,
    ];
  }

}
