jQuery ->
	actualizar_plantel = ->
		instituciones = $('select[id$=_institucion_id]')
		_planteles = $('select[id$=_plantel_id]')
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

	p_select = $('select[id$=_plantel_id]')
	instituciones = $('select[id$=_institucion_id]')
	planteles = $('select[id$=_plantel_id]').html()

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