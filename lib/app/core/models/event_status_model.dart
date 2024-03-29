import 'dart:convert';

import 'package:fluxus/app/core/utils/drop_down_abstract.dart';

/// Status do evento
class EventStatusModel extends DropDrowAbstract {
  final String? id;
  // final String? name;
  final String? description;
  final bool? isDeleted;
  EventStatusModel({
    this.id,
    super.name,
    this.description,
    this.isDeleted,
  });

  EventStatusModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? isDeleted,
  }) {
    return EventStatusModel(
      id: id ?? this.id,
      name: name ?? this.name,
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
    if (description != null) {
      result.addAll({'description': description});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory EventStatusModel.fromMap(Map<String, dynamic> map) {
    return EventStatusModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventStatusModel.fromJson(String source) =>
      EventStatusModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventStatusModel(id: $id, name: $name, description: $description, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventStatusModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        isDeleted.hashCode;
  }
}

/*
Em qq momento o evento pode estar em edição. 
Ou seja a S/A/P estão atualizando alguma coisa naquele registro naquele momento.
Status: Em edição

1.1 Secretárias. Cadastra Paciente. Cria Evento 1. Com (Especialidade ou Avaliadoras) e Paciente. Sem Sala/Data
Descrição: ansiedade/etc
Status: Em espera

1.2 Secretárias. Paciente cancela evento.  Fim Evento 1
Descrição:  Paciente cancela evento em qq status.
Status: Cancelado pelo paciente.
@ nenhuma. paciente é apenas cadastrado.

2.1 Avaliadoras. Sem a presença da paciente analisa Evento 1 (com status: Em espera) e atualiza Status. Paciente continua sem Sala,Data
Descrição: ansiedade/etc
Descrição: necessita real atendimento,
Status: Em espera. Prioridade
Descrição: pode aguardar,
Status: Em espera. Normal
@ nenhuma. mesmo que avaliadora atue não gera pagamento do evento.

// surgindo espaço na agenda das avaliadoras. secretaria entra em contato com paciente e agenda avaliação

1.3 Secretárias. Agenda o Evento 1 da Avaliadora com Paciente. Com Sala/Data
Descrição: ansiedade/etc
Status: Avaliação agendada

2.2 Avaliadora. Atendendo paciente. Fim Evento 1
Descrição: Encaminhar para Profissional X.
Status: Encaminhar
@ Secretaria criará novo evento
@ profissional recebe.

2.3 Avaliadora. Atendendo paciente. Fim Evento 1
Descrição: Encaminhar para lista de espera da (Especialidade ou Avaliadoras).
Status: Encaminhar
@ Secretaria criará novo evento
@ profissional recebe.

2.4 Avaliadora. Atendendo paciente. Fim Evento 1
Descrição: ansiedade/etc
Descrição: Não é atendimento para clinica.
Status: Finalizado na avaliação.
@ profissional recebe.

2.5 Avaliadora. Avaliadora presente paciente desmarca na hora. Fim Evento 1
Descrição: ansiedade/etc
Descrição: paciente desmarcou
Status: Desmarcado pelo paciente.
@ Secretaria criará novo evento ou não. Paciente fica apenas cadastrado sem eventos.
@ profissional recebe.

2.6 Secretárias. Paciente presente avaliadora desmarca na hora. Fim Evento 1
Descrição: ansiedade/etc
Descrição: paciente desmarcou
Status: Desmarcado pelo avaliador.
@ Secretaria criará novo evento ou não. Paciente fica apenas cadastrado sem eventos.

// secretaria consulta eventos com status encaminhar
// financeiro consulta eventos com status 'Encaminhar'/'Desmarcado pelo paciente'/'Finalizado na avaliação'/'Finalizado na avaliação.' para pagamento do evento.

1.4 Secretárias. Agendam o Evento 2 do Profissiona(l/ais) com Pacient(e/es) com Sala,Data. 
Descrição: Encaminhado pela Avaliadora X
Status: Agendado

3.1 Profissional atende. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: Paciente em atendimento precisa, quer, pode nova seção.
Status: Nova seção
@ Secretaria criará novo evento
@ profissional recebe.

3.2 Profissional atendendo. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: Paciente em atendimento. precisa mas não quer ( nem pode ) nova seção. Paciente para tratamento.
Status: Pausar tratamento
@ profissional recebe.

3.3 Profissional faltou. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: profissional nao pode vir
Status: Desmarcado pelo Profissional
@ Secretaria criará novo evento
// ao criar evento copia para agendamento o app registra a origem do pedido que é o evento 1

3.4 Profissional atende. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: Paciente pede para desmarcar o agendamento.
Status: Desmarcado pelo paciente
@ Secretaria criará novo evento

3.5 Profissional atendendo. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: Paciente pede para desmarcar o agendamento. adiando para depois
Status: Adiar

3.6 Profissional atende. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: Profissional na sala e paciente cancela
Status: Cancelado Pelo Paciente
@ profissional recebe.

3.7 Profissional atende. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: Paciente na sala de espera e profissional cancela.
Status: Cancelado pelo Profissional

3.8 Profissional atende. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: Encerrar tratamento.
Status: Finalizado.
@ profissional recebe.
*/

