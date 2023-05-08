import 'dart:convert';

class StripeData {
  StripeData({
    required this.id,
    required this.object,
    required this.active,
    required this.aggregateUsage,
    required this.amount,
    required this.amountDecimal,
    required this.billingScheme,
    required this.created,
    required this.currency,
    required this.interval,
    required this.intervalCount,
    required this.liveMode,
    required this.metadata,
    required this.nickname,
    required this.product,
    required this.tiersMode,
    required this.transformUsage,
    required this.trialPeriodDays,
    required this.usageType,
  });

  final String id;
  final String object;
  final bool active;
  final dynamic aggregateUsage;
  final int amount;
  final String amountDecimal;
  final String billingScheme;
  final int created;
  final String currency;
  final String interval;
  final int intervalCount;
  final bool liveMode;
  final List<dynamic> metadata;
  final dynamic nickname;
  final String product;
  final dynamic tiersMode;
  final dynamic transformUsage;
  final dynamic trialPeriodDays;
  final String usageType;

  StripeData copyWith({
    String? id,
    String? object,
    bool? active,
    dynamic aggregateUsage,
    int? amount,
    String? amountDecimal,
    String? billingScheme,
    int? created,
    String? currency,
    String? interval,
    int? intervalCount,
    bool? liveMode,
    List<dynamic>? metadata,
    dynamic nickname,
    String? product,
    dynamic tiersMode,
    dynamic transformUsage,
    dynamic trialPeriodDays,
    String? usageType,
  }) =>
      StripeData(
        id: id ?? this.id,
        object: object ?? this.object,
        active: active ?? this.active,
        aggregateUsage: aggregateUsage ?? this.aggregateUsage,
        amount: amount ?? this.amount,
        amountDecimal: amountDecimal ?? this.amountDecimal,
        billingScheme: billingScheme ?? this.billingScheme,
        created: created ?? this.created,
        currency: currency ?? this.currency,
        interval: interval ?? this.interval,
        intervalCount: intervalCount ?? this.intervalCount,
        liveMode: liveMode ?? this.liveMode,
        metadata: metadata ?? this.metadata,
        nickname: nickname ?? this.nickname,
        product: product ?? this.product,
        tiersMode: tiersMode ?? this.tiersMode,
        transformUsage: transformUsage ?? this.transformUsage,
        trialPeriodDays: trialPeriodDays ?? this.trialPeriodDays,
        usageType: usageType ?? this.usageType,
      );

  factory StripeData.fromJson(String str) => StripeData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StripeData.fromMap(Map<String, dynamic> json) => StripeData(
    id: json["id"],
    object: json["object"],
    active: json["active"],
    aggregateUsage: json["aggregate_usage"],
    amount: json["amount"],
    amountDecimal: json["amount_decimal"],
    billingScheme: json["billing_scheme"],
    created: json["created"],
    currency: json["currency"],
    interval: json["interval"],
    intervalCount: json["interval_count"],
    liveMode: json["livemode"],
    metadata: List<dynamic>.from(json["metadata"].map((x) => x)),
    nickname: json["nickname"],
    product: json["product"],
    tiersMode: json["tiers_mode"],
    transformUsage: json["transform_usage"],
    trialPeriodDays: json["trial_period_days"],
    usageType: json["usage_type"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "object": object,
    "active": active,
    "aggregate_usage": aggregateUsage,
    "amount": amount,
    "amount_decimal": amountDecimal,
    "billing_scheme": billingScheme,
    "created": created,
    "currency": currency,
    "interval": interval,
    "interval_count": intervalCount,
    "livemode": liveMode,
    "metadata": List<dynamic>.from(metadata.map((x) => x)),
    "nickname": nickname,
    "product": product,
    "tiers_mode": tiersMode,
    "transform_usage": transformUsage,
    "trial_period_days": trialPeriodDays,
    "usage_type": usageType,
  };
}