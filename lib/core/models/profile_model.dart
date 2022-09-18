import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:fluxus/core/models/agreement_model.dart';
import 'package:fluxus/core/models/expertise_model.dart';
import 'package:fluxus/core/models/office_model.dart';
import 'package:fluxus/core/models/plan_model.dart';
import 'package:fluxus/core/models/user_model.dart';

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
  final bool? isMale;
  final DateTime? birthday;
  final String? description;
  final String? register; // conselho de saude
  final bool? isActive;
  final UserModel? parent;
  final List<String>? routes;
  final List<ExpertiseModel>? expertise; // especialidade
  final List<OfficeModel>? office; // cargo: Adm, Sec, Aval, Prof, Paciente
  final List<AgreementModel>? agreement; // convenio
  final List<PlanModel>? plan; // plano
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
    this.isMale,
    this.birthday,
    this.description,
    this.register,
    this.isActive,
    this.parent,
    this.routes,
    this.expertise,
    this.office,
    this.agreement,
    this.plan,
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
    bool? isMale,
    DateTime? birthday,
    String? description,
    String? register,
    bool? isActive,
    UserModel? parent,
    List<String>? routes,
    List<ExpertiseModel>? expertise,
    List<OfficeModel>? office,
    List<AgreementModel>? agreement,
    List<PlanModel>? plan,
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
      isMale: isMale ?? this.isMale,
      birthday: birthday ?? this.birthday,
      description: description ?? this.description,
      register: register ?? this.register,
      isActive: isActive ?? this.isActive,
      parent: parent ?? this.parent,
      routes: routes ?? this.routes,
      expertise: expertise ?? this.expertise,
      office: office ?? this.office,
      agreement: agreement ?? this.agreement,
      plan: plan ?? this.plan,
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
    if (isActive != null) {
      result.addAll({'isActive': isActive});
    }
    if (parent != null) {
      result.addAll({'parent': parent!.toMap()});
    }
    if (routes != null) {
      result.addAll({'routes': routes});
    }
    if (expertise != null) {
      result.addAll({'expertise': expertise!.map((x) => x.toMap()).toList()});
    }
    if (office != null) {
      result.addAll({'office': office!.map((x) => x.toMap()).toList()});
    }
    if (agreement != null) {
      result.addAll({'agreement': agreement!.map((x) => x.toMap()).toList()});
    }
    if (plan != null) {
      result.addAll({'plan': plan!.map((x) => x.toMap()).toList()});
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
      isMale: map['isMale'],
      birthday: map['birthday'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthday'])
          : null,
      description: map['description'],
      register: map['register'],
      isActive: map['isActive'],
      parent: map['parent'] != null ? UserModel.fromMap(map['parent']) : null,
      routes: List<String>.from(map['routes']),
      expertise: map['expertise'] != null
          ? List<ExpertiseModel>.from(
              map['expertise']?.map((x) => ExpertiseModel.fromMap(x)))
          : null,
      office: map['office'] != null
          ? List<OfficeModel>.from(
              map['office']?.map((x) => OfficeModel.fromMap(x)))
          : null,
      agreement: map['agreement'] != null
          ? List<AgreementModel>.from(
              map['agreement']?.map((x) => AgreementModel.fromMap(x)))
          : null,
      plan: map['plan'] != null
          ? List<PlanModel>.from(map['plan']?.map((x) => PlanModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileModel(id: $id, email: $email, name: $name, phone: $phone, address: $address, cep: $cep, pluscode: $pluscode, photo: $photo, cpf: $cpf, isMale: $isMale, birthday: $birthday, description: $description, register: $register, isActive: $isActive, parent: $parent, routes: $routes, expertise: $expertise, office: $office, agreement: $agreement, plan: $plan)';
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
        other.isMale == isMale &&
        other.birthday == birthday &&
        other.description == description &&
        other.register == register &&
        other.isActive == isActive &&
        other.parent == parent &&
        listEquals(other.routes, routes) &&
        listEquals(other.expertise, expertise) &&
        listEquals(other.office, office) &&
        listEquals(other.agreement, agreement) &&
        listEquals(other.plan, plan);
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
        isMale.hashCode ^
        birthday.hashCode ^
        description.hashCode ^
        register.hashCode ^
        isActive.hashCode ^
        parent.hashCode ^
        routes.hashCode ^
        expertise.hashCode ^
        office.hashCode ^
        agreement.hashCode ^
        plan.hashCode;
  }
}
