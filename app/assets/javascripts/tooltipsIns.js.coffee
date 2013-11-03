#@popovers = (el) ->
#	i = el-1
#	tabsCount = 0
#	btnsCount = 0
#	pCount = 0
#	pCount = 1 if (i >= 16 and i < 21) or (i >= 22 and i < 28)
#	pCount = 1 if i == 21 or i == 27 or i == 8 or i == 15
#	pCount = 3 if i == 20 or i == 26 or i == 30
#	btnsCount = 1 if i == 8
#	btnsCount = 3 if i == 28
#	btnsCount = 5 if i == 29
#	btnsCount = 4 if i == 30
#	if i == 7 or i == 15 or i == 21 or i == 27
#		btnsCount = 2
#		tabsCount = 3 if i == 7
#		tabsCount = 0 if i == 15
#		tabsCount = 1 if i == 21
#		tabsCount = 2 if i == 27
#	place = [
#		"left","top","bottom","right"
#	]
#	tit = [
#		"Tipo de Categoría interno", "Nombre del programa", "Objetivo General", "Justificación","Desarrollo","Recursos",
#		"Evaluación","Resultados","Tipo de programa","Otro Tipo","Duración","Alcances de programa","Población a atender",
#		"Lugar de realización","Días de realización","Horario del programa","Agregar licenciatura","Licenciatura","Vacantes",
#		"Actividades","Botón Eliminar","Responsable","Agregar responsable","Responsable","Cargo","E-mail @","Botón eliminar","Observaciones","Observaciones del programa",
#		'Botón "'+$('#'+(i+1)+'').val()+'"',"Botón \"Limpiar campos\""
#	]
#	msg = [
#		"Selecciona la opción \"Sí\" solo si eres institución de la UACM de lo contrario la opción deberá ser \"No\"",
#		"Aquí debes ponerle el nombre a tu futuro programa, el cual debe ir acorde a los fines que tiene tu programa.",
#		"El Objetivo general, como su nombre lo dice, explicará el ¿Por qué? de tu programa; es decir la finalidad que tendrá.",
#		"Tendrás que justificar las razones que tienes para registrar un programa en la UACM.",
#		"Escribe detalladamente el desarrollo de tu programa, es decir, ¿Cómo los prestadores llevarán acabo sus actividades al quedar inscritos a este programa?",
#		"¿Qué herramientas o materiales de trabajo tendrán los estudiantes?, para llevar acabo su servicio social en este programa. Y si es el caso, si contarán con un apoyo económico.",
#		"¿Cómo serán evaluados los prestadores durante la realización de sus actividades?",
#		"¿Qué se espera obtener de las actividades realizadas por los prestadores al concluir su servicio social?",
#		"Escoge a que tipo de programa pertenece tu propuesta, si no se encuentra da click al botón AYUDA que te dirá que hacer, de lo contrario da click en siguiente.",
#		"Diste click a ayuda, eso significa que no encontraste en el listado el tipo al que pertenece tu programa. Dale click al cuadro y aparecerá un recuadro para que pongas el nombre del tipo al que pertenece tu programa.",
#		"Si tu programa no tiene una fecha definida deja seleccionado \"Indeterminado\". Pero si tu programa tiene una cierta duración selecciona \"Determinado\".</p><p><strong>NOTA:</strong>recuerda que la fecha para determinado debe ser mayor a 6 meses a partir de la fecha actual.",
#		"Selecciona que alcances tendrá tu programa, si es más de uno, deja presionada la tecla ctrl y haz click en cada alcance que quieras integrar.",
#		"Selecciona que tipo de población será atendida por tu programa, si es más de uno, deja presionada la tecla ctrl y haz click en cada tipo de población que quieras integrar.",
#		"Aquí solo se pone la dirección en donde los prestadores tienen que asistir a realizar sus actividades.",
#		"Seleccionar los días en que los prestadores realizarán sus actividades de servicio, si es más de uno, dejar presionada la tecla ctrl y hacer click en los días preferidos.",
#		"Selecciona en que tipo de horario se llevará acabo el servicio en tu programa; Matutino, Vespertino o Mixto.",
#		"Dependiendo el número de licenciaturas que vayas a necesitar para tu programa, con cada click se agrega una fila más para que puedas ingresar otra carrera.",
#		"¿Cuál es el nombre de la licenciatura que estará participando dentro de tu programa?",
#		"¿Cuántas personas de esta licenciatura necesitas?.</p><p><strong>RECUERDA!</strong> las vacantes totales que solicites, estarán sujetas a las vacantes otorgadas por el/la responsable de Servicio Social de la UACM",
#		"Describe que actividades realizarán los prestadores que se quieran postular para tu programa.",
#		"Si no necesitas este registro con solo dar click se elimina la fila con la información.",
#		"Cuando ya hayas escrito las licenciaturas que necesitas en tu programa, da click en el botón",
#		"Agrega a la(s) persona(s) responsable(s) de este programa en proceso de registro, con cada click se agrega una fila más para que puedas ingresar otro responsable",
#		"Ingresa el nombre de la persona que se hará cargo del programa",
#		"¿Qué cargo desempeña en el área de trabajo en la que se encuentra?",
#		"Ingresa el E-mail de esa persona para poder estar en contacto.",
#		"Si no necesitas este registro con solo dar click se elimina la fila con la información.",
#		"Cuando ya hayas escrito a todos los responsables que forman parte y se harán cargo de tu programa, da click en el botón",
#		"Si tienes que hacer alguna observación acerca de lo que será tu nuevo programa hazla saber.",		
#		"La función que tiene, es la de registrar el programa y enviarlo a las oficinas de Servicio Social de la UACM, para su validación y/o corrección de posibles errores que el programa contenga.",
#		"La función que tiene, es la de eliminar todos los datos registrados anteriormente.</p><p><strong>SOLO</strong> da click, cuando quieras cambiar gran parte de los datos que registraste."
#	]
#	tabs = [
#		"\'perfil_programa\'","\'respon_programa\'","\'obser_programa\'","\'caract_programa\'"
#	]
#	btns = [
#		'<a onclick="activar('+(i+2)+')" class="btn btn-mini btn-info">Siguiente</a>',
#		'<a onclick="activar('+(i+2)+')" class="btn btn-mini btn-danger">AYUDA</a><a onclick="desact('+(i+1)+'); activar('+(i+3)+')" class="btn btn-mini btn-info">Siguiente</a>',
#		'<a href="#" onclick="next('+tabs[tabsCount]+'); activar('+(i+2)+');" class="btn btn-mini btn-info">Siguiente</a>',
#		'<a onclick="actInfo('+(i+3)+'); activar('+(i+2)+')" class="btn btn-mini btn-info">Siguiente</a>',
#		'<a onclick="desact('+(i+1)+')" class="btn btn-mini btn-danger">Cerrar</a>',
#		'<a onclick="desact('+(i+1)+')" class="btn btn-mini btn-success">Cerrar</a>'
#	]
#	$('#'+(i+1)+'').popover({
#		title: tit[i]+' <a class="close" onclick="desact('+(i+1)+')">×</a>',
#		trigger: 'manual',
#		html: 'true',
#		content:'<p>'+msg[i]+'</p>'+btns[btnsCount],
#		placement: place[pCount],
#	})
#	$('#duraHide').popover({
#		title: 'Fecha de duración <a class="close" onclick="desact(\'duraHide\')">×</a>',
#		trigger: 'manual',
#		html: 'true',
#		content: '<p>Ejemplo: si la fecha de hoy es 01/01/2000, tienes que seleccionar en el calendario una fecha mayor a 6 meses; es decir, de la fecha 01/07/2000 en adelante.</p>
#				  <a onclick="desact(\'duraHide\'); activar('+(i+2)+')" class="btn btn-mini btn-info">Siguiente</a>',
#		placement: 'left',
#	})
jQuery ->
	$('#ayuda').modal('show')
	$('#ayudaN').modal({
		show: false
		})

