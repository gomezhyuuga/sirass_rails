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
@fDuracion = (el) ->
	campoOculto = $('#fDuraOculta')
	date = new Date()
	if el.value == 'true'
		campoOculto.fadeOut()
	else
		campoOculto.fadeIn()
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