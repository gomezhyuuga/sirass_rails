# -*- encoding : utf-8 -*-
module SessionsHelper

	def require_role(role)
		if role == :admin
			unless current_user.admin
				flash[:error] = "No eres un administrador!" 
				redirect_to current_user.user_page
			end
		elsif role == :prestador
			unless current_user.prestador# || current_user.admin
				flash[:error] = "No eres un prestador!" 
				redirect_to current_user.user_page
			end
		elsif role == :institucion
			unless current_user.institucion_user# || current_user.admin
				flash[:error] = "No eres una institucion!" 
				redirect_to current_user.user_page
			end
		end
	end

	def require_inscripcion
		u = current_user
		if u and u.prestador and
			!u.prestador.inscripcion_actual
				flash[:error] = "Necesitas estar inscrito en un programa de servicio social"
				redirect_to u.user_page
				return false
		else
			if Inscripcion.find(u.prestador.inscripcion_actual).estado_inscripcion_id == EstadoInscripcion::EN_SERVICIO
				return true
			else
				flash[:error] = "Necesitar estar inscrito y activo en un programa de servicio social"
				redirect_to u.user_page
			end
			
		end
	end
end
