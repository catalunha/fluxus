import 'dart:convert';

class RoomModel {
  final String? id;
  final String? name;
  final int? length;
  final int? width;
  final int? height;
  final bool? isActive;
  final String? description;
  final String? occupation;
  RoomModel({
    this.id,
    this.name,
    this.length,
    this.width,
    this.height,
    this.isActive,
    this.description,
    this.occupation,
  });

  RoomModel copyWith({
    String? id,
    String? name,
    int? length,
    int? width,
    int? height,
    bool? isActive,
    String? description,
    String? occupation,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      length: length ?? this.length,
      width: width ?? this.width,
      height: height ?? this.height,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
      occupation: occupation ?? this.occupation,
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
    if (length != null) {
      result.addAll({'length': length});
    }
    if (width != null) {
      result.addAll({'width': width});
    }
    if (height != null) {
      result.addAll({'height': height});
    }
    if (isActive != null) {
      result.addAll({'isActive': isActive});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (occupation != null) {
      result.addAll({'occupation': occupation});
    }

    return result;
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'],
      name: map['name'],
      length: map['length']?.toInt(),
      width: map['width']?.toInt(),
      height: map['height']?.toInt(),
      isActive: map['isActive'],
      description: map['description'],
      occupation: map['occupation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(id: $id, name: $name, length: $length, width: $width, height: $height, isActive: $isActive, description: $description, occupation: $occupation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.id == id &&
        other.name == name &&
        other.length == length &&
        other.width == width &&
        other.height == height &&
        other.isActive == isActive &&
        other.description == description &&
        other.occupation == occupation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        length.hashCode ^
        width.hashCode ^
        height.hashCode ^
        isActive.hashCode ^
        description.hashCode ^
        occupation.hashCode;
  }
}
