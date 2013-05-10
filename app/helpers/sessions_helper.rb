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
		if current_user and current_user.prestador and
			!current_user.prestador.inscripcion_actual
				flash[:error] = "Necesitas estar inscrito en un programa de servicio social"
				redirect_to current_user.user_page
				return false
		else
			return true
		end
	end
end
