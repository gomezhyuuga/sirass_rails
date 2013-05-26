module CprogramasHelper

	def link_to_estados_programa(url)
		html = ''
		clase = params[:estado].blank? ? "btn-warning" : "btn-inverse"
		html << link_to("Todos", url, class: "btn btn-mini #{clase}")
		html << ' '
		EstadoPrograma.all.each do |p|
			url[:estado] = p.id
			clase = params[:estado].to_i == p.id ? "btn-warning" : "btn-inverse"
			html << link_to( p.descripcion, url, class: "btn btn-mini #{clase}" )
			html << ' '
		end
		html.html_safe
	end
	# == ESTADOS DE PROGRAMA ==
	# 1,"Activo"
	# 2,"Inactivo"
	# 3,"Suspendido"
	# 4,"Esperando"
	# 5,"Actualizado"
	# 6,"Observación"

	# Devuele nombre del icono adecuado para el estado de un programa
	# ICONOS: http://twitter.github.com/bootstrap/base-css.html#icons
	def icon_for_estado_programa(id)
		icon = case id
			when 1 then "icon-ok"
			when 2 then "icon-pause"
			when 3 then "icon-remove"
			when 4 then "icon-thumbs-up"
			when 5 then "icon-refresh"
			when 6 then "icon-info-sign"
			else "icon-asterisk"
		end
	end

	# Devuelve el tipo de label de bootstrap para el estado de un programa
	# LABELS: http://twitter.github.com/bootstrap/components.html#labels-badges
	def label_for_estado_programa(id)
		label = case id
			when 1 then "label-success"
			when 2 then "label-important"
			when 3 then "label-warning"
			when 4 then "label-info"
			when 5 then "label-inverse"
			when 6 then "label-warning"
			else ""
		end
	end

	def update_status_path(programa, status)
		cprograma_path(programa) + "/update_status/#{status}"
	end
	def update_observaciones_path(programa)
		cprograma_path(programa) + "/update_observaciones"
	end
end