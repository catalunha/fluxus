# fluxus

A new Flutter project.

# History

catalunha@pop-os:~/myapp$ flutter create --project-name=fluxus --org br.net.cemec --platforms android,web ./fluxus

qsRservationEspacos = Reserva.objects.filter(
    Q(data=self.data, espaco=self.espaco) &
    Q(horaFim__gt=self.horaInicio) & #É gt mesmo - 22/12/2016
    Q(horaInicio__lt=self.horaFim) & #É lt mesmo - 30/01/2017
    Q(status=1)
)
