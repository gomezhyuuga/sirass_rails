# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# @cambiar_clave_programa = (el, id) ->
# 	@elemento = $(el)
# 	nombre_programa = @elemento.parents('td').prev().prev().contents('abbr').prop('title');
# 	clave_programa = @elemento.parents('td').prev().prev().prev().text().trim()
# 	message = "Cambiando clave de programa"
# 	modal_content = """Estás a punto de cambiar la clave del programa llamado: 
# 		<p class="well well-small lead">#{nombre_programa}</p>
# 		<p>Actualmente tiene la clave: <strong>#{clave_programa}</strong></p>
# 		<h4>Nueva clave</h4>
# 		<div class="input-append">
# 			<input type="text" class="input-medium" name="cprograma[cveprograma]" id="nueva_cveprograma_#{id}" value="#{clave_programa}" />
# 			<a class="btn btn-warning" href="/cprogramas/#{id}/generar_nueva_clave" data-remote="true">Generar</a>
# 		</div>
# 		<h6>Si la clave generada no coincide, introducir manualmente.</h6>
# 		"""
# 	# Generar modal de bootstrap
# 	modal = generate_modal message, modal_content, false, "submit"
# 	modal = 	"""<form action="/cprogramas/#{id}/update_clave" method="post">
# 						#{modal}"""
# 	modal +=	"""</form>"""
# 	$(modal).modal()
@activar = (el) ->
	anterior = el-1
	$('#'+anterior--+'').popover('hide')
	$('#'+el+'').popover('show')
@desact = (el) ->
	$('#'+el+'').popover('hide')
@next = (el) ->
	$('#tabs a[href="#'+el+'"]').tab('show')
	$('a[href="#'+el+'"]').fadeToggle().fadeToggle()
		
@fDuracion = (el) ->
	campoOculto = $('#fDuraOculta')
	date = new Date()
	if el.value == 'true'
		campoOculto.fadeOut()
	else
		campoOculto.fadeIn()
		if $('#11').popover('show')
			$('#duraHide').popover('show')
			for i in [0..11] by 1
				$('#'+i+'').popover('hide')
@otroTipoPrograma = (el) ->
	campoOculto = $('#otroTipoP')
	selectTipo = $('#s2id_cprograma_tipo_programa_id')
	if el.value == 'true'
		campoOculto.fadeIn()
		selectTipo.fadeOut()
		el.value = 'false'
	else
		selectTipo.fadeIn()
		campoOculto.fadeOut()
		el.value = 'true'
