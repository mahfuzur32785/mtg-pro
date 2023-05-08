import 'dart:convert';

class UserPlanDetails {
  UserPlanDetails({
    required this.id,
    required this.planType,
    required this.planId,
    required this.planName,
    required this.planDescription,
    required this.isFree,
    required this.planPriceMonthly,
    required this.planPriceYearly,
    required this.planPrice,
    required this.discountPercentage,
    required this.validity,
    required this.noOfVcards,
    required this.noOfServices,
    required this.noOfGalleries,
    required this.noOfFeatures,
    required this.noOfPayments,
    required this.personalizedLink,
    required this.hideBranding,
    required this.freeSetup,
    required this.freeSupport,
    required this.recommended,
    required this.isWatermarkEnabled,
    required this.features,
    required this.plansType,
    required this.name,
    required this.slug,
    required this.stripePlanId,
    required this.stripeData,
    required this.stripeDataYearly,
    required this.stripePlanIdYearly,
    required this.paypalPlanId,
    required this.paypalPlanData,
    required this.cost,
    required this.status,
    required this.shareable,
    required this.createdAt,
    required this.updatedAt,
    required this.isVcard,
    required this.isWhatsappStore,
    required this.isEmailSignature,
    required this.isQrCode,
    required this.isYearlyPlan,
    required this.freeMarketingMaterial,
  });

  final int id;
  final dynamic planType;
  final String planId;
  final String planName;
  final String planDescription;
  final int isFree;
  final int planPriceMonthly;
  final int planPriceYearly;
  final String planPrice;
  final int discountPercentage;
  final String validity;
  final String noOfVcards;
  final int noOfServices;
  final int noOfGalleries;
  final int noOfFeatures;
  final int noOfPayments;
  final String personalizedLink;
  final String hideBranding;
  final String freeSetup;
  final String freeSupport;
  final String recommended;
  final String isWatermarkEnabled;
  final String features;
  final int plansType;
  final String name;
  final String slug;
  final String stripePlanId;
  final String stripeData;
  final String stripeDataYearly;
  final String stripePlanIdYearly;
  final dynamic paypalPlanId;
  final dynamic paypalPlanData;
  final dynamic cost;
  final String status;
  final int shareable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isVcard;
  final int isWhatsappStore;
  final int isEmailSignature;
  final int isQrCode;
  final int isYearlyPlan;
  final int freeMarketingMaterial;

  UserPlanDetails copyWith({
    int? id,
    dynamic planType,
    String? planId,
    String? planName,
    String? planDescription,
    int? isFree,
    int? planPriceMonthly,
    int? planPriceYearly,
    String? planPrice,
    int? discountPercentage,
    String? validity,
    String? noOfVcards,
    int? noOfServices,
    int? noOfGalleries,
    int? noOfFeatures,
    int? noOfPayments,
    String? personalizedLink,
    String? hideBranding,
    String? freeSetup,
    String? freeSupport,
    String? recommended,
    String? isWatermarkEnabled,
    String? features,
    int? plansType,
    String? name,
    String? slug,
    String? stripePlanId,
    String? stripeData,
    String? stripeDataYearly,
    String? stripePlanIdYearly,
    dynamic paypalPlanId,
    dynamic paypalPlanData,
    dynamic cost,
    String? status,
    int? shareable,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? isVcard,
    int? isWhatsappStore,
    int? isEmailSignature,
    int? isQrCode,
    int? isYearlyPlan,
    int? freeMarketingMaterial,
  }) =>
      UserPlanDetails(
        id: id ?? this.id,
        planType: planType ?? this.planType,
        planId: planId ?? this.planId,
        planName: planName ?? this.planName,
        planDescription: planDescription ?? this.planDescription,
        isFree: isFree ?? this.isFree,
        planPriceMonthly: planPriceMonthly ?? this.planPriceMonthly,
        planPriceYearly: planPriceYearly ?? this.planPriceYearly,
        planPrice: planPrice ?? this.planPrice,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        validity: validity ?? this.validity,
        noOfVcards: noOfVcards ?? this.noOfVcards,
        noOfServices: noOfServices ?? this.noOfServices,
        noOfGalleries: noOfGalleries ?? this.noOfGalleries,
        noOfFeatures: noOfFeatures ?? this.noOfFeatures,
        noOfPayments: noOfPayments ?? this.noOfPayments,
        personalizedLink: personalizedLink ?? this.personalizedLink,
        hideBranding: hideBranding ?? this.hideBranding,
        freeSetup: freeSetup ?? this.freeSetup,
        freeSupport: freeSupport ?? this.freeSupport,
        recommended: recommended ?? this.recommended,
        isWatermarkEnabled: isWatermarkEnabled ?? this.isWatermarkEnabled,
        features: features ?? this.features,
        plansType: plansType ?? this.plansType,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        stripePlanId: stripePlanId ?? this.stripePlanId,
        stripeData: stripeData ?? this.stripeData,
        stripeDataYearly: stripeDataYearly ?? this.stripeDataYearly,
        stripePlanIdYearly: stripePlanIdYearly ?? this.stripePlanIdYearly,
        paypalPlanId: paypalPlanId ?? this.paypalPlanId,
        paypalPlanData: paypalPlanData ?? this.paypalPlanData,
        cost: cost ?? this.cost,
        status: status ?? this.status,
        shareable: shareable ?? this.shareable,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isVcard: isVcard ?? this.isVcard,
        isWhatsappStore: isWhatsappStore ?? this.isWhatsappStore,
        isEmailSignature: isEmailSignature ?? this.isEmailSignature,
        isQrCode: isQrCode ?? this.isQrCode,
        isYearlyPlan: isYearlyPlan ?? this.isYearlyPlan,
        freeMarketingMaterial: freeMarketingMaterial ?? this.freeMarketingMaterial,
      );

