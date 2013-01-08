jQuery ->
	actualizar_plantel = ->
		instituciones = $('#institucion_user_institucion_id')
		_planteles = $('#institucion_user_plantel_id')
		institucion = instituciones.children(':selected').text()
		# console.log institucion
		escaped_institucion = institucion.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
		options = $(planteles).filter("optgroup[label='#{institucion}']").html()

		# Si la institución tiene planteles registrados
		if options
			_planteles.html(options)
			_planteles.parent().parent().slideDown()
		else
			_planteles.empty()
			_planteles.parent().parent().slideUp()
		_planteles.trigger("change");

	p_select = $('#institucion_user_plantel_id')
	instituciones = $('#institucion_user_institucion_id')
	planteles = $('#institucion_user_plantel_id').html()

	# Se está registrando una institución
	if instituciones.prop('selectedIndex') == 0
		# console.log "registrando"
		p_select.parent().parent().hide()
	else # Se está actualizando
		# console.log "actualizando"
		actualizar_plantel()
	
	instituciones.change (e) ->
		# console.log "index seleccionado: #{e.val}"
		actualizar_plantel()