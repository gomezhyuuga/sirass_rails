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

# Funciones para sección de agregar plantel
@show_add_plantel = ->
	console.log "agregar plantel"
	input = $('#add_plantel_form')
	input.slideDown()
	$('select[id$=_plantel_id]').parent().parent().slideUp()
@hide_add_plantel = ->
	console.log "eliminar plantel"
	input = $('#nuevo_plantel_nombre')
	input.val('')
	input.parent().parent().parent().slideUp()
	$('select[id$=_plantel_id]').parent().parent().slideDown()
# Funciones para sección de agregar institución
@show_add_institucion = ->
	console.log "agregar institución"
	input = $('#add_institucion_form')
	input.slideDown()
	$('select[id$=_institucion_id]').parent().parent().slideUp()
@hide_add_institucion = ->
	console.log "eliminar institución"
	input = $('#nueva_institucion_nombre')
	input.val('')
	input.parent().parent().parent().slideUp()
	$('select[id$=_institucion_id]').parent().parent().slideDown()