# encoding: utf-8
include MonthlyReportsHelper
class MonthlyReportsController < ApplicationController
  before_filter :require_login
  before_filter :require_inscripcion_activa, only: [:new, :create, :index]
  layout 'prestador'

  def index
    require_role :prestador
    p = current_user.prestador
    @reportes = MonthlyReport.where(inscripcion_id: p.inscripcion_actual)
  end

  def new
    require_role :prestador
    @control_horas = MonthlyReport.new
    # Comenzar en el primer día del mes pasado o del mes que se envíe por parámetro
    today = Date.today
    anterior = today.prev_month
    anterior = Date.new(anterior.year, anterior.month, 1)
    mes_inicio = anterior.month
    anio_inicio = anterior.year
    inteligente = false
    if params[:date] && params[:date][:mes].to_i > 0 &&
      params[:date][:anio].to_i > 0
        mes_inicio = params[:date][:mes].to_i
        anio_inicio = params[:date][:anio].to_i
        anterior = Date.new(anio_inicio, mes_inicio, 1)
        inteligente = true
    end
    
    # Llenado inteligente del mes seleccionado y sólo días de la semana
    if inteligente
      dias = dias_para_mes(mes_inicio, anio_inicio) 
      @control_horas.horas = "80:00"
      dias_enum = dias.to_enum
      horas = 0
      while horas < 80
        d = dias_enum.next
        registro = @control_horas.monthly_report_hours.build
        registro.fecha = d
        registro.entrada = "08:00"
        registro.salida = "12:00"
        horas += 4
      end
    else
      registro = @control_horas.monthly_report_hours.build
      registro.entrada = "08:00"
      registro.salida = "12:00"
      @control_horas.horas = "04:00"
    end

    inscripcion = current_user.prestador.inscripcion_actual

    reportes = MonthlyReport.where(inscripcion_id: inscripcion).order("created_at ASC")

    numero = 1 + reportes.size
    reporte_anterior = reportes.first
    hanteriores = "00:00"
    hanteriores = reporte_anterior.horas if reporte_anterior
    @control_horas.numero = numero
    @control_horas.fecha_inicio = anterior
    @control_horas.fecha_fin = anterior.next_month
    @control_horas.horas_anteriores = hanteriores
  end

  def edit
    @control_horas = MonthlyReport.find(params[:id])
    if current_user.prestador
      inscripcion = Inscripcion.find(current_user.prestador.inscripcion_actual)
      if not inscripcion.monthly_reports.include? @control_horas
        redirect_to control_horas_path
      end
    else
      authorize! :manage, MonthlyReport
      render layout: 'admin'
    end
  end

  def create
    @control_horas = MonthlyReport.new(params[:monthly_report])
    @control_horas.inscripcion_id = current_user.prestador.inscripcion_actual
    @control_horas.estado_reporte_id = EstadoReporte::SIN_REVISION
    if @control_horas.save
      flash[:success] = "Control de Horas guardado correctamente"
      redirect_to control_horas_path
    else
      flash.now[:error] = "Ocurrió un error guardando el registro..."
      render 'new'
    end
  end

  def update
    @control_horas = MonthlyReport.find(params[:id])
    params[:monthly_report][:estado_reporte_id] = EstadoReporte::ACTUALIZADO
    if @control_horas.update_attributes(params[:monthly_report])
      flash[:success] = "Reporte actualizado correctamente"
      redirect_to current_user.user_page
    else
      flash[:error] = "Ocurrió un error actualizando tu reporte."
      render :edit
    end
  end

  def destroy
    @control_horas = MonthlyReport.find(params[:id])
    puede_eliminar = false
    if current_user.prestador
      inscripcion = Inscripcion.find(current_user.prestador.inscripcion_actual)
      puede_eliminar = true if inscripcion.monthly_reports.include? @control_horas
    else
      authorize! :manage, MonthlyReport
      puede_eliminar = true
    end
    
    if puede_eliminar
      @control_horas = MonthlyReport.find(params[:id])
      if @control_horas.destroy
        flash[:success] = "Reporte eliminado correctamente"
      else
        flash[:error] = "No se pudo eliminar el reporte, ocurrió un error."
      end
    end
    redirect_to current_user.user_page
  end

  def show
    @reporte = MonthlyReport.find(params[:id])
    if current_user.admin
      render layout: 'admin'
    end
  end

  def cambiar_estado
    authorize! :manage, MonthlyReport
    reporte = MonthlyReport.find( params[:id] )
    if reporte.update_attributes( estado_reporte_id: params[:estado_id] )
      flash[:success] = "Estado del reporte cambiado correctamente."
    else
      flash[:error] = "Ocurrió un error cambiando el estado del reporte"
    end
    redirect_to admin_reportes_mensuales_path
  end

  private
    # Obtener una lista de todos los días de un mes sin incluir los fines de semana
    def dias_para_mes(mes, anio)
      fecha = Date.new(anio, mes, 1)
      fecha_termino = fecha.next_month
      dias = []
      while (fecha <=> fecha_termino) != 0
        dias << fecha if not (fecha.saturday? or fecha.sunday?)
        fecha = fecha + 1
      end
      return dias
    end
end