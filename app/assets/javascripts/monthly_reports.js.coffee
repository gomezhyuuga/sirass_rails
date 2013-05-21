# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@remove_hour = (elemento, nuevo) ->
	el = $(elemento).parents('tr')
	registros = el.parents('tbody').find('tr:visible')
	# No permitir si sólo queda un elemento
	console.log registros.length
	if registros.length > 1
		# En caso que el registro ya esté guardado en la BD, marcar para eliminar
		if not nuevo
			# Marcar para eliminar
			destroy_input = el.find('input[id*="destroy"]')
			destroy_input.val(true)
			console.log destroy_input.val()
			el.hide()
		else
			# En caso contrario eliminar del DOM
			el.remove()


@add_hour = ->
	console.log "Agregando nueva hora..."
	# Crear nuevo elemento de registro
	# tr = $('#table_horas tbody tr:first').clone()
	# time = new Date().getTime()
	# # Cambiar ID y NAME
	# tr.find('input[id*="monthly_report_monthly_report_hours_attributes_"]').each (i, el) ->
	# 	name = el.name
	# 	id = el.id
	# 	el.name = name[0..46] + "[#{time}]" + name[50..]
	# 	el.id = id[0..46] + "#{time}" + id[48..]
	# # Establecer que es un registro nuevo
	# tr.find('button.btn-danger').attr 'onclick', 'remove_hour(this, true)'
	tr = $('#hora_template').clone()
	console.log tr.html()
	# Activer timepicker
	tr.appendTo($('#table_horas tbody'))
$('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $('#table_horas tbody').append($(this).data('fields').replace(regexp, time))
    event.preventDefault()
    calcularTiempo()

$(document).ready ->
	$('select.time').change (ev) ->
		calcularTiempo $('select.time')
		

@calcularTiempo = (selects) ->
	selects = $('select.time')
	horas = 0
	mins = 0
	restar_horas = 0
	# selects.each (index, element) ->
	# 	tipo = $(this).attr('id')[-2..-1]
	# 	console.log $(this).attr 'name'
	# 	if tipo == "4i"
	# 		# Es elemento de hora
	# 		horas += Number(element.value)
	# 	else
	# 		# Es elemento de minutos
	# 		mins += Number(element.value)
	for i in [0...selects.length] by 4
		hentrada = Number selects[i].value
		mentrada = Number selects[i+1].value
		hsalida = Number selects[i+2].value
		msalida = Number selects[i+3].value
		difHoras = hsalida - hentrada
		if msalida > mentrada
			mins += msalida - mentrada
		else
			restar_horas += 1
			mins += msalida + (60 - mentrada)
		horas += difHoras
	horas -= restar_horas
	horas += Math.floor(mins/60)
	mins = mins % 60
	horasString = rellenarCeros(horas)
	minsString = rellenarCeros(mins)
	$('#monthly_report_horas').val "#{horasString}:#{minsString}"
	
	anteriores = $('#monthly_report_horas_anteriores').val()
	console.log anteriores[0...2]
	hAcum = Number(anteriores[0...2]) + horas
	mAcum = Number(anteriores[3..5]) + mins
	hAcum += Math.floor(mAcum/60)
	mAcum = mAcum % 60
	hAcumString = rellenarCeros(hAcum)
	mAcumString = rellenarCeros(mAcum)
	console.log hAcum
	console.log mAcum
	$('#monthly_report_horas_acum').val "#{hAcumString}:#{mAcumString}"	

rellenarCeros = (numero) ->
	if numero < 10 and numero >= 0
		"0#{numero}"
	else
		numero
	