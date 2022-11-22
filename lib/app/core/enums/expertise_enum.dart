import 'package:flutter/material.dart';

enum ExpertiseEnum {
  psicologia('0yvOXKwqnw', Colors.green),
  enfermeira('Ln2ruvr8uA', Colors.blue),
  fonoaudiologia('LaYJskK3cb', Colors.orange);

  const ExpertiseEnum(this.id, this.cor);
  final String id;
  final Color cor;
}
