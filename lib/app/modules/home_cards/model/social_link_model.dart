import 'dart:convert';

import 'package:equatable/equatable.dart';

class SocialLinkModel extends Equatable {
  const SocialLinkModel({
    required this.id,
    required this.cardFieldId,
    required this.iconGroup,
    required this.icon,
    required this.iconName,
    required this.iconImage,
    required this.iconFa,
    required this.iconTitle,
    required this.label,
    required this.iconColor,
    required this.exampleText,
    required this.status,
    required this.content,
    required this.orderId,
    required this.type,
    required this.mainLink,
    required this.isPaid,
  });

  final int id;
  final int cardFieldId;
  final String iconGroup;
  final String icon;
  final String iconName;
  final String iconImage;
  final String iconFa;
  final String iconTitle;
  final String label;
  final String iconColor;
  final String exampleText;
  final int status;
  final String content;
  final int orderId;
  final String type;
  final String mainLink;
  final int isPaid;

  SocialLinkModel copyWith({
    int? id,
    int? cardFieldId,
    String? iconGroup,
    String? icon,
    String? iconName,
    String? iconImage,
    String? iconFa,
    String? iconTitle,
    String? label,
    String? iconColor,
    String? exampleText,
    int? status,
    String? content,
    int? orderId,
    String? type,
    String? mainLink,
    int? isPaid,
  }) =>
      SocialLinkModel(
        id: id ?? this.id,
        cardFieldId: cardFieldId ?? this.cardFieldId,
        iconGroup: iconGroup ?? this.iconGroup,
        icon: icon ?? this.icon,
        iconName: iconName ?? this.iconName,
        iconImage: iconImage ?? this.iconImage,
        iconFa: iconFa ?? this.iconFa,
        iconTitle: iconTitle ?? this.iconTitle,
        label: label ?? this.label,
        iconColor: iconColor ?? this.iconColor,
        exampleText: exampleText ?? this.exampleText,
        status: status ?? this.status,
        content: content ?? this.content,
        orderId: orderId ?? this.orderId,
        type: type ?? this.type,
        mainLink: mainLink ?? this.mainLink,
        isPaid: isPaid ?? this.isPaid,
      );

  factory SocialLinkModel.fromJson(String str) => SocialLinkModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialLinkModel.fromMap(Map<String, dynamic> json) => SocialLinkModel(
    id: json["id"] ?? 0,
    cardFieldId: json["cardFieldId"] ?? 0,
    iconGroup: json["icon_group"] ?? '',
    icon: json["icon"] ?? '',
    iconName: json["icon_name"] ?? '',
    iconImage: json["icon_image"] ?? '',
    iconFa: json["icon_fa"] ?? '',
    iconTitle: json["icon_title"] ?? '',
    label: json["label"] ?? '',
    iconColor: json["icon_color"] ?? '',
    exampleText: json["example_text"] ?? '',
    status: json["status"] ?? 0,
    content: json["content"] ?? '',
    orderId: json["order_id"] ?? 0,
    type: json["type"] ?? '',
    mainLink: json["main_link"] ?? '',
    isPaid: json["is_paid"] ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "cardFieldId": cardFieldId,
    "icon_group": iconGroup,
    "icon": icon,
    "icon_name": iconName,
    "icon_image": iconImage,
    "icon_fa": iconFa,
    "icon_title": iconTitle,
    "label": label,
    "icon_color": iconColor,
    "example_text": exampleText,
    "status": status,
    "content": content,
    "order_id": orderId,
    "type": type,
    "main_link": mainLink,
    "is_paid": isPaid,
  };

  @override
  String toString() =>
      'SocialLinkModel(id: $id, cardFieldId: $cardFieldId, icon_group: $iconGroup, icon: $icon, icon_name: $iconName,icon_image: $iconImage, icon_fa: $iconFa, icon_title: $iconTitle, label: $label,icon_color: $iconColor, example_text: $exampleText, status: $status, content: $content,order_id: $orderId, type: $type, main_link: $mainLink, is_paid: $isPaid)';

  @override
  List<Object?> get props => [
    id,
    cardFieldId,
    iconGroup,
    icon,
    iconName,
    iconImage,
    iconFa,
    iconTitle,
    label,
    iconColor,
    exampleText,
    status,
    content,
    orderId,
    type,
    mainLink,
    isPaid
  ];
}

class SocialLinksCategory {
  final String title;
  final List<SocialLinkModel> socialLinks;
  const SocialLinksCategory(this.title,this.socialLinks);
}