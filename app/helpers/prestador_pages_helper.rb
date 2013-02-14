# -*- encoding : utf-8 -*-
module PrestadorPagesHelper
	def status_for_inscripcion(inscripcion)
		if current_user.prestador && current_user.prestador.inscripcion_actual
			return current_inscripcion.estado_inscripcion_id
		else
			return false
		end
	end

	def current_inscripcion
		if current_user.prestador && current_user.prestador.inscripcion_actual
			return Inscripcion.find_by_id(current_user.prestador.inscripcion_actual)
		end
	end
end