@ActAyuda = ->
	$('#ayudaN').modal('show')
@ActMod = (id, i, ant, num, pl) ->
	titM = [
		'Esto es lo que contiene el menú donde acabas de dar click',
		'Enviar Propuesta'
	]
	msg = [
		'<h2><i class="icon-user"></i>Perfil</h2><h3><small>Al igual que el link SiRASS, Perfil te regresa a la pantalla principal de tu cuenta.</small></h3>
		 <h2><i class="icon-off"></i>Cerrar sesión</h2><h3><small>Si ya no necesitas hacer nada en tu cuenta, evita que una mala persona robe tu identidad y lucre con tu perfil, evitemos estos problemas y mejor cierra tu sesión.</small></h3>',
		'Aquí encontraras el formulario que tienes que llenar para enviar una propuesta, si no sabes como se llena encontraras una leyenda y un botón al inicio igual a estos:
			<p>¿NO SABES COMO LLENAR EL FORMULARIO?, Da click en el botón<a href="#" class="btn btn-medium btn-success" onclick="activar(1)" >¿Cómo llenar?</a><p>',
		''
	]

	html = """
	         <div class="modal fade" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	           <div class="modal-header">
	             <h3 id="myModalLabel">#{titM[id]}</h3>
	           </div>
	           <div class="modal-body">
			        #{msg[id]}
	           </div>
	           <div class="modal-footer">
	    			<a onclick="Act('#{i}','#{ant}',#{num},#{pl})" class="btn btn-success confirm" data-dismiss="modal" aria-hidden="true">Continuar</a>
	           </div>
	         </div>
	         """
	$(html).modal('show')

