import 'dart:convert';

import 'package:fluxus/app/core/models/profile_model.dart';

/// Usuarios do sistema
class UserModel {
  final String id;
  final String email;
  ProfileModel? profile;
  UserModel({
    required this.id,
    required this.email,
    this.profile,
  });

  UserModel copyWith({
    String? id,
    String? email,
    ProfileModel? profile,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'email': email});
    if (profile != null) {
      result.addAll({'profile': profile!.toMap()});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      profile:
          map['profile'] != null ? ProfileModel.fromMap(map['profile']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(id: $id, email: $email, profile: $profile)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.profile == profile;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ profile.hashCode;
}
