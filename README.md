# fluxus

cd /home/catalunha/myapp/cemec.net.br/fluxus && flutter build web && cd /home/catalunha/myapp/cemec.net.br/fluxus/back4app/fluxus && b4a deploy

# Diary

#
marciocatalunha@gmail.com
123456


# Cadastrar evento google calendar
https://calendar.google.com/calendar/u/0/r/eventedit?text=Prele%C3%A7%C3%B5es+Sola+Fide&dates=20221015T120000000Z/20221016T140000000Z&details=Confira+seus+ingresos+na+Sympla.%0A%0A-+Acesse+o+menu+%22Ingressos%22+no+site+ou+aplicativo+da+Sympla+e+crie+uma+conta+ou+fa%C3%A7a+login+utilizando+o+seu+email.%0Ahttps://www.sympla.com.br/meus-ingressos%0A%0A-+Para+mais+informa%C3%A7%C3%B5es+sobre+o+evento+acesse:%0Ahttps://www.sympla.com.br/evento/prelecoes-sola-fide/1730373%0A&location=Quadra+208+Sul+Alameda+15,+1,+Palmas+TO,+BRASIL&ctz=America/Sao_Paulo


# Busca Agenda

catalunha@pop-os:~/myapp$ flutter create --project-name=fluxus --org br.net.cemec --platforms android,web ./fluxus

qsRservationEspacos = Reserva.objects.filter(
    Q(data=self.data, espaco=self.espaco) &
    Q(horaFim__gt=self.horaInicio) & #É gt mesmo - 22/12/2016
    Q(horaInicio__lt=self.horaFim) & #É lt mesmo - 30/01/2017
    Q(status=1)
)

