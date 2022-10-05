import 'dart:convert';

/// Especialidade
class CidModel {
  final String? id;
  final String? name;
  final String? description;
  final bool? isDeleted;

  CidModel({
    this.id,
    this.name,
    this.description,
    this.isDeleted,
  });

  CidModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? isDeleted,
  }) {
    return CidModel(
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

  factory CidModel.fromMap(Map<String, dynamic> map) {
    return CidModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CidModel.fromJson(String source) =>
      CidModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CidModel(id: $id, name: $name, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CidModel &&
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
