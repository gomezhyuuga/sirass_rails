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
		require_inscripcion
	end
end
