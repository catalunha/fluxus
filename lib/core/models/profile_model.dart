import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/core/models/agreement_model.dart';
import 'package:fluxus/core/models/expertise_model.dart';
import 'package:fluxus/core/models/office_model.dart';

// Perfil de usuario ou pessoa
class ProfileModel {
  final String? id;
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
  final ProfileModel? parent;
  final List<ProfileModel>? children;
  final List<AgreementModel>? agreement; // convenio
  final String? register; // conselho de saude
  final List<ExpertiseModel>? expertise; // especialidade
  final List<OfficeModel>? office; // cargo: Adm, Sec, Aval, Prof, Paciente

  final List<String>? routes;
  final bool? isDeleted;
  ProfileModel({
    this.id,
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
    this.parent,
    this.children,
    this.agreement,
    this.register,
    this.expertise,
    this.office,
    this.routes,
    this.isDeleted,
  });

  ProfileModel copyWith({
    String? id,
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
    ProfileModel? parent,
    List<ProfileModel>? children,
    List<AgreementModel>? agreement,
    String? register,
    List<ExpertiseModel>? expertise,
    List<OfficeModel>? office,
    List<String>? routes,
    bool? isDeleted,
  }) {
    return ProfileModel(
      id: id ?? this.id,
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
      parent: parent ?? this.parent,
      children: children ?? this.children,
      agreement: agreement ?? this.agreement,
      register: register ?? this.register,
      expertise: expertise ?? this.expertise,
      office: office ?? this.office,
      routes: routes ?? this.routes,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
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
    if (parent != null) {
      result.addAll({'parent': parent!.toMap()});
    }
    if (children != null) {
      result.addAll({'children': children!.map((x) => x.toMap()).toList()});
    }
    if (agreement != null) {
      result.addAll({'agreement': agreement!.map((x) => x.toMap()).toList()});
    }
    if (register != null) {
      result.addAll({'register': register});
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
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
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
      parent:
          map['parent'] != null ? ProfileModel.fromMap(map['parent']) : null,
      children: map['children'] != null
          ? List<ProfileModel>.from(
              map['children']?.map((x) => ProfileModel.fromMap(x)))
          : null,
      agreement: map['agreement'] != null
          ? List<AgreementModel>.from(
              map['agreement']?.map((x) => AgreementModel.fromMap(x)))
          : null,
      register: map['register'],
      expertise: map['expertise'] != null
          ? List<ExpertiseModel>.from(
              map['expertise']?.map((x) => ExpertiseModel.fromMap(x)))
          : null,
      office: map['office'] != null
          ? List<OfficeModel>.from(
              map['office']?.map((x) => OfficeModel.fromMap(x)))
          : null,
      routes: List<String>.from(map['routes']),
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileModel(id: $id, email: $email, name: $name, phone: $phone, address: $address, cep: $cep, pluscode: $pluscode, photo: $photo, cpf: $cpf, isFemale: $isFemale, birthday: $birthday, description: $description, parent: $parent, children: $children, agreement: $agreement, register: $register, expertise: $expertise, office: $office, routes: $routes, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileModel &&
        other.id == id &&
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
        other.parent == parent &&
        listEquals(other.children, children) &&
        listEquals(other.agreement, agreement) &&
        other.register == register &&
        listEquals(other.expertise, expertise) &&
        listEquals(other.office, office) &&
        listEquals(other.routes, routes) &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
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
        parent.hashCode ^
        children.hashCode ^
        agreement.hashCode ^
        register.hashCode ^
        expertise.hashCode ^
        office.hashCode ^
        routes.hashCode ^
        isDeleted.hashCode;
  }
}
