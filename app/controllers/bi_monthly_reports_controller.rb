# encoding: utf-8
class BiMonthlyReportsController < ApplicationController

	layout :layout_for_actions
	before_filter :require_login
	before_filter :require_inscripcion_activa, only: [:new, :create, :index]

	def index
		require_role :prestador
		p = current_user.prestador
		@reportes = BiMonthlyReport.where(inscripcion_id: p.inscripcion_actual)
	end

	def new
		require_role :prestador
		p = current_user.prestador
		@reporte = BiMonthlyReport.new

		# Determinar valores por defecto
		reportes = BiMonthlyReport.where( inscripcion_id: p.inscripcion_actual ).order('created_at DESC')
		numero = 1 + reportes.size
		horas_anteriores = reportes.any? ? reportes.first.horas : "00:00"
		@reporte.numero = numero
		@reporte.horas_anteriores = horas_anteriores

		if reportes.any?
			anterior = reportes.first
			@reporte.periodo_inicio = anterior.periodo_fin + 1.day
			@reporte.periodo_fin = anterior.periodo_fin + 2.months
		end
	end

	def create
		@reporte = BiMonthlyReport.new( params[:bi_monthly_report] )
		@reporte.inscripcion_id = current_user.prestador.inscripcion_actual
		@reporte.estado_reporte_id = EstadoReporte::SIN_REVISION

		if @reporte.save
			flash[:success] = "Reporte guardado de forma correcta."
			redirect_to current_user.user_page
		else
			flash.now[:error] = "Lo sentimos pero ha ocurrido un error guardando el reporte."
			render action: :new
		end
	end

	def show
		@reporte = BiMonthlyReport.find( params[:id] )
	end

	def edit
		@reporte = BiMonthlyReport.find( params[:id] )
		unless can? :manage, BiMonthlyReport
			i = Inscripcion.find(current_user.prestador.inscripcion_actual)
			require_owner(i.bi_monthly_reports, @reporte)
		end
	end

	def update
		@reporte = BiMonthlyReport.find( params[:id] )
		params[:bi_monthly_report][:estado_reporte_id] = EstadoReporte::ACTUALIZADO
		if params[:bi_monthly_report][:observaciones]
		  params[:bi_monthly_report][:estado_reporte_id] = EstadoReporte::CON_ERRORES
		end
		if @reporte.update_attributes( params[:bi_monthly_report] )
			flash[:success] = "Reporte actualizado correctamente."
			redirect_to informe_bimensual_path(@reporte)
		else
			flash[:error] = "Lo sentimos pero ha ocurrido un error actualizando el reporte."
			render action: :edit
		end
	end

	def destroy
		reporte = BiMonthlyReport.find( params[:id] )
		puede_eliminar = false
		if current_user.prestador
		  inscripcion = Inscripcion.find(current_user.prestador.inscripcion_actual)
		  puede_eliminar = true if inscripcion.bi_monthly_reports.include? reporte
		else
		  authorize! :manage, BiMonthlyReport
		  puede_eliminar = true
		end

		if puede_eliminar
			if reporte.destroy
				flash[:success] = "Reporte eliminado correctamente."
			else
				flash[:error] = "Lo sentimos pero ha ocurrido un error eliminando el reporte."
			end
		end
		redirect_to current_user.user_page
	end

	def cambiar_estado
	  authorize! :manage, BiMonthlyReport
	  reporte = BiMonthlyReport.find( params[:id] )
	  if reporte.update_attributes( estado_reporte_id: params[:estado_id] )
	    flash[:success] = "Estado del reporte cambiado correctamente."
	  else
	    flash[:error] = "Ocurrió un error cambiando el estado del reporte"
	  end
	  redirect_to admin_reportes_bimensuales_path
	end

	private
	def layout_for_actions
		if current_user.admin
			"admin"
		elsif current_user.prestador
			"prestador"
		elsif current_user.institucion_user
			"institucion"
		else
			"application"
		end
	end
end