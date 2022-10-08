import 'dart:convert';

/// Especialidade
class ExpertiseModel {
  final String? id;
  final String? name;
  final String? code;
  final String? description;
  final bool? isDeleted;

  ExpertiseModel({
    this.id,
    this.name,
    this.code,
    this.description,
    this.isDeleted,
  });

  ExpertiseModel copyWith({
    String? id,
    String? name,
    String? code,
    String? description,
    bool? isDeleted,
  }) {
    return ExpertiseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
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
    if (code != null) {
      result.addAll({'code': code});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory ExpertiseModel.fromMap(Map<String, dynamic> map) {
    return ExpertiseModel(
      id: map['id'],
      name: map['name'],
      code: map['code'],
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpertiseModel.fromJson(String source) =>
      ExpertiseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpertiseModel(id: $id, name: $name, code: $code, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpertiseModel &&
        other.id == id &&
        other.name == name &&
        other.code == code &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        code.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