  factory UserPlanDetails.fromJson(String str) => UserPlanDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserPlanDetails.fromMap(Map<String, dynamic> json) => UserPlanDetails(
    id: json["id"],
    planType: json["plan_type"],
    planId: json["plan_id"] ?? '',
    planName: json["plan_name"] ?? '',
    planDescription: json["plan_description"] ?? '',
    isFree: json["is_free"] ?? 0,
    planPriceMonthly: json["plan_price_monthly"] ?? 0,
    planPriceYearly: json["plan_price_yearly"] ?? 0,
    planPrice: json["plan_price"] ?? '',
    discountPercentage: json["discount_percentage"] ?? 0,
    validity: json["validity"] ?? '',
    noOfVcards: json["no_of_vcards"] ?? '',
    noOfServices: json["no_of_services"] ?? 0,
    noOfGalleries: json["no_of_galleries"] ?? 0,
    noOfFeatures: json["no_of_features"] ?? 0,
    noOfPayments: json["no_of_payments"] ?? 0,
    personalizedLink: json["personalized_link"] ?? '',
    hideBranding: json["hide_branding"] ?? '',
    freeSetup: json["free_setup"] ?? '',
    freeSupport: json["free_support"] ?? '',
    recommended: json["recommended"],
    isWatermarkEnabled: json["is_watermark_enabled"] ?? '',
    features: json["features"] ?? '',
    plansType: json["plans_type"] ?? 0,
    name: json["name"] ?? '',
    slug: json["slug"] ?? '',
    stripePlanId: json["stripe_plan_id"] ?? '',
    stripeData: json["stripe_data"] ?? '',
    stripeDataYearly: json["stripe_data_yearly"] ?? '',
    stripePlanIdYearly: json["stripe_plan_id_yearly"] ?? '',
    paypalPlanId: json["paypal_plan_id"],
    paypalPlanData: json["paypal_plan_data"],
    cost: json["cost"],
    status: json["status"] ?? 1,
    shareable: json["shareable"] ?? 0,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isVcard: json["is_vcard"] ?? 0,
    isWhatsappStore: json["is_whatsapp_store"] ?? 0,
    isEmailSignature: json["is_email_signature"] ?? 0,
    isQrCode: json["is_qr_code"] ?? 0,
    isYearlyPlan: json["is_yearly_plan"] ?? 0,
    freeMarketingMaterial: json["free_marketing_material"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "plan_type": planType,
    "plan_id": planId,
    "plan_name": planName,
    "plan_description": planDescription,
    "is_free": isFree,
    "plan_price_monthly": planPriceMonthly,
    "plan_price_yearly": planPriceYearly,
    "plan_price": planPrice,
    "discount_percentage": discountPercentage,
    "validity": validity,
    "no_of_vcards": noOfVcards,
    "no_of_services": noOfServices,
    "no_of_galleries": noOfGalleries,
    "no_of_features": noOfFeatures,
    "no_of_payments": noOfPayments,
    "personalized_link": personalizedLink,
    "hide_branding": hideBranding,
    "free_setup": freeSetup,
    "free_support": freeSupport,
    "recommended": recommended,
    "is_watermark_enabled": isWatermarkEnabled,
    "features": features,
    "plans_type": plansType,
    "name": name,
    "slug": slug,
    "stripe_plan_id": stripePlanId,
    "stripe_data": stripeData,
    "stripe_data_yearly": stripeDataYearly,
    "stripe_plan_id_yearly": stripePlanIdYearly,
    "paypal_plan_id": paypalPlanId,
    "paypal_plan_data": paypalPlanData,
    "cost": cost,
    "status": status,
    "shareable": shareable,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "is_vcard": isVcard,
    "is_whatsapp_store": isWhatsappStore,
    "is_email_signature": isEmailSignature,
    "is_qr_code": isQrCode,
    "is_yearly_plan": isYearlyPlan,
    "free_marketing_material": freeMarketingMaterial,
  };
}