jQuery ->
	$('#1').popover({
			title: 'Tipo de Categoría interno <a class="close" onclick="desact(1)">×</button>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Selecciona la opción "Sí" solo si eres institución de la UACM de lo contrario la opción deberá ser "No"</p>
					  <a   onclick="activar(2)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#2').popover({
			title: 'Nombre del programa <a class="close" onclick="desact(2)">×</button>',
			trigger: 'manual',
			html: 'true',
			content: '<p class="justify">Aquí debes ponerle el nombre a tu futuro programa, el cual debe ir acorde a los fines que tiene tu programa.</p>
					  <a onclick="activar(3)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#3').popover({
			title: 'Objetivo General <a class="close" onclick="desact(3)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>El Objetivo general, como su nombre lo dice, explicará el ¿Por qué? de tu programa; es decir la finalidad que tendrá.</p>
					  <a onclick="activar(4)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#4').popover({
			title: 'Justificación <a class="close" onclick="desact(4)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Tendrás que justificar las razones que tienes para registrar un programa en la UACM.</p>
					  <a onclick="activar(5)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#5').popover({
			title: 'Desarrollo <a class="close" onclick="desact(5)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Escribe detalladamente el desarrollo de tu programa, es decir, ¿Cómo los prestadores llevarán acabo sus actividades al quedar inscritos a este programa?</p>
					  <a onclick="activar(6)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#6').popover({
			title: 'Recursos <a class="close" onclick="desact(6)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>¿Qué herramientas o materiales de trabajo tendrán los estudiantes?, para llevar acabo su servicio social en este programa. Y si es el caso, si contarán con un apoyo económico.</p>
					  <a onclick="activar(7)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#7').popover({
			title: 'Evaluación <a class="close" onclick="desact(7)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>¿Cómo serán evaluados los prestadores durante la realización de sus actividades?</p>
					  <a   onclick="activar(8)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#8').popover({
			title: 'Resultados <a class="close" onclick="desact(8)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>¿Qué se espera obtener de las actividades realizadas por los prestadores al concluir su servicio social?</p>
					  <a href="#" onclick="next(\'caract_programa\'); activar(9);" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#9').popover({
			title: 'Tipo de programa <a class="close" onclick="desact(9)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Escoje a que tipo de programa pertenece tu propuesta, si no se encuentra da click al botón AYUDA que te dirá que hacer, de lo contrario da click en siguiente.</p>
					  <a onclick="activar(10)" class="btn btn-mini btn-danger">AYUDA</a>
					  <a onclick="desact(9); activar(11)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#10').popover({
			title: 'Otro Tipo <a class="close" onclick="desact(10)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Diste click a ayuda, eso siginifica que no encontraste en el listado el tipo al que pertenece tu programa. Dale click al cuadrito y aparecerá un recuadro para que pongas el nombre del tipo al que pertenece tu programa.</p>
					  <a onclick="activar(11)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#11').popover({
			title: 'Duración <a class="close" onclick="desact(11)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Si tu programa no tiene una fecha definida deja seleccionado "Indeterminado". Pero si tu programa tiene una cierta duración selecciona "Determinado".</p><p><strong>NOTA:</strong>recuerda que la fecha para determinado debe ser mayor a 6 meses a partir de la fecha actual.</p>
					  <a onclick="activar(12)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#duraHide').popover({
			title: 'Fecha de duración <a class="close" onclick="desact(\'duraHide\')">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Ejemplo: si la fecha de hoy es 01/01/2000, tienes que seleccionar en el calendario una fecha mayor a 6 meses; es decir, de la fecha 01/07/2000 en adelante.</p>
					  <a onclick="desact(\'duraHide\'); activar(12)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#12').popover({
			title: 'Alcances de programa <a class="close" onclick="desact(12)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Selecciona que alcances tendra tu programa, si es más de uno, deja presionada la tecla ctrl y haz click en cada alcance que quieras integrar.</p>
					  <a onclick="activar(13)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#13').popover({
			title: 'Población a atender <a class="close" onclick="desact(13)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Selecciona que tipo de población será atendida por tu programa, si es más de uno, deja presionada la tecla ctrl y haz click en cada tipo de población que quieras integrar.</p>
					  <a onclick="activar(14)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#14').popover({
			title: 'Lugar de realización <a class="close" onclick="desact(14)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Aquí solo se pone la dirección en donde los prestadores tienen que asistir a realizar sus actividades.</p>
					  <a onclick="activar(15)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#15').popover({
			title: 'Días de realización <a class="close" onclick="desact(15)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Seleccionar los días en que los prestadores realizarán sus actividades de servicio, si es más de uno, dejar presionada la tecla ctrl y hacer click en los días preferidos.</p>
					  <a onclick="activar(16)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#16').popover({
			title: 'Horario del programa <a class="close" onclick="desact(16)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Selecciona en que tipo de horario se llevará acabo el servicio en tu programa; Matutino, Vespertino o Mixto.</p>
					  <a href="#" onclick="next(\'perfil_programa\'); activar(17);" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#17').popover({
			title: 'Agregar licenciatura <a class="close" onclick="desact(17)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Dependiendo el número de licenciaturas que vayas a necesitar para tu programa, con cada click se agrega una fila más para que puedas ingresar otra carrera.</p>
					  <a onclick="activar(18)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#18').popover({
			title: 'Licenciatura <a class="close" onclick="desact(18)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>¿Cuál es el nombre de la licenciatura que estará participando dentro de tu programa?</p>
					  <a onclick="activar(19)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#19').popover({
			title: 'Vacantes <a class="close" onclick="desact(19)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>¿Cuántas personas de esta licenciatura necesitas?.</p><p><strong>RECUERDA!</strong> las vacantes totales que solicites, estarán sujetas a las vacantes otorgadas por el/la responsable de Servicio Social de la UACM</p>
					  <a onclick="activar(20)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#20').popover({
			title: 'Actividades <a class="close" onclick="desact(20)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Describe que actividades realizarán los prestadores que se quieran postular para tu programa.</p>
					  <a onclick="activar(21)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#21').popover({
			title: 'Botón Eliminar <a class="close" onclick="desact(21)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Si no necesitas este registro con solo dar click se elimina la fila con la información.</p>
					  <a href="#" onclick="next(\'respon_programa\');activar(22)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#22').popover({
			title: 'Agregar responsable <a class="close" onclick="desact(22)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Agrega a la(s) persona(s) responsable(s) de este programa en proceso de registro, con cada click se agrega una fila más para que puedas ingresar otro responsable</p>
					  <a onclick="activar(23)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#23').popover({
			title: 'Responsable <a class="close" onclick="desact(23)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Ingresa el nombre de la persona que se hará cargo del programa</p>
					  <a onclick="activar(24)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#24').popover({
			title: 'Cargo <a class="close" onclick="desact(24)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>¿Qué cargo desempeña en el área de trabajo en la que se encuentra?</p>
					  <a onclick="activar(25)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#25').popover({
			title: 'E-mail @ <a class="close" onclick="desact(25)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Ingresa el E-mail de esa persona para poder estar en contacto.</p>
					  <a onclick="activar(26)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#26').popover({
			title: 'Botón eliminar <a class="close" onclick="desact(26)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Si no necesitas este registro con solo dar click se elimina la fila con la información.</p>
					  <a href="#" onclick="next(\'obser_programa\'); activar(27)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#27').popover({
			title: 'Observaciones del programa <a class="close" onclick="desact(27)">×</a>',
			trigger: 'manual',
			html: 'true',
			content: '<p>Si tienes que hacer alguna observación acerca de lo que será tu nuevo programa hazla saber.</p>
					  <a onclick="activar(29); activar(28)" class="btn btn-mini btn-info">Siguiente</a>',
			placement: 'left',
		})
	$('#28').popover({
			title: 'Botón "Limpiar campos"',
			trigger: 'manual',
			html: 'true',
			content: '<p>La función que tiene, es la de eliminar todos los datos registrados anteriormente.</p><p><strong>SOLO</strong> da click, cuando quieras cambiar gran parte de los datos que registraste.</p>
					  <a onclick="desact(28)" class="btn btn-mini btn-danger">Cerrar</a>',
			placement: 'right',
		})
	$('#29').popover({
			title: 'Botón "'+$('#29').val()+'"',
			trigger: 'manual',
			html: 'true',
			content: '<p>La función que tiene, es la de registrar el programa y enviarlo a las oficinas de Servicio Social de la UACM, para su validación y/o correción de posibles errores que el programa contenga.</p>
					  <a onclick="desact(29)" class="btn btn-mini btn-success">Cerrar</a>',
			placement: 'left',
		})