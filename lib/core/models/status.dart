enum EventStatus {
  registered,
  onHold,
  evaluation,
  toForward,
  scheduled,
  inAttendance,
  next,
  wait,
  done,
  canceledProfessional,
  canceledPatient,
}
/*
1. Paciente é cadastro pela secretaria
Status: Cadastrado

2.1 Secretária marca Evento 1 com Avaliadoras,Cliente, sem Sala, nem Data
Descrição: ansiedade/etc
Status: Em espera

3.1 Secretária Agenda o Evento 1 do Avaliador,Cliente com Sala,Data
Descrição: ansiedade/etc
Status: Avaliação

3.2 Avaliador analisa. Fim Evento 1
Descrição: ansiedade/etc
Descrição: Encaminhar para Profissional X. Secretaria criará novo evento
Status: Encaminhar

3.3 Avaliador analisa. Fim Evento 1
Descrição: ansiedade/etc
Descrição: Encaminhar para lista de espera do Avaliador X. Secretaria criará novo evento
Status: Encaminhar

3.4 Avaliador analisa. Fim Evento 1
Descrição: ansiedade/etc
Descrição: Nao tem atendimento posterior.
Status: Finalizado

4.1 Secretária Agenda o Evento 2 do Prof,Cliente com Sala,Data. 
Descrição: Encaminho pela Avaliadora X
Status: Agendado

4.2 Profissional atende. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: Paciente precisa e quer ( e pode ) nova seção.
Status: Nova seção

4.3 Profissional atende. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: Paciente precisa mas não quer ( nem pode ) nova seção
Status: Aguardar

4.4 Profissional atende. Fim Evento 2
Descrição: Encaminho pela Avaliadora X
Descrição: Encerrar tratamento
Status: Finalizado.



*/