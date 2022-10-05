import 'dart:convert';

/// Cargo: Adm, Sec, Aval, Prof, Paciente
class OfficeModel {
  final String? id;
  final String? name;
  final String? description;
  final bool? isDeleted;

  OfficeModel({
    this.id,
    this.name,
    this.description,
    this.isDeleted,
  });

  OfficeModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? isDeleted,
  }) {
    return OfficeModel(
      id: id ?? this.id,
      name: name ?? this.name,
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
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory OfficeModel.fromMap(Map<String, dynamic> map) {
    return OfficeModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OfficeModel.fromJson(String source) =>
      OfficeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OfficeModel(id: $id, name: $name, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OfficeModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
