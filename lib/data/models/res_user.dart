import 'dart:convert';

import 'app_user.dart';

class ResUser {
  final AppUser appUser;
  final String token;
  ResUser({
    required this.appUser,
    required this.token,
  });

  ResUser copyWith({
    AppUser? appUser,
    String? token,
  }) {
    return ResUser(
      appUser: appUser ?? this.appUser,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': appUser.toMap(),
      'token': token,
    };
  }

  factory ResUser.fromMap(Map<String, dynamic> map) {
    return ResUser(
      appUser: map['user'] != null
          ? AppUser.fromMap(map['user'] as Map<String, dynamic>)
          : AppUser.fromMap({}),
      token: map['token'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ResUser.fromJson(String source) =>
      ResUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ResUser(appUser: $appUser, token: $token)';

  @override
  bool operator ==(covariant ResUser other) {
    if (identical(this, other)) return true;

    return other.appUser == appUser && other.token == token;
  }

  @override
  int get hashCode => appUser.hashCode ^ token.hashCode;
}
