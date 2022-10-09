import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:fluxus/app/core/models/office_model.dart';

// Perfil de usuario ou pessoa
class ProfileModel {
  final String? id;
  final String? userId;
  final String? email;
  final String? name;
  final String? phone;
  final String? address;
  final String? cep;
  final String? pluscode;
  final String? photo;
  final String? cpf;
  final bool? isFemale;
  final DateTime? birthday;
  final String? description;
  final String? register; // conselho de saude
  final List<ProfileModel>? family; // familiares adultos
  final List<ProfileModel>? children; // crianças que estão ligadas a vc
  final List<HealthPlanModel>? healthPlan; // Convenio
  final List<ExpertiseModel>? expertise; // especialidade
  final List<OfficeModel>? office; // cargo: Adm, Sec, Aval, Prof, Paciente

  final List<String>? routes;
  final bool? isActive;
  final bool? isDeleted;
  ProfileModel({
    this.id,
    this.userId,
    this.email,
    this.name,
    this.phone,
    this.address,
    this.cep,
    this.pluscode,
    this.photo,
    this.cpf,
    this.isFemale,
    this.birthday,
    this.description,
    this.register,
    this.family,
    this.children,
    this.healthPlan,
    this.expertise,
    this.office,
    this.routes,
    this.isActive,
    this.isDeleted,
  });

  ProfileModel copyWith({
    String? id,
    String? userId,
    String? email,
    String? name,
    String? phone,
    String? address,
    String? cep,
    String? pluscode,
    String? photo,
    String? cpf,
    bool? isFemale,
    DateTime? birthday,
    String? description,
    String? register,
    List<ProfileModel>? family,
    List<ProfileModel>? children,
    List<HealthPlanModel>? healthInsurance,
    List<ExpertiseModel>? expertise,
    List<OfficeModel>? office,
    List<String>? routes,
    bool? isActive,
    bool? isDeleted,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      cep: cep ?? this.cep,
      pluscode: pluscode ?? this.pluscode,
      photo: photo ?? this.photo,
      cpf: cpf ?? this.cpf,
      isFemale: isFemale ?? this.isFemale,
      birthday: birthday ?? this.birthday,
      description: description ?? this.description,
      register: register ?? this.register,
      family: family ?? this.family,
      children: children ?? this.children,
      healthPlan: healthInsurance ?? healthPlan,
      expertise: expertise ?? this.expertise,
      office: office ?? this.office,
      routes: routes ?? this.routes,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (email != null) {
      result.addAll({'email': email});
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
    if (cep != null) {
      result.addAll({'cep': cep});
    }
    if (pluscode != null) {
      result.addAll({'pluscode': pluscode});
    }
    if (photo != null) {
      result.addAll({'photo': photo});
    }
    if (cpf != null) {
      result.addAll({'cpf': cpf});
    }
    if (isFemale != null) {
      result.addAll({'isFemale': isFemale});
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
    if (family != null) {
      result.addAll({'family': family!.map((x) => x.toMap()).toList()});
    }
    if (children != null) {
      result.addAll({'children': children!.map((x) => x.toMap()).toList()});
    }
    if (healthPlan != null) {
      result.addAll(
          {'healthInsurance': healthPlan!.map((x) => x.toMap()).toList()});
    }
    if (expertise != null) {
      result.addAll({'expertise': expertise!.map((x) => x.toMap()).toList()});
    }
    if (office != null) {
      result.addAll({'office': office!.map((x) => x.toMap()).toList()});
    }
    if (routes != null) {
      result.addAll({'routes': routes});
    }
    if (isActive != null) {
      result.addAll({'isActive': isActive});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      userId: map['userId'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      cep: map['cep'],
      pluscode: map['pluscode'],
      photo: map['photo'],
      cpf: map['cpf'],
      isFemale: map['isFemale'],
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthday'])
          : null,
      description: map['description'],
      register: map['register'],
      family: map['family'] != null
          ? List<ProfileModel>.from(
              map['family']?.map((x) => ProfileModel.fromMap(x)))
          : null,
      children: map['children'] != null
          ? List<ProfileModel>.from(
              map['children']?.map((x) => ProfileModel.fromMap(x)))
          : null,
      healthPlan: map['healthInsurance'] != null
          ? List<HealthPlanModel>.from(
              map['healthInsurance']?.map((x) => HealthPlanModel.fromMap(x)))
          : null,
      expertise: map['expertise'] != null
          ? List<ExpertiseModel>.from(
              map['expertise']?.map((x) => ExpertiseModel.fromMap(x)))
          : null,
      office: map['office'] != null
          ? List<OfficeModel>.from(
              map['office']?.map((x) => OfficeModel.fromMap(x)))
          : null,
      routes: List<String>.from(map['routes']),
      isActive: map['isActive'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileModel(id: $id, userId: $userId, email: $email, name: $name, phone: $phone, address: $address, cep: $cep, pluscode: $pluscode, photo: $photo, cpf: $cpf, isFemale: $isFemale, birthday: $birthday, description: $description, register: $register, family: $family, children: $children, healthInsurance: $healthPlan, expertise: $expertise, office: $office, routes: $routes, isActive: $isActive, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileModel &&
        other.id == id &&
        other.userId == userId &&
        other.email == email &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.cep == cep &&
        other.pluscode == pluscode &&
        other.photo == photo &&
        other.cpf == cpf &&
        other.isFemale == isFemale &&
        other.birthday == birthday &&
        other.description == description &&
        other.register == register &&
        listEquals(other.family, family) &&
        listEquals(other.children, children) &&
        listEquals(other.healthPlan, healthPlan) &&
        listEquals(other.expertise, expertise) &&
        listEquals(other.office, office) &&
        listEquals(other.routes, routes) &&
        other.isActive == isActive &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        email.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        cep.hashCode ^
        pluscode.hashCode ^
        photo.hashCode ^
        cpf.hashCode ^
        isFemale.hashCode ^
        birthday.hashCode ^
        description.hashCode ^
        register.hashCode ^
        family.hashCode ^
        children.hashCode ^
        healthPlan.hashCode ^
        expertise.hashCode ^
        office.hashCode ^
        routes.hashCode ^
        isActive.hashCode ^
        isDeleted.hashCode;
  }
}