@Act = (id, ant, num, pl, ayuda) ->
	#id es el siguiente popover por activar
	#ant el anterior
	#num el número para los arreglos msg[num] y tit[num] que es el correspondiente a id
	#pl es para el tipo de lugar donde se mostrara el popover place[pl]
	pl = 2
	btn = 1
	btn = 0 if num == 4
	btn = 2 if num == 9
	pl = 2 if num == 5 or num == 6
	btn = 0 if ayuda == 1
	place = [
		"left","top","bottom","right"
	]
	titl = [
		'SiRASS','Programas','Proceso','Ayuda','Menú','Inicio','Editar Datos','Nueva Propuesta','Actualizar Programas','Avisos'
	]
	msg = [
		'Este es el nombre de la aplicación "SiRASS, sino sabes donde estas, tiene un link que te regresara a tu perfil.',
		'Aquí podras consultar la lista de programas que se han registrado.'
		'Proceso se refiere a que pasos deberas llevar como usuario institución. <p>Para que la UACM te permita participar en el registro de programas de servicio social y así tengas prestadores registrados en tu programa.</p>
		<p><strong>RECUERDA:</strong> solo cuando tu propuesta sea aceptada por las oficinas de Servicio Social de la UACM los prestadores empezarán a registrarse.</p>',
		'Ayuda: Si no recuerdas ¿Qué hacer? en alguna de las secciones de tu perfil tanto en el menú lateral izquierdo como en la barra superior, cuando lo necesites aquí te ayudaremos.',
		'Este es un menú pequeño donde esta tu nombe de usuario <strong class=" icon-share-alt">Da Click</strong>',
		'Este es un link que te trae de regreso a tu página inicial',
		'Aquí puedes cambiar los datos con los que te registraste, datos de institución y de usuario (Nombre de usuario, contraseña, email).',
		'Desde aquí puedes enviar tu solicitud para registrar un programa de Servicio Social',
		'En actualizar cuentas con la lista de tus programas y podrás modificarlos o ver cuales ya han sido activados y cuales no',
		'La Oficina de Servicio Social de la UACM revisa tus propuestas y si alguna necesita correción o ya fue aceptada, en la parte de avisos están todas las notificaciones.'
	]
	ids = [
		'programas','proceso','help','menuDrop','home','perfil','sendPropues','actualPropues','avisosPropues'
	]
	btns = [
		' ',
		'<a onclick="Act(\''+ids[num]+'\',\''+id+'\','+(num+1)+','+pl+','+null+')" class="btn btn-mini btn-info">Siguiente</a>',
		'<a onclick="Fin()" class="btn btn-mini btn-info">Siguiente</a>'
	]

	$('#'+id+'').popover({
		title: titl[num]+' <a class="close" onclick="desact(\''+id+'\')">×</a>',
		trigger: 'click',
		html: 'true',
		content:'<p>'+msg[num]+'</p>'+btns[btn],
		placement: place[pl],
	})
	$('#'+id+'').popover('show')
	$('#'+ant+'').popover('hide') if ant != null
	$('#ayuda').modal('hide')
	$('#ayudaN').modal('hide') if ayuda == 1
@desact = (el) ->
	$('#'+el+'').popover('hide')
@Fin = ->
	$('#Terminado').modal('show')