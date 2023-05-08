import 'dart:convert';

class HistoryViewModel {
  HistoryViewModel({
    required this.id,
    required this.cardId,
    required this.deviceId,
    required this.ipAddress,
    required this.userAgent,
    required this.region,
    required this.regionName,
    required this.counter,
    required this.name,
    required this.username,
    required this.email,
    required this.city,
    required this.countryCode,
    required this.countryName,
    required this.continentName,
    required this.timezone,
  });

  final int id;
  final int cardId;
  final dynamic deviceId;
  final String ipAddress;
  final String userAgent;
  final String region;
  final String regionName;
  final int counter;
  final String name;
  final String username;
  final String email;
  final String city;
  final String countryCode;
  final String countryName;
  final String continentName;
  final String timezone;

  HistoryViewModel copyWith({
    int? id,
    int? cardId,
    dynamic deviceId,
    String? ipAddress,
    String? userAgent,
    String? region,
    String? regionName,
    int? counter,
    String? name,
    String? username,
    String? email,
    String? city,
    String? countryCode,
    String? countryName,
    String? continentName,
    String? timezone,
  }) =>
      HistoryViewModel(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        deviceId: deviceId ?? this.deviceId,
        ipAddress: ipAddress ?? this.ipAddress,
        userAgent: userAgent ?? this.userAgent,
        region: region ?? this.region,
        regionName: regionName ?? this.regionName,
        counter: counter ?? this.counter,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        city: city ?? this.city,
        countryCode: countryCode ?? this.countryCode,
        countryName: countryName ?? this.countryName,
        continentName: continentName ?? this.continentName,
        timezone: timezone ?? this.timezone,
      );

  factory HistoryViewModel.fromJson(String str) => HistoryViewModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryViewModel.fromMap(Map<String, dynamic> json) => HistoryViewModel(
    id: json["id"] ?? 0,
    cardId: json["card_id"] ?? 0,
    deviceId: json["device_id"] ?? '',
    ipAddress: json["ip_address"] ?? '',
    userAgent: json["user_agent"] ?? '',
    region: json["region"] ?? '',
    regionName: json["region_name"] ?? '',
    counter: json["counter"] ?? 0,
    name: json["name"] ?? '',
    username: json["username"] ?? '',
    email: json["email"] ?? '',
    city: json["city"] ?? '',
    countryCode: json["country_code"] ?? '',
    countryName: json["country_name"] ?? '',
    continentName: json["continent_name"] ?? '',
    timezone: json["timezone"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "card_id": cardId,
    "device_id": deviceId,
    "ip_address": ipAddress,
    "user_agent": userAgent,
    "region": region,
    "region_name": regionName,
    "counter": counter,
    "name": name,
    "username": username,
    "email": email,
    "city": city,
    "country_code": countryCode,
    "country_name": countryName,
    "continent_name": continentName,
    "timezone": timezone,
  };
}
