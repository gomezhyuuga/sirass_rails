$ ->
	id_programa = $('#programa_id')
	if id_programa.length > 0
		id = id_programa.val()
		console.log "Inscribiéndose al programa con id: #{id}"
		$('#inscripcion_cprograma_id').select2 "val", id