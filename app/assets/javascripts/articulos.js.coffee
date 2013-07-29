# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@getAntiguedad = (el) ->
	valorIngreso = $('#ingreso').val()
	if valorIngreso != ''
		DAY = 1000 * 60 * 60  * 24
		i = 0
		msg = ""
		anio = " Año con "
		dias = " Día"
		d1 = new Date('\''+valorIngreso.substr(3,2)+'/'+valorIngreso.substr(0,2)+'/'+valorIngreso.substr(6,4)+'\'') if valorIngreso != ''
		d2 = new Date()
		today = new Date('\''+(d2.getMonth()+1)+'/'+d2.getDate()+'/'+d2.getFullYear()+'\'')
		days_passed = Math.round((today.getTime() - d1.getTime()) / DAY)
		if days_passed >= 365
			while days_passed >= 365
				days_passed -= 365
				i++
		anio = " Años con " if i > 1
		dias = " Días" if days_passed > 1
		if (i >= 1 and days_passed > 1) or (i >= 1 and days_passed == 1)
			msg = i+anio+days_passed+dias
		if (i == 0 and days_passed > 1) or (i == 0 and days_passed == 1)
			msg = days_passed+dias
		if i == 0 and days_passed == 0
			alert 'Acabas de ingresar a trabajar?'
			msg = 'Sin antiguedad'
		document.getElementById('antig').value = msg
	else
		alert 'Falta la fecha en que ingresaste a laborar'

