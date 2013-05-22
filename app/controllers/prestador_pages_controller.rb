# -*- encoding : utf-8 -*-
class PrestadorPagesController < ApplicationController
	before_filter :require_login
	layout 'prestador'
	def index
		require_role(:prestador)
		@p = Prestador.find(current_user.prestador.id)
	end

	def inscripcion
		@inscripcion_actual = Inscripcion.find(current_user.prestador.inscripcion_actual)
	end

	def edit_inscripcion
		@inscripcion = Inscripcion.find(current_user.prestador.inscripcion_actual)
	end

	def estudianteDe
		@p = Prestador.find(current_user.prestador.id)
		@p.estudiante_uacm = params[:prestador][:estudiante_uacm]
		if params[:prestador][:estudiante_uacm] == nil
			flash[:error] = "No elegiste una opción"
			redirect_back_or_to current_user.user_page
		else
			if @p.save
				flash[:success] = "Confirmación Correcta, Gracias!"
				redirect_back_or_to current_user.user_page
			end
		end
	end

	def reporte_horas
		u = current_user
		if u and u.prestador and !u.prestador.inscripcion_actual
				flash[:error] = "Necesitas estar inscrito en un programa de servicio social"
				redirect_to u.user_page
				return false
		else
			if Inscripcion.find(u.prestador.inscripcion_actual).estado_inscripcion == EstadoInscripcion::EN_SERVICIO
				return true
			else
				return false
			end
		end
	end
end
