# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@detallesPorStat = (msg) ->
	tableOcultS = $('#Suspend')
	tableOcultO = $('#Obser')
	if msg == 'Obs'
		tableOcultS.fadeOut(50)
		tableOcultO.fadeIn(2000)
	if msg == 'Susp'
		tableOcultO.fadeOut(50)
		tableOcultS.fadeIn(2000)
	