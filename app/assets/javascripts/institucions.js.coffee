$ ->
	p_select = $('#institucion_user_plantel_id')
	if p_select.children(':selected').text()?
		p_select.parent().parent().hide()
	planteles = $('#institucion_user_plantel_id').html()
	instituciones = $('#institucion_user_institucion_id')
	instituciones.change ->
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

	$('.chzn-select').chosen().change (ok)->
		console.log ok
		console.log 'cmabiado'