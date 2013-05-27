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

	def require_inscripcion_activa
		u = current_user
		p = u.prestador
		unless u && p && p.inscripcion_actual && inscripcion_activa?(p.inscripcion_actual)
			flash[:error] = "¡Error! Necesitas estar inscrito en un programa de servicio social."
			redirect_to u.user_page
		end
	end

	def require_inscripcion
		u = current_user
		p = u.prestador
		unless u && p && p.inscripcion_actual
			flash[:error] = "¡Error! Necesitas haber enviado tu solicitud de inscripción a un programa de servicio social."
			redirect_to u.user_page
		end
	end

	def require_owner(collection, item)
		unless collection.include? item
			flash[:error] = "¡Error! No puedes editar este reporte."
			redirect_to current_user.user_page
		end
	end

	private

	def inscripcion_activa?(id)
		Inscripcion.find_by_id(id).estado_inscripcion_id == EstadoInscripcion::EN_SERVICIO
	end
end
