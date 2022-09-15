import 'dart:convert';

class RoomModel {
  final String? id;
  final String? name;
  final bool? isActive;
  final String? description;
  RoomModel({
    this.id,
    this.name,
    this.isActive,
    this.description,
  });

  RoomModel copyWith({
    String? id,
    String? name,
    bool? isActive,
    String? description,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
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
    if (isActive != null) {
      result.addAll({'isActive': isActive});
    }
    if (description != null) {
      result.addAll({'description': description});
    }

    return result;
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      name: map['name'],
      isActive: map['isActive'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(id: $id, name: $name, isActive: $isActive, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.id == id &&
        other.name == name &&
        other.isActive == isActive &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isActive.hashCode ^
        description.hashCode;
  }
}
