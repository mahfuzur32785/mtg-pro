import 'dart:convert';

class AppSettingModel {
  AppSettingModel({
    required this.id,
    required this.googleKey,
    required this.googleAnalyticsId,
    required this.siteName,
    required this.siteLogo,
    required this.favicon,
    required this.seoMetaDescription,
    required this.seoKeywords,
    required this.seoImage,
    required this.tawkChatBotKey,
    required this.name,
    required this.address,
    required this.driver,
    required this.host,
    required this.port,
    required this.encryption,
    required this.username,
    required this.password,
    required this.status,
    required this.facebookClientId,
    required this.facebookClientSecret,
    required this.facebookCallbackUrl,
    required this.googleClientId,
    required this.googleClientSecret,
    required this.googleCallbackUrl,
    required this.copyrightText,
    required this.officeAddress,
    required this.facebookUrl,
    required this.youtubeUrl,
    required this.twitterUrl,
    required this.linkedinUrl,
    required this.telegramUrl,
    required this.whatsappNumber,
    required this.iosAppUrl,
    required this.androidAppUrl,
    required this.email,
    required this.phoneNo,
    required this.supportEmail,
    required this.instagramUrl,
    required this.siteTitle,
    required this.pinterestUrl,
    required this.mainMotto,
  });

  final int id;
  final String googleKey;
  final String googleAnalyticsId;
  final String siteName;
  final String siteLogo;
  final String favicon;
  final String seoMetaDescription;
  final String seoKeywords;
  final String seoImage;
  final dynamic tawkChatBotKey;
  final String name;
  final String address;
  final String driver;
  final String host;
  final int port;
  final String encryption;
  final String username;
  final String password;
  final String status;
  final String facebookClientId;
  final String facebookClientSecret;
  final String facebookCallbackUrl;
  final String googleClientId;
  final String googleClientSecret;
  final String googleCallbackUrl;
  final String copyrightText;
  final String officeAddress;
  final dynamic facebookUrl;
  final dynamic youtubeUrl;
  final dynamic twitterUrl;
  final dynamic linkedinUrl;
  final dynamic telegramUrl;
  final dynamic whatsappNumber;
  final String iosAppUrl;
  final String androidAppUrl;
  final String email;
  final String phoneNo;
  final String supportEmail;
  final String instagramUrl;
  final String siteTitle;
  final dynamic pinterestUrl;
  final String mainMotto;

  AppSettingModel copyWith({
    int? id,
    String? googleKey,
    String? googleAnalyticsId,
    String? siteName,
    String? siteLogo,
    String? favicon,
    String? seoMetaDescription,
    String? seoKeywords,
    String? seoImage,
    dynamic tawkChatBotKey,
    String? name,
    String? address,
    String? driver,
    String? host,
    int? port,
    String? encryption,
    String? username,
    String? password,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic applicationType,
    dynamic appMode,
    String? facebookClientId,
    String? facebookClientSecret,
    String? facebookCallbackUrl,
    String? googleClientId,
    String? googleClientSecret,
    String? googleCallbackUrl,
    String? copyrightText,
    String? officeAddress,
    dynamic facebookUrl,
    dynamic youtubeUrl,
    dynamic twitterUrl,
    dynamic linkedinUrl,
    dynamic telegramUrl,
    dynamic whatsappNumber,
    String? iosAppUrl,
    String? androidAppUrl,
    String? email,
    String? phoneNo,
    String? supportEmail,
    String? instagramUrl,
    String? siteTitle,
    dynamic pinterestUrl,
    String? mainMotto,
  }) =>
      AppSettingModel(
        id: id ?? this.id,
        googleKey: googleKey ?? this.googleKey,
        googleAnalyticsId: googleAnalyticsId ?? this.googleAnalyticsId,
        siteName: siteName ?? this.siteName,
        siteLogo: siteLogo ?? this.siteLogo,
        favicon: favicon ?? this.favicon,
        seoMetaDescription: seoMetaDescription ?? this.seoMetaDescription,
        seoKeywords: seoKeywords ?? this.seoKeywords,
        seoImage: seoImage ?? this.seoImage,
        tawkChatBotKey: tawkChatBotKey ?? this.tawkChatBotKey,
        name: name ?? this.name,
        address: address ?? this.address,
        driver: driver ?? this.driver,
        host: host ?? this.host,
        port: port ?? this.port,
        encryption: encryption ?? this.encryption,
        username: username ?? this.username,
        password: password ?? this.password,
        status: status ?? this.status,
        facebookClientId: facebookClientId ?? this.facebookClientId,
        facebookClientSecret: facebookClientSecret ?? this.facebookClientSecret,
        facebookCallbackUrl: facebookCallbackUrl ?? this.facebookCallbackUrl,
        googleClientId: googleClientId ?? this.googleClientId,
        googleClientSecret: googleClientSecret ?? this.googleClientSecret,
        googleCallbackUrl: googleCallbackUrl ?? this.googleCallbackUrl,
        copyrightText: copyrightText ?? this.copyrightText,
        officeAddress: officeAddress ?? this.officeAddress,
        facebookUrl: facebookUrl ?? this.facebookUrl,
        youtubeUrl: youtubeUrl ?? this.youtubeUrl,
        twitterUrl: twitterUrl ?? this.twitterUrl,
        linkedinUrl: linkedinUrl ?? this.linkedinUrl,
        telegramUrl: telegramUrl ?? this.telegramUrl,
        whatsappNumber: whatsappNumber ?? this.whatsappNumber,
        iosAppUrl: iosAppUrl ?? this.iosAppUrl,
        androidAppUrl: androidAppUrl ?? this.androidAppUrl,
        email: email ?? this.email,
        phoneNo: phoneNo ?? this.phoneNo,
        supportEmail: supportEmail ?? this.supportEmail,
        instagramUrl: instagramUrl ?? this.instagramUrl,
        siteTitle: siteTitle ?? this.siteTitle,
        pinterestUrl: pinterestUrl ?? this.pinterestUrl,
        mainMotto: mainMotto ?? this.mainMotto,
      );

