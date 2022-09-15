import 'dart:convert';

class AgreementModel {
  final String? id;
  final String? name;
  final String? code;
  final DateTime? due;
  final bool? isActive;
  AgreementModel({
    this.id,
    this.name,
    this.code,
    this.due,
    this.isActive,
  });

  AgreementModel copyWith({
    String? id,
    String? name,
    String? code,
    DateTime? due,
    bool? isActive,
  }) {
    return AgreementModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      due: due ?? this.due,
      isActive: isActive ?? this.isActive,
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
    if (isActive != null) {
      result.addAll({'isActive': isActive});
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
      isActive: map['isActive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AgreementModel.fromJson(String source) =>
      AgreementModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgreementModel(id: $id, name: $name, code: $code, due: $due, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgreementModel &&
        other.id == id &&
        other.name == name &&
        other.code == code &&
        other.due == due &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        code.hashCode ^
        due.hashCode ^
        isActive.hashCode;
  }
}
