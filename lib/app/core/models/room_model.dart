import 'dart:convert';

/// Sala de atendimento
class RoomModel {
  final String? id;
  final String? name;
  final String? description;
  final bool? isActive;
  final bool? isDeleted;
  RoomModel({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.isDeleted,
  });

  RoomModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? isActive,
    bool? isDeleted,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
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
    if (name != null) {
      result.addAll({'name': name});
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
      name: map['name'],
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
    return 'RoomModel(id: $id, name: $name, description: $description, isActive: $isActive, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.isActive == isActive &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        isActive.hashCode ^
        isDeleted.hashCode;
  }
}
