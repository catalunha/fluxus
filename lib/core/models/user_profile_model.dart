import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/core/models/office_model.dart';
import 'package:fluxus/core/models/user_model.dart';

class UserProfileModel {
  final String? id;
  final String? name;
  final String? phone;
  final String? address;
  final String? photo;
  final String? cpf;
  final bool? isMale;
  final DateTime? birthday;
  final String? description;
  final String? register;
  final List<String>? routes;
  final bool? isActive;
  final UserModel? parent;
  final OfficeModel? office;
  UserProfileModel({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.photo,
    this.cpf,
    this.isMale,
    this.birthday,
    this.description,
    this.register,
    this.routes,
    this.isActive,
    this.parent,
    this.office,
  });

  UserProfileModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    String? photo,
    String? cpf,
    bool? isMale,
    DateTime? birthday,
    String? description,
    String? register,
    List<String>? routes,
    bool? isActive,
    UserModel? parent,
    OfficeModel? office,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      photo: photo ?? this.photo,
      cpf: cpf ?? this.cpf,
      isMale: isMale ?? this.isMale,
      birthday: birthday ?? this.birthday,
      description: description ?? this.description,
      register: register ?? this.register,
      routes: routes ?? this.routes,
      isActive: isActive ?? this.isActive,
      parent: parent ?? this.parent,
      office: office ?? this.office,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (photo != null) {
      result.addAll({'photo': photo});
    }
    if (cpf != null) {
      result.addAll({'cpf': cpf});
    }
    if (isMale != null) {
      result.addAll({'isMale': isMale});
    }
    if (birthday != null) {
      result.addAll({'birthday': birthday!.millisecondsSinceEpoch});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (register != null) {
      result.addAll({'register': register});
    }
    if (routes != null) {
      result.addAll({'routes': routes});
    }
    if (isActive != null) {
      result.addAll({'isActive': isActive});
    }
    if (parent != null) {
      result.addAll({'parent': parent!.toMap()});
    }
    if (office != null) {
      result.addAll({'office': office!.toMap()});
    }

    return result;
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      photo: map['photo'],
      cpf: map['cpf'],
      isMale: map['isMale'],
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthday'])
          : null,
      description: map['description'],
      register: map['register'],
      routes: List<String>.from(map['routes']),
      isActive: map['isActive'],
      parent: map['parent'] != null ? UserModel.fromMap(map['parent']) : null,
      office: map['office'] != null ? OfficeModel.fromMap(map['office']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfileModel(id: $id, name: $name, phone: $phone, address: $address, photo: $photo, cpf: $cpf, isMale: $isMale, birthday: $birthday, description: $description, register: $register, routes: $routes, isActive: $isActive, parent: $parent, office: $office)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfileModel &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.photo == photo &&
        other.cpf == cpf &&
        other.isMale == isMale &&
        other.birthday == birthday &&
        other.description == description &&
        other.register == register &&
        listEquals(other.routes, routes) &&
        other.isActive == isActive &&
        other.parent == parent &&
        other.office == office;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        photo.hashCode ^
        cpf.hashCode ^
        isMale.hashCode ^
        birthday.hashCode ^
        description.hashCode ^
        register.hashCode ^
        routes.hashCode ^
        isActive.hashCode ^
        parent.hashCode ^
        office.hashCode;
  }
}
