import 'dart:convert';

class ModalityModel {
  final String? id;
  final String? name;
  ModalityModel({
    this.id,
    this.name,
  });

  ModalityModel copyWith({
    String? id,
    String? name,
  }) {
    return ModalityModel(
      id: id ?? this.id,
      name: name ?? this.name,
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

    return result;
  }

  factory ModalityModel.fromMap(Map<String, dynamic> map) {
    return ModalityModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModalityModel.fromJson(String source) =>
      ModalityModel.fromMap(json.decode(source));

  @override
  String toString() => 'ModalityModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModalityModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
