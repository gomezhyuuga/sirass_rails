# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('#toggle_servicio_social, #toggle_practica_profesional').click ->
		@btn = $(this)
		if !@btn.hasClass 'active'
			console.log @btn.val()
			$('#inscripcion_practicas').val @btn.val()