  factory AppSettingModel.fromJson(String str) => AppSettingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppSettingModel.fromMap(Map<String, dynamic> json) => AppSettingModel(
    id: json["id"],
    googleKey: json["google_key"],
    googleAnalyticsId: json["google_analytics_id"],
    siteName: json["site_name"],
    siteLogo: json["site_logo"],
    favicon: json["favicon"],
    seoMetaDescription: json["seo_meta_description"],
    seoKeywords: json["seo_keywords"],
    seoImage: json["seo_image"],
    tawkChatBotKey: json["tawk_chat_bot_key"],
    name: json["name"],
    address: json["address"],
    driver: json["driver"],
    host: json["host"],
    port: json["port"],
    encryption: json["encryption"],
    username: json["username"],
    password: json["password"],
    status: json["status"],
    facebookClientId: json["facebook_client_id"],
    facebookClientSecret: json["facebook_client_secret"],
    facebookCallbackUrl: json["facebook_callback_url"],
    googleClientId: json["google_client_id"],
    googleClientSecret: json["google_client_secret"],
    googleCallbackUrl: json["google_callback_url"],
    copyrightText: json["copyright_text"],
    officeAddress: json["office_address"],
    facebookUrl: json["facebook_url"],
    youtubeUrl: json["youtube_url"],
    twitterUrl: json["twitter_url"],
    linkedinUrl: json["linkedin_url"],
    telegramUrl: json["telegram_url"],
    whatsappNumber: json["whatsapp_number"],
    iosAppUrl: json["ios_app_url"],
    androidAppUrl: json["android_app_url"],
    email: json["email"],
    phoneNo: json["phone_no"],
    supportEmail: json["support_email"],
    instagramUrl: json["instagram_url"],
    siteTitle: json["site_title"],
    pinterestUrl: json["pinterest_url"],
    mainMotto: json["main_motto"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "google_key": googleKey,
    "google_analytics_id": googleAnalyticsId,
    "site_name": siteName,
    "site_logo": siteLogo,
    "favicon": favicon,
    "seo_meta_description": seoMetaDescription,
    "seo_keywords": seoKeywords,
    "seo_image": seoImage,
    "tawk_chat_bot_key": tawkChatBotKey,
    "name": name,
    "address": address,
    "driver": driver,
    "host": host,
    "port": port,
    "encryption": encryption,
    "username": username,
    "password": password,
    "status": status,
    "facebook_client_id": facebookClientId,
    "facebook_client_secret": facebookClientSecret,
    "facebook_callback_url": facebookCallbackUrl,
    "google_client_id": googleClientId,
    "google_client_secret": googleClientSecret,
    "google_callback_url": googleCallbackUrl,
    "copyright_text": copyrightText,
    "office_address": officeAddress,
    "facebook_url": facebookUrl,
    "youtube_url": youtubeUrl,
    "twitter_url": twitterUrl,
    "linkedin_url": linkedinUrl,
    "telegram_url": telegramUrl,
    "whatsapp_number": whatsappNumber,
    "ios_app_url": iosAppUrl,
    "android_app_url": androidAppUrl,
    "email": email,
    "phone_no": phoneNo,
    "support_email": supportEmail,
    "instagram_url": instagramUrl,
    "site_title": siteTitle,
    "pinterest_url": pinterestUrl,
    "main_motto": mainMotto,
  };
}