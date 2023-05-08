import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_prfile_model.dart';

class UserLoginResponseModel extends Equatable {
  final UserProfileModel user;
  final String accessToken;
  const UserLoginResponseModel({
    required this.user,
    required this.accessToken,
  });

  UserLoginResponseModel copyWith({
    UserProfileModel? user,
    String? accessToken,
    int? isVendor,
    int? expiresIn,
    String? tokenType,
  }) {
    return UserLoginResponseModel(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user': user.toMap()});
    result.addAll({'access_token': accessToken});

    return result;
  }

  factory UserLoginResponseModel.fromMap(Map<String, dynamic> map) {
    return UserLoginResponseModel(
      user: UserProfileModel.fromMap(map['user']),
      accessToken: map['access_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginResponseModel.fromJson(String source) =>
      UserLoginResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserLoginResponseModel(user: $user, access_token: $accessToken)';
  }

  @override
  List<Object> get props => [
        user,
        accessToken,
      ];
}
