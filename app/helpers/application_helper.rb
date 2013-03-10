# -*- encoding : utf-8 -*-
module ApplicationHelper
	def full_title(page_title)
		base_title = "SiRASS"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def boolean_to_icon(boolean)
		iconClass = (boolean == true ? 'ok' : 'remove')
		content_tag :i, nil, class: "icon-#{iconClass}"
	end

	def current_date(format = '%d/%m/%Y')
		Date.today.strftime(format)
	end

	def programas_for_current_user
		if current_user.prestador.estudiante_uacm?
			# Si es estudiante interno de la UACM, se puede inscribir en cualquier programa
			return Cprograma.where(estado_programa_id: EstadoPrograma::ACTIVO)
		else
			# Solo programas internos si es estudiante externo a la UACM
			return Cprograma.where(categoria_interno: true, estado_programa_id: EstadoPrograma::ACTIVO)
		end
	end

	def puede_inscribirse?(programa)
		# Si es estudiante de la UACM puede inscribirse a cualquier programa
		if current_user.prestador && programa.categoria_interno? && !current_user.prestador.estudiante_uacm?
			return true
		elsif current_user.prestador && current_user.prestador.estudiante_uacm?
			return true
		else
			return false
		end
		# Si es estudiante externo solo puede inscribirse a un programa interno
	end

	def label_color_for_inscripcion(inscripcion)
		# == ESTADOS ==
	# 	VALIDANDO		= 1
	# EN_SERVICIO	= 2
	# SUSPENDIDO	= 3
	# BAJA				= 4
	# FINALIZADO	= 5
	# ERRORES			= 6
	# CORRECTA		= 7
		case inscripcion.estado_inscripcion_id
		when EstadoInscripcion::VALIDANDO 		then "label-info"
		when EstadoInscripcion::EN_SERVICIO 	then "label-success"
		when EstadoInscripcion::SUSPENDIDO 		then "label-warning"
		when EstadoInscripcion::BAJA 					then "label-important"
		when EstadoInscripcion::FINALIZADO 		then "label-success"
		when EstadoInscripcion::ERRORES 			then "label-important"
		when EstadoInscripcion::CORRECTA 			then "label-success"
		when EstadoInscripcion::ACTUALIZADA 	then "label-inverse"
		end
	end
end