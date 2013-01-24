@nueva_licenciatura = ->
	console.log 'nueva licenciatura'
	cur_time = new Date().getTime()
	new_name = "cprograma[licenciaturas_attributes][#{cur_time}]"
	new_id	 = "cprograma_licenciaturas_attributes_#{cur_time}"
	# TR layout
	@tr_licenciaturas = $('#acts').children('tr').first().clone()
	# Obtener inputs para cambiar id y name
	@tr_licenciaturas.find('input[id*="_attributes"], select[id*="_attributes"], textarea[id*="_attributes"]').each (index, element) ->
		@el 	= $(element)
		# Crear nuevo ID y NAME
		name 	= @el.attr('name').substr 38
		id 		= @el.attr('id').substr 36
		@el.attr 'name', "#{new_name}#{name}"
		@el.attr 'id', "#{new_id}#{id}"
		# Eliminar valores previos
		@el.val('')
	# Asignar ya_registrada por falso en boton eliminar
	@tr_licenciaturas.find('.btn-eliminar').attr('onclick', 'eliminar_licenciatura(this, false); return false;')
	$('#acts').append(@tr_licenciaturas).show()

# Eliminar licenciatura
@eliminar_licenciatura = (el, ya_registrada) ->
	console.log "eliminar licenciatura"
	tr = $(el).parents('tr')
	if ya_registrada
		console.log "ocultando"
		tr.hide()
		tr.find('input[id*="_destroy"]').val('true')
	else
		tr.remove()
		console.log "eliminando"

@nuevo_responsable = ->
	console.log 'nuevo responsable'
	cur_time = new Date().getTime()
	new_name = "cprograma[responsables_attributes][#{cur_time}]"
	new_id	 = "cprograma_responsables_attributes_#{cur_time}"
	#Obtener el TR y clonarlo
	@tr_responsable = $('#respo').children('tr').first().clone()
	@tr_responsable.find('input[id*="_attributes"]').each (index, element) ->
		@el 	= $(element)
		# Crear nuevo ID y NAME
		name 	= @el.attr('name').substr 38
		id 		= @el.attr('id').substr 36
		@el.attr 'name', "#{new_name}#{name}"
		@el.attr 'id', "#{new_id}#{id}"
		# Eliminar valores previos
		@el.val('')
	# Asignar ya_registrada por falso en boton eliminar
	@tr_responsable.find('.btn-eliminar').attr('onclick', 'eliminar_responsable(this, false); return false;')
	console.log @tr_responsable
	$('#respo').append @tr_responsable.show()

@eliminar_responsable = (el, ya_registrado) ->
	#Si el numero es diferente de 0 lo remueve
	tr = $(el).parents('tr')
	if ya_registrado
		console.log "ocultando"
		tr.hide()
		tr.find('input[id*="_destroy"]').val('true')
	else
		tr.remove()
		console.log "eliminando"