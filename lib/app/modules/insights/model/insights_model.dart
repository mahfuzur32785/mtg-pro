import 'dart:convert';

import 'package:mtgpro/app/core/utils/extensions.dart';

class InsightsModel {
  InsightsModel({
    required this.totalConnect,
    required this.totalCardView,
    required this.totalContactDownload,
    required this.totalQrcodeDownload,
    required this.totalCard,
    required this.currentPlan,
  });

  final int totalConnect;
  final int totalCardView;
  final int totalContactDownload;
  final int totalQrcodeDownload;
  final int totalCard;
  final CurrentPlan currentPlan;

  InsightsModel copyWith({
    int? totalConnect,
    int? totalCardView,
    int? totalContactDownload,
    int? totalQrcodeDownload,
    int? totalCard,
    CurrentPlan? currentPlan,
  }) =>
      InsightsModel(
        totalConnect: totalConnect ?? this.totalConnect,
        totalCardView: totalCardView ?? this.totalCardView,
        totalContactDownload: totalContactDownload ?? this.totalContactDownload,
        totalQrcodeDownload: totalQrcodeDownload ?? this.totalQrcodeDownload,
        totalCard: totalCard ?? this.totalCard,
        currentPlan: currentPlan ?? this.currentPlan,
      );

  factory InsightsModel.fromJson(String str) =>
      InsightsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InsightsModel.fromMap(Map<String, dynamic> json) => InsightsModel(
        totalConnect:
            json["total_connect"] == null || json["total_connect"] == ''
                ? 0
                : json["total_connect"] is String
                    ? int.parse(json["total_connect"] as String)
                    : json["total_connect"],
        totalCardView:
            json["total_card_view"] == null || json["total_card_view"] == ''
                ? 0
                : json["total_card_view"] is String
                    ? int.parse(json["total_card_view"] as String)
                    : json["total_card_view"],
        totalContactDownload:
        json["total_contact_download"] == null || json["total_contact_download"] == ''
            ? 0
            : json["total_contact_download"] is String
                ? int.parse(json["total_contact_download"] as String)
                : json["total_contact_download"],
        totalQrcodeDownload: json["total_qrcode_download"] == null ||
                json["total_qrcode_download"] == ''
            ? 0
            : json["total_qrcode_download"] is String
                ? int.parse(json["total_qrcode_download"] as String)
                : json["total_qrcode_download"],
        totalCard: json["total_card"] == null || json["total_card"] == ''
            ? 0
            : json["total_card"] is String
                ? int.parse(json["total_card"] as String)
                : json["total_card"],
        currentPlan: CurrentPlan.fromMap(json["current_plan"]),
      );

  Map<String, dynamic> toMap() => {
        "total_connect": totalConnect,
        "total_card_view": totalCardView,
        "total_contact_download": totalContactDownload,
        "total_qrcode_download": totalQrcodeDownload,
        "total_card": totalCard,
        "current_plan": currentPlan.toMap(),
      };
}

class CurrentPlan {
  CurrentPlan({
    required this.planName,
  });

  final String planName;

  CurrentPlan copyWith({
    String? planName,
  }) =>
      CurrentPlan(
        planName: planName ?? this.planName,
      );

  factory CurrentPlan.fromJson(String str) =>
      CurrentPlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CurrentPlan.fromMap(Map<String, dynamic> json) => CurrentPlan(
        planName: json["plan_name"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "plan_name": planName,
      };
}
