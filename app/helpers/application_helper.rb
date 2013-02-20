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
		condiciones = []
		if !current_user.prestador.estudiante_uacm?
			condiciones = ['categoria_interno = ?', true]
		end
		programas = Cprograma.find(:all, conditions: condiciones)
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
end