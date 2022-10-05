import 'dart:convert';

/// Convenio do paciente
class AgreementModel {
  final String? id;
  final String? name;
  final String? code;
  final DateTime? due;
  final String? description;
  final bool? isDeleted;

  AgreementModel({
    this.id,
    this.name,
    this.code,
    this.due,
    this.description,
    this.isDeleted,
  });

  AgreementModel copyWith({
    String? id,
    String? name,
    String? code,
    DateTime? due,
    String? description,
    bool? isDeleted,
  }) {
    return AgreementModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      due: due ?? this.due,
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
    if (due != null) {
      result.addAll({'due': due!.millisecondsSinceEpoch});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory AgreementModel.fromMap(Map<String, dynamic> map) {
    return AgreementModel(
      id: map['id'],
      name: map['name'],
      code: map['code'],
      due: map['due'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['due'])
          : null,
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AgreementModel.fromJson(String source) =>
      AgreementModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgreementModel(id: $id, name: $name, code: $code, due: $due, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgreementModel &&
        other.id == id &&
        other.name == name &&
        other.code == code &&
        other.due == due &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        code.hashCode ^
        due.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}
