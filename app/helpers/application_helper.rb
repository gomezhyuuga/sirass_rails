# -*- encoding : utf-8 -*-
module ApplicationHelper

	def links_to_estado(catalogo, url)
		html = ''
		clase = params[:estado].blank? ? "btn-warning" : "btn-inverse"
		html << link_to("Todos", url, class: "btn btn-mini #{clase}")
		html << ' '
		catalogo.all.each do |p|
			url[:estado] = p.id
			clase = params[:estado].to_i == p.id ? "btn-warning" : "btn-inverse"
			html << link_to( p.descripcion, url, class: "btn btn-mini #{clase}" )
			html << ' '
		end
		html.html_safe
	end

	def links_to_estado_art(catalogo, url)
		html = ''
		clase = params[:estado].blank? ? "btn-warning" : "btn-inverse"
		html << link_to("Todos", url, class: "btn btn-mini #{clase}")
		html << ' '
		catalogo.all.each do |p|
			if p.id == 1 or p.id == 4 or p.id == 5 or p.id == 6 or p.id == 8
				url[:estado] = p.id
				clase = params[:estado].to_i == p.id ? "btn-warning" : "btn-inverse"
				html << link_to( p.descripcion, url, class: "btn btn-mini #{clase}" )
				html << ' '
			end
		end
		html.html_safe
	end

	def link_to_add_fields(name, f, association)
	  new_object = f.object.send(association).klass.new
	  id = new_object.object_id
	  fields = f.fields_for(association, new_object, child_index: id) do |builder|
	    render(association.to_s.singularize + "_fields", f: builder)
	  end
	  link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
	end
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
			return Cprograma.where("estado_programa_id = ? AND vacantes > 0", EstadoPrograma::ACTIVO)
		else
			# Solo programas internos si es estudiante externo a la UACM
			return Cprograma.where("estado_programa_id = ? AND vacantes > 0 AND categoria_interno = ?", EstadoPrograma::ACTIVO, true)
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
		when EstadoInscripcion::BAJA 			then "label-important"
		when EstadoInscripcion::FINALIZADO 		then "label-success"
		when EstadoInscripcion::ERRORES 		then "label-important"
		when EstadoInscripcion::CORRECTA 		then "label-success"
		when EstadoInscripcion::ACTUALIZADA 	then "label-inverse"
		end
	end

	def icon_for_estado_inscripcion(id)
		case id
		when EstadoInscripcion::VALIDANDO 		then "icon-time"
		when EstadoInscripcion::EN_SERVICIO 	then "icon-user"
		when EstadoInscripcion::SUSPENDIDO 		then "icon-pause"
		when EstadoInscripcion::BAJA 			then "icon-remove"
		when EstadoInscripcion::FINALIZADO 		then "icon-ok"
		when EstadoInscripcion::ERRORES 		then "icon-thumbs-down"
		when EstadoInscripcion::CORRECTA 		then "icon-thumbs-up"
		when EstadoInscripcion::ACTUALIZADA 	then "icon-inbox"
		end
	end

	def lbl_estado_reporte_id(id)
		estados = ["label-info", "label-important", "label-success", "label-warning"]
		estados[ id - 1 ]
	end

	def lbl_estado_reporte(reporte)
		# SIN_REVISION 	= 1
	 #  	CON_ERRORES 	= 2
	 #  	CORRECTO 		= 3
	 #  	ACTUALIZADO 	= 4
	 	lbl_estado_reporte_id( reporte.estado_reporte.id )
	end

	def icon_for_estado_reporte(id)
		case id
		when EstadoReporte::SIN_REVISION 	then "icon-time"
		when EstadoReporte::CON_ERRORES 	then "icon-remove"
		when EstadoReporte::CORRECTO 		then "icon-ok"
		when EstadoReporte::ACTUALIZADO 	then "icon-inbox"
		end
	end
end