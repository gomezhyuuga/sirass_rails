@nueva_licenciatura = ->
	console.log 'nueva licenciatura'
<<<<<<< HEAD
	cur_time = new Date().getTime()
	new_name = "cprograma[licenciaturas_attributes][#{cur_time}]"
	new_id	 = "cprograma_licenciaturas_attributes_#{cur_time}"
=======
>>>>>>> final
	# TR layout
	@tr_licenciaturas = $('#acts').children('tr').first().clone()
	@num = $("#acts").contents('tr:last').attr('id').substr 3
	@num++
	new_name = "cprograma[licenciaturas_attributes][#{num}]"
	new_id	 = "cprograma_licenciaturas_attributes_#{num}"
	# Obtener inputs para cambiar id y name
<<<<<<< HEAD
	tr_licenciaturas.find('input[id*="_attributes"], select[id*="_attributes"], textarea[id*="_attributes"]').each (index, element) ->
=======
	@tr_licenciaturas.attr('id',"lic#{num}")
	@tr_licenciaturas.find('input[id*="_attributes"], select[id*="_attributes"], textarea[id*="_attributes"]').each (index, element) ->
>>>>>>> final
		@el 	= $(element)
		name 	= @el.attr('name').substr 38
		id 		= @el.attr('id').substr 36
		@el.attr 'name', "#{new_name}#{name}"
		@el.attr 'id', "#{new_id}#{id}"
	@tr_licenciaturas.find('a[id*="elim"]').attr('id',"elim#{num}").html()
	@tr_licenciaturas.find('a[id*="elim"]').attr('onclick',"eliminar_licenciatura(#{num})").html()
	$('#acts').append @tr_licenciaturas

# Eliminar licenciatura
@eliminar_licenciatura = (el) ->
	#Obtener el numero del ultimo tr
	numa = $('#acts').children('tr').size()
	#Si el numero es diferente de 0 lo remueve
	if numa != 1
		console.log "eliminar licenciatura"
		tr = $('#lic' + el)
		tr.remove()

@nuevo_responsable = ->
	console.log 'nuevo responsable'
	#Obtener el TR y clonarlo
	@tr_responsable = $('#respo').children('tr').first().clone()
	#Obtener el utimo numero de tr e incrementarlo para id
	@num = $("#respo").contents('tr:last').attr('id').substr 3
	@num++
	new_name = "cprograma[responsables_attributes][#{num}]"
	new_id	 = "cprograma_responsables_attributes_#{num}"
	# Obtener inputs para cambiar id y name
	@tr_responsable.attr('id',"res#{num}")
	@tr_responsable.find('input[id*="_attributes"]').each (index, element) ->
		@el 	= $(element)
		name 	= @el.attr('name').substr 37
		id 		= @el.attr('id').substr 35
		@el.attr 'name', "#{new_name}#{name}"
		@el.attr 'id', "#{new_id}#{id}"
	@tr_responsable.find('a[id*="elim"]').attr('id',"elim#{num}").html()
	@tr_responsable.find('a[id*="elim"]').attr('onclick',"eliminar_responsable(#{num})").html()
	$('#respo').append @tr_responsable

@eliminar_responsable = (el) ->
	#Obtener el total de tr's
	numr = $('#respo').children('tr').size()
	#Si el numero es diferente de 1 lo remueve
	if numr != 1
		console.log "eliminar responsable"
		tr = $('#res' + el)
		tr.remove()
