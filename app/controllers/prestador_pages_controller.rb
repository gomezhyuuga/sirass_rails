# -*- encoding : utf-8 -*-
class PrestadorPagesController < ApplicationController
	before_filter :require_login
	before_filter :require_inscripcion_activa, only: [:reporte_horas, :new_informe_final, :create_informe_final]
	before_filter :require_inscripcion, only: [:inscripcion, :edit_inscripcion]
  	# before_filter :already_sent, only: [:new_informe_final, :create_informe_final]
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
	end

	def carta_compromiso
		@prestador = current_user.prestador
		@inscripcion = Inscripcion.find(@prestador.inscripcion_actual)
		@programa = @inscripcion.cprograma
		eid = @inscripcion.estado_inscripcion_id
		correcto = EstadoInscripcion::CORRECTA
		en_servicio = EstadoInscripcion::EN_SERVICIO
		if eid == correcto || eid == en_servicio
			render layout: 'print'
		else
			flash[:error] = "Necesitas que aprueben tu inscripción para poder imprimir tu carta compromiso."
			redirect_to current_user.user_page
		end
	end

	def informe_bimensual
		# @prestador = current_user.prestador
		# @inscripcion = Inscripcion.find(@prestador.inscripcion_actual)

	end

	def show_informe_final
		@reporte = FinalReport.find_by_inscripcion_id current_user.prestador.inscripcion_actual
	end

	def new_informe_final
		@reporte = FinalReport.new
	end

	def print_informe_final
		@reporte = FinalReport.find_by_inscripcion_id current_user.prestador.inscripcion_actual
		render layout: "print"
	end

	def edit_informe_final
		@reporte = FinalReport.find_by_inscripcion_id current_user.prestador.inscripcion_actual
	end

	def create_informe_final
	  @reporte = FinalReport.new( params[:final_report] )
	  @reporte.estado_reporte_id = EstadoReporte::SIN_REVISION
	  @reporte.inscripcion_id = current_user.prestador.inscripcion_actual

	  if @reporte.save
	    flash[:success] = "Reporte guardado correctamente."
	    redirect_to current_user.user_page
	  else
	    flash.now[:error] = "Ha ocurrido un error guardando tu informe final."
	    render :new_informe_final
	  end
	end

	def update_informe_final
	  @reporte = FinalReport.find_by_inscripcion_id current_user.prestador.inscripcion_actual
	  params[:final_report][:estado_reporte_id] = EstadoReporte::ACTUALIZADO
	  
	  if @reporte.update_attributes( params[:final_report] )
	    flash[:success] = "Reporte actualizado correctamente."
	    redirect_to informe_final_ver_path
	  else
	    flash.now[:error] = "Ocurrió un error actualizando los datos. Intenta nuevamente."
	    render :edit_informe_final
	  end
	end

	private 
		def already_sent
	      reporte = FinalReport.find_by_inscripcion_id current_user.prestador.inscripcion_actual
	      unless reporte == nil || reporte == false || reporte == 0
	        flash[:error] = "Ya enviaste tu reporte, no puedes volver a enviarlo!"
	        redirect_to current_user.user_page
	      end
	    end
end
