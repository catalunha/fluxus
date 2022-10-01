import 'dart:convert';

/// Modalidade do evento
///
/// Ainda não entendi pra que.
class ModalityModel {
  final String? id;
  final String? name;
  final bool? isDeleted;

  ModalityModel({
    this.id,
    this.name,
    this.isDeleted,
  });

  ModalityModel copyWith({
    String? id,
    String? name,
    bool? isDeleted,
  }) {
    return ModalityModel(
      id: id ?? this.id,
      name: name ?? this.name,
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
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory ModalityModel.fromMap(Map<String, dynamic> map) {
    return ModalityModel(
      id: map['id'],
      name: map['name'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ModalityModel.fromJson(String source) =>
      ModalityModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ModalityModel(id: $id, name: $name, isDeleted: $isDeleted)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModalityModel &&
        other.id == id &&
        other.name == name &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isDeleted.hashCode;
}
