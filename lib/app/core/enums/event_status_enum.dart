enum EventStatusEnum {
  indefinido('ul5FxaUpOX'),
  emEspera('zoFBVNZ16I'),
  emEsperaNormal('TBlbt1gbW3'),
  emEsperaPrioridade('0kCQxw8GBb'),
  emEsperaAtendido('BYJe2NL7QI'),
  eventoAgendado('hpBM6CPlIV'),
  eventoConfirmado('KVbI4XBPGe'),
  eventoAtendido('hHJV8j1NR4'),
  eventoFinalizado('yDvPaz7SzG'),
  // pacienteNaoCompareceu('c0bYveZS7q'),
  pacienteCancelou('fCoyr6KnCn'),
  profissionalCancelou('OBRkRNvoUz');
  // avaliacaoAgendada('7IZX1oPG7E'),
  // avaliacaoAvaliado('7SWj262UYm'),
  // avaliacaoFinalizada('i4DHFVCHvN'),

  const EventStatusEnum(this.id);
  final String id;
}
