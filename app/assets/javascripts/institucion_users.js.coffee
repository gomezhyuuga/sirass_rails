@nueva_licenciatura = ->
	console.log 'nueva licenciatura'
	cur_time = new Date().getTime()
	new_name = "cprograma[licenciaturas_attributes][#{cur_time}]"
	new_id	 = "cprograma_licenciaturas_attributes_#{cur_time}"
	# TR layout
	tr_licenciaturas = $('#acts').children('tr').first().clone()
	# Obtener inputs para cambiar id y name
	tr_licenciaturas.find('input[id*="_attributes"], select[id*="_attributes"], textarea[id*="_attributes"]').each (index, element) ->
		@el 	= $(element)
		console.log @el.html()
		name 	= @el.attr('name').substr 38
		id 		= @el.attr('id').substr 36
		@el.attr 'name', "#{new_name}#{name}"
		@el.attr 'id', "#{new_id}#{id}"
	$('#acts').append tr_licenciaturas.show()

# Eliminar licenciatura
@eliminar_licenciatura = (el) ->
	console.log "eliminar licenciatura"
	@tr = $(el).parent().parent()
	@tr.hide()
	@tr.find('input[id*="_destroy"]').val '1'

@nuevo_responsable = ->
	console.log 'nuevo responsable'
@eliminar_responsable = ->
	console.log "eliminar responsable"
