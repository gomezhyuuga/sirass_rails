# encoding: UTF-8

class InscripcionsController < ApplicationController
	layout 'prestador'
	before_filter :require_login

	def index
		authorize! :manage, Inscripcion
		@inscripcions = Inscripcion.paginate(page: params[:page], per_page: 30)
		render layout: 'admin'
	end

	def update
		
	end

	def destroy
		authorize! :manage, Inscripcion
		@inscripcion = Inscripcion.find(params[:id])
		if @inscripcion.destroy
			flash[:success] = "Inscripción eliminada con éxito"
		else
			flash[:success] = "Ocurrión un error eliminando la inscripción"
		end
		redirect_to inscripcions_path
	end

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
		if @inscripcion.cprograma and @inscripcion.cprograma.vacantes <= 0
			flash[:error] = "Lo sentimos pero el programa al que deseas inscribirte ya no tiene vacantes!"
			redirect_to prestador_home_path
			return false
		end
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
		authorize! :manage, Inscripcion
		@inscripcion = Inscripcion.find_by_id(params[:id])
		render layout: 'admin'
	end

	def update_observaciones
		observaciones = params[:inscripcion][:observaciones]
		if Inscripcion.update(params[:inscripcion_id], observaciones: observaciones, estado_inscripcion_id: EstadoInscripcion::ERRORES)
			flash[:success] = "Observaciones actualizadas con éxito"
			redirect_to inscripcion_path(params[:inscripcion_id])
		else
			flash[:error] = "Ocurrió un error actualizando las observaciones"
			redirect_to inscripcion_path(params[:inscripcion_id])
		end
	end
end
