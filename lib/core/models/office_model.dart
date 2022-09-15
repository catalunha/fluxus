import 'dart:convert';

class OfficeModel {
  final String? id;
  final String? name;
  final String? description;
  OfficeModel({
    this.id,
    this.name,
    this.description,
  });

  OfficeModel copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return OfficeModel(
      id: id ?? this.id,
      name: name ?? this.name,
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
    if (description != null) {
      result.addAll({'description': description});
    }

    return result;
  }

  factory OfficeModel.fromMap(Map<String, dynamic> map) {
    return OfficeModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OfficeModel.fromJson(String source) =>
      OfficeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OfficeModel(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OfficeModel &&
        other.id == id &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
