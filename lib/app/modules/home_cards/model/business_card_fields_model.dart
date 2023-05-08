import 'dart:convert';

import 'package:mtgpro/app/modules/home_cards/model/social_link_model.dart';

class BusinessCardField {
  BusinessCardField({
    required this.id,
    required this.cardId,
    required this.type,
    required this.icon,
    required this.iconImage,
    required this.iconId,
    required this.label,
    required this.content,
    required this.status,
    required this.socialLinkModel,
  });

  final int id;
  final int cardId;
  final String type;
  final String icon;
  final String iconImage;
  final int iconId;
  final String label;
  final String content;
  final int status;
  final SocialLinkModel socialLinkModel;

  BusinessCardField copyWith({
    int? id,
    int? cardId,
    String? type,
    String? icon,
    String? iconImage,
    int? iconId,
    String? label,
    String? content,
    int? status,
    SocialLinkModel? socialLinkModel,
  }) =>
      BusinessCardField(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        type: type ?? this.type,
        icon: icon ?? this.icon,
        iconImage: iconImage ?? this.iconImage,
        iconId: iconId ?? this.iconId,
        label: label ?? this.label,
        content: content ?? this.content,
        status: status ?? this.status,
        socialLinkModel: socialLinkModel ?? this.socialLinkModel,
      );

  factory BusinessCardField.fromJson(String str) => BusinessCardField.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessCardField.fromMap(Map<String, dynamic> json) => BusinessCardField(
    id: json["id"],
    cardId: json["card_id"],
    type: json["type"],
    icon: json["icon"],
    iconImage: json["icon_image"],
    iconId: json["icon_id"],
    label: json["label"],
    content: json["content"],
    status: json["status"] ?? 0,
    socialLinkModel: SocialLinkModel.fromMap(json["sicon"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "card_id": cardId,
    "type": type,
    "icon": icon,
    "icon_image": iconImage,
    "icon_id": iconId,
    "label": label,
    "content": content,
    "status": status,
    "sicon": socialLinkModel.toMap(),
  };
}