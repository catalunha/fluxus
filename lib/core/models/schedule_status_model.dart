import 'dart:convert';

class ScheduleStatusModel {
  final String? id;
  final String? name;
  ScheduleStatusModel({
    this.id,
    this.name,
  });

  ScheduleStatusModel copyWith({
    String? id,
    String? name,
  }) {
    return ScheduleStatusModel(
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

  factory ScheduleStatusModel.fromMap(Map<String, dynamic> map) {
    return ScheduleStatusModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleStatusModel.fromJson(String source) =>
      ScheduleStatusModel.fromMap(json.decode(source));

  @override
  String toString() => 'ScheduleStatusModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScheduleStatusModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
