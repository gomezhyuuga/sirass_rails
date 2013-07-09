# encoding: UTF-8

class InscripcionsController < ApplicationController
	layout 'prestador'
	before_filter :require_login

	def index
		authorize! :manage, Inscripcion
		conditions = {}
		conditions[:estado_inscripcion_id] = params[:estado] unless params[:estado].blank?
		@inscripcions = Inscripcion.page(params[:page]).where(conditions)
		render layout: 'admin'
	end

	def update
		@inscripcion = Inscripcion.find(params[:id])
		if params[:inscripcion][:articulo_91] == "true" && params[:inscripcion][:horas_servicio].blank?
			params[:inscripcion][:horas_servicio] = "480:00"
		end
		if @inscripcion.update_attributes( params[:inscripcion] )
			flash[:success] = "Inscripción actualizada correctamente"
			if logged_as? :admin
				redirect_to inscripcions_path
			else
				redirect_to prestador_home_path
			end
		else
			flash.now[:error] = "Ocurrió un error actualizando la inscripción"
			if logged_as? :admin
				render 'edit', layout: 'admin'
			else
				redirect_to mi_inscripcion_edit_path
			end
		end
	end

	# Actualizar solo el estado de un programa
	def update_status
		if Inscripcion.update(params[:inscripcion_id], estado_inscripcion_id: params[:status])
			flash[:success] = "Estado actualizado correctamente!"
			InscripcionMailer.estado_actualizado(Inscripcion.find_by_id(params[:inscripcion_id])).deliver
		else
			flash[:error] = "Ocurrió un error actualizando el estado"
		end
		redirect_to inscripcions_path
	end

	def edit
		@inscripcion = Inscripcion.find(params[:id])
		render layout: 'admin'
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
		@inscripcion.programa_institucional = "PENDIENTE"
		@inscripcion.cve_programa_institucional = "PENDIENTE"
		@inscripcion.horas_servicio = @inscripcion.articulo_91 == true ? "480:00" : "00:00"
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
			InscripcionMailer.observaciones_actualizadas(Inscripcion.find_by_id(params[:inscripcion_id])).deliver
			redirect_to inscripcion_path(params[:inscripcion_id])
		else
			flash[:error] = "Ocurrió un error actualizando las observaciones"
			redirect_to inscripcion_path(params[:inscripcion_id])
		end
	end

	def generar_nuevo_ncontrol
		@id = params[:inscripcion_id]
		inscripcion = Inscripcion.find(@id)
		consecutivo = 1 + Inscripcion.where("ncontrol IS NOT NULL AND ncontrol != ''").count
		categoria = ""
		if inscripcion.prestador.estudiante_uacm?
			categoria = "I"
		else
			categoria = "E"
		end
		@ncontrol = "SS-#{categoria}-#{consecutivo}"
		respond_to do |format|
			format.js
		end
	end

	def calcular_horas_servicio
		@horas = Inscripcion.calcular_horas(params[:inscripcion_id])
		puts @horas

		respond_to do |format|
			format.js
		end
	end

	def reportes_mensuales
		@inscripcion = Inscripcion.find(params[:id])
		@reportes = @inscripcion.monthly_reports
		@usuario = @inscripcion.prestador.user
		@prestador = @inscripcion.prestador
		render layout: 'admin'
	end
	def reportes_bimensuales
		@inscripcion = Inscripcion.find(params[:id])
		@reportes = @inscripcion.bi_monthly_reports
		@usuario = @inscripcion.prestador.user
		@prestador = @inscripcion.prestador
		render layout: 'admin'
	end
end
