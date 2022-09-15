import 'dart:convert';

class ProfessionalModel {
  final String? id;

  ProfessionalModel({
    this.id,
  });

  ProfessionalModel copyWith({
    String? id,
  }) {
    return ProfessionalModel(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }

    return result;
  }

  factory ProfessionalModel.fromMap(Map<String, dynamic> map) {
    return ProfessionalModel(
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfessionalModel.fromJson(String source) =>
      ProfessionalModel.fromMap(json.decode(source));

  @override
  String toString() => 'ProfessionalModel(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfessionalModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
