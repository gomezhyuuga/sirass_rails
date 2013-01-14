# encoding: UTF-8

class InscripcionsController < ApplicationController
	layout 'prestador'

	def new
		@inscripcion = Inscripcion.new()
	end

	def create
		@inscripcion = Inscripcion.new(params[:inscripcion])
		@inscripcion.prestador_id = current_user.prestador.id
		# Valores por defecto
		@inscripcion.programa_institucional = "Apoyo académico-administrativo en la UACM"
		@inscripcion.cve_programa_institucional = "02036d0576"
		if @inscripcion.save
			flash[:success] = "Solicitud de inscripción enviada correctamente!"
			redirect_to current_user.user_page
		else
			flash.now[:error] = "Hubo un error registrando tu solicitud."
			render 'new'
		end
	end
end
