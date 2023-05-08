import 'dart:convert';

import 'package:mtgpro/app/modules/home_cards/model/business_card_fields_model.dart';

class CardModel {
  CardModel({
    required this.id,
    required this.cardId,
    required this.userId,
    required this.themeColor,
    required this.cardLang,
    required this.cover,
    required this.profile,
    required this.profilePicUrl,
    required this.coverPicUrl,
    required this.logoPicUrl,
    required this.cardUrl,
    required this.cardType,
    required this.title,
    required this.title2,
    required this.subTitle,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.companyName,
    required this.companyWebsitelink,
    required this.ccode,
    required this.phoneNumber,
    required this.cardEmail,
    required this.cardFor,
    required this.logo,
    required this.designation,
    required this.deletedAt,
    required this.deletedBy,
    required this.location,
    required this.bio,
    required this.totalHit,
    required this.totalQrDownload,
    required this.totalVcfDownload,
    required this.colorLink,
    required this.isLiveCard,
    required this.businessCardField,
  });

  final int id;
  final String cardId;
  final int userId;
  final String themeColor;
  final String cardLang;
  final String cover;
  final String profile;
  final String profilePicUrl;
  final String coverPicUrl;
  final String logoPicUrl;
  final String cardUrl;
  final String cardType;
  final String title;
  final dynamic title2;
  final String subTitle;
  final dynamic description;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String companyName;
  final dynamic companyWebsitelink;
  final dynamic ccode;
  final String phoneNumber;
  final String cardEmail;
  final String cardFor;
  final dynamic logo;
  final String designation;
  final dynamic deletedAt;
  final dynamic deletedBy;
  final String location;
  final String bio;
  final int totalHit;
  final int totalQrDownload;
  final int totalVcfDownload;
  final int colorLink;
  final bool isLiveCard;
  final List<BusinessCardField> businessCardField;

  CardModel copyWith({
    int? id,
    String? cardId,
    int? userId,
    String? themeColor,
    String? cardLang,
    String? cover,
    String? profile,
    String? profilePicUrl,
    String? coverPicUrl,
    String? logoPicUrl,
    String? cardUrl,
    String? cardType,
    String? title,
    String? title2,
    String? subTitle,
    String? description,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? companyName,
    String? companyWebsitelink,
    dynamic ccode,
    String? phoneNumber,
    String? cardEmail,
    String? cardFor,
    String? logo,
    String? designation,
    String? deletedAt,
    String? deletedBy,
    String? location,
    String? bio,
    int? totalHit,
    int? totalQrDownload,
    int? totalVcfDownload,
    int? colorLink,
    bool? isLiveCard,
    List<BusinessCardField>? businessCardField,
  }) =>
      CardModel(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        userId: userId ?? this.userId,
        themeColor: themeColor ?? this.themeColor,
        cardLang: cardLang ?? this.cardLang,
        cover: cover ?? this.cover,
        profile: profile ?? this.profile,
        profilePicUrl: profilePicUrl ?? this.profilePicUrl,
        coverPicUrl: coverPicUrl ?? this.coverPicUrl,
        logoPicUrl: logoPicUrl ?? this.logoPicUrl,
        cardUrl: cardUrl ?? this.cardUrl,
        cardType: cardType ?? this.cardType,
        title: title ?? this.title,
        title2: title2 ?? this.title2,
        subTitle: subTitle ?? this.subTitle,
        description: description ?? this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        companyName: companyName ?? this.companyName,
        companyWebsitelink: companyWebsitelink ?? this.companyWebsitelink,
        ccode: ccode ?? this.ccode,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        cardEmail: cardEmail ?? this.cardEmail,
        cardFor: cardFor ?? this.cardFor,
        logo: logo ?? this.logo,
        designation: designation ?? this.designation,
        deletedAt: deletedAt ?? this.deletedAt,
        deletedBy: deletedBy ?? this.deletedBy,
        location: location ?? this.location,
        bio: bio ?? this.bio,
        totalHit: totalHit ?? this.totalHit,
        totalQrDownload: totalQrDownload ?? this.totalQrDownload,
        totalVcfDownload: totalVcfDownload ?? this.totalVcfDownload,
        colorLink: colorLink ?? this.colorLink,
        isLiveCard: isLiveCard ?? this.isLiveCard,
        businessCardField: businessCardField ?? this.businessCardField,
      );

  factory CardModel.fromJson(String str) => CardModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardModel.fromMap(Map<String, dynamic> json) => CardModel(
    id: json["id"] ?? 0,
    cardId: json["card_id"] ?? '',
    userId: json["user_id"] ?? 0,
    themeColor: json["theme_color"] ?? '',
    cardLang: json["card_lang"] ?? '',
    cover: json["cover"] ?? '',
    profile: json["profile"] ?? '',
    profilePicUrl: json["profile_pic_url"] ?? '',
    coverPicUrl: json["cover_pic_url"] ?? '',
    logoPicUrl: json["company_logo_url"] ?? '',
    cardUrl: json["card_url"] ?? '',
    cardType: json["card_type"] ?? '',
    title: json["title"] ?? '',
    title2: json["title2"] ?? '',
    subTitle: json["sub_title"] ?? '',
    description: json["description"] ?? '',
    status: json["status"] ?? 0,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    companyName: json["company_name"] ?? '',
    companyWebsitelink: json["company_websitelink"] ?? '',
    ccode: json["ccode"],
    phoneNumber: json["phone_number"] ?? '',
    cardEmail: json["card_email"] ?? '',
    cardFor: json["card_for"] ?? '',
    logo: json["logo"] ?? '',
    designation: json["designation"] ?? '',
    deletedAt: json["deleted_at"],
    deletedBy: json["deleted_by"],
    location: json["location"] ?? '',
    bio: json["bio"] ?? '',
    totalHit: json["total_hit"] ?? 0,
    totalQrDownload: json["total_qr_download"] ?? 0,
    totalVcfDownload: json["total_vcf_download"] ?? 0,
    colorLink: json["color_link"] ?? 0,
    isLiveCard: json["is_live_card"] ?? false,
    businessCardField: json["business_card_fields"] == null
        ? []
        : List<BusinessCardField>.from(json["business_card_fields"].map((x) => BusinessCardField.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "card_id": cardId,
    "user_id": userId,
    "theme_color": themeColor,
    "card_lang": cardLang,
    "cover": cover,
    "profile": profile,
    "profile_pic_url": profilePicUrl,
    "cover_pic_url": coverPicUrl,
    "company_logo_url": logoPicUrl,
    "card_url": cardUrl,
    "card_type": cardType,
    "title": title,
    "title2": title2,
    "sub_title": subTitle,
    "description": description,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "company_name": companyName,
    "company_websitelink": companyWebsitelink,
    "ccode": ccode,
    "phone_number": phoneNumber,
    "card_email": cardEmail,
    "card_for": cardFor,
    "logo": logo,
    "designation": designation,
    "deleted_at": deletedAt,
    "deleted_by": deletedBy,
    "location": location,
    "bio": bio,
    "total_hit": totalHit,
    "total_qr_download": totalQrDownload,
    "total_vcf_download": totalVcfDownload,
    "color_link": colorLink,
    "is_live_card": isLiveCard,
    "business_card_fields": List<dynamic>.from(businessCardField.map((x) => x.toMap())),
  };
}