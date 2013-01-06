$ ->
	actualizar_plantel = ->
		instituciones = $('#institucion_user_institucion_id')
		_planteles = $('#institucion_user_plantel_id')
		institucion = instituciones.children(':selected').text()
		escaped_institucion = institucion.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
		options = $(planteles).filter("optgroup[label='#{institucion}']").html()
		if options
			_planteles.html(options)
			_planteles.parent().parent().slideDown()
		else
			_planteles.empty()
			_planteles.parent().parent().slideUp()
		_planteles.trigger("liszt:updated");

	p_select = $('#institucion_user_plantel_id')
	instituciones = $('#institucion_user_institucion_id')
	planteles = $('#institucion_user_plantel_id').html()

	console.log instituciones.prop("selectedIndex")
	# Se está creando uno nuevo
	if instituciones.prop('selectedIndex') == 0
		p_select.parent().parent().hide()
	else
		actualizar_plantel()
	
	instituciones.chosen().change ->
		actualizar_plantel()

	$('.chzn-select').chosen().change (ok)->
		console.log ok
		console.log 'cmabiado'