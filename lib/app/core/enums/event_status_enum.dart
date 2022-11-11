enum EventStatusEnum {
  emEspera('zoFBVNZ16I'),
  emEsperaNormal('0kCQxw8GBb'),
  emEsperaPrioridade('0kCQxw8GBb'),
  avaliacaoAgendada('7IZX1oPG7E'),
  avaliacaoAvaliado('7SWj262UYm'),
  avaliacaoFinalizada('i4DHFVCHvN'),
  profissionalAgendado('hpBM6CPlIV'),
  profissionalAtendido('hHJV8j1NR4'),
  profissionalFinalizado('yDvPaz7SzG'),
  pacienteNaoCompareceu('c0bYveZS7q'),
  pacienteCancelou('fCoyr6KnCn'),
  profissionalCancelou('OBRkRNvoUz');

  const EventStatusEnum(this.id);
  final String id;
}
