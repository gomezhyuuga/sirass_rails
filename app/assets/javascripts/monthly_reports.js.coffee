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
	tr = $('#table_horas tbody tr:first').clone()
	time = new Date().getTime()
	# Cambiar ID y NAME
	tr.find('input[id*="monthly_report_monthly_report_hours_attributes_"]').each (i, el) ->
		name = el.name
		id = el.id
		el.name = name[0..46] + "[#{time}]" + name[50..]
		el.id = id[0..46] + "#{time}" + id[48..]
	# Establecer que es un registro nuevo
	tr.find('button.btn-danger').attr 'onclick', 'remove_hour(this, true)'
	tr.appendTo $('#table_horas tbody')
