# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('#toggle_servicio_social, #toggle_practica_profesional').click ->
		@btn = $(this)
		# Actuar solo si no está activo el toggle button
		if !@btn.hasClass 'active'
			console.log @btn.val()
			$('#inscripcion_practicas').val @btn.val()
			# Mostrar u ocultar campo de prácticas profesionales
			if @btn.prop('id') == "toggle_practica_profesional"
				$('#practica_profesional').slideDown()
			else
				$('#practica_profesional').slideUp()