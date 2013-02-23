# encoding: UTF-8

class InscripcionsController < ApplicationController
	layout 'prestador'
	before_filter :require_login

	def new
		require_role(:prestador)
		if current_user.prestador && !current_user.prestador.inscripcion_actual
			@inscripcion = Inscripcion.new
		else
			redirect_to prestador_home_path
		end
	end

	def create
		@inscripcion = Inscripcion.new(params[:inscripcion])
		@inscripcion.prestador_id = current_user.prestador.id
		@inscripcion.estado_inscripcion_id = EstadoInscripcion::VALIDANDO
		# Valores por defecto
		@inscripcion.programa_institucional = "Apoyo académico-administrativo en la UACM"
		@inscripcion.cve_programa_institucional = "02036d0576"
		if @inscripcion.save && Prestador.update(@inscripcion.prestador.id, inscripcion_actual: @inscripcion.id)
			programa = @inscripcion.cprograma
			programa.vacantes -= 1
			programa.save!
			flash[:success] = "Solicitud de inscripción enviada correctamente!"
			redirect_to current_user.user_page
		else
			flash.now[:error] = "Hubo un error registrando tu solicitud."
			render 'new'
		end
	end

	def show
		@inscripcion = Inscripcion.find_by_id(params[:id])
		if can? :manage, Inscripcion
			render layout: 'application'
		elsif current_user.prestador.inscripcions.include? @inscripcion
			render layout: 'application'
		else
			flash[:error] = "No tienes permisos para ver esta página!"
			redirect_to root_path
		end
	end
end
