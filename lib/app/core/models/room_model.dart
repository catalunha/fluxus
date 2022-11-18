import 'dart:convert';

import 'package:fluxus/app/core/utils/drop_down_abstract.dart';

/// Sala de atendimento
class RoomModel extends DropDrowAbstract {
  final String? id;
  // final String? name;
  final String? code;
  final String? description;
  final bool? isActive;
  final bool? isDeleted;
  RoomModel({
    this.id,
    super.name,
    this.code,
    this.description,
    this.isActive,
    this.isDeleted,
  });

  RoomModel copyWith({
    String? id,
    String? code,
    String? description,
    bool? isActive,
    bool? isDeleted,
  }) {
    return RoomModel(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (code != null) {
      result.addAll({'code': code});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isActive != null) {
      result.addAll({'isActive': isActive});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      code: map['code'],
      description: map['description'],
      isActive: map['isActive'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(id: $id, code: $code, description: $description, isActive: $isActive, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.id == id &&
        other.code == code &&
        other.description == description &&
        other.isActive == isActive &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        description.hashCode ^
        isActive.hashCode ^
        isDeleted.hashCode;
  }
}
