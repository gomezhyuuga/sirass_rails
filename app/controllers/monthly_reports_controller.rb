# encoding: utf-8
class MonthlyReportsController < ApplicationController
  before_filter :require_login
  layout 'prestador'

  def index
    require_role :prestador
    if require_inscripcion
      @reportes = MonthlyReport.where(inscripcion_id: current_user.prestador.inscripcion_actual)
    end
  end

  def new
    require_role :prestador
    if require_inscripcion
      @control_horas = MonthlyReport.new
      # Comenzar en el primer día del mes pasado o del mes que se envíe por parámetro
      today = Date.today
      mes_inicio = today.prev_month.month
      anio_inicio = today.prev_month.year
      if params[:mes] && params[:mes].to_i > 0
        mes_inicio = params[:mes].to_i
      end
      if params[:anio] && params[:anio].to_i > 0
        anio_inicio = params[:anio].to_i
      end
      
      # Llenado inteligente del mes anterior y sólo días de la semana
      dias = dias_para_mes(mes_inicio, anio_inicio)
      dias.each do |d|
        registro = @control_horas.monthly_report_hours.build
        registro.fecha = d
        registro.entrada = "08:00"
        registro.salida = "10:00"
      end
    end
  end

  def create
    @control_horas = MonthlyReport.new(params[:monthly_report])
    @control_horas.inscripcion_id = current_user.prestador.inscripcion_actual
    @control_horas.estado_reporte_id = EstadoReporte::SIN_REVISION
    if @control_horas.save
      flash[:success] = "Control de Horas guardado correctamente"
      redirect_to :control_horas_path
    else
      flash.now[:error] = "Ocurrió un error guardando el registro..."
      render 'new'
    end
  end

  def update
  end

  def delete
  end

  def show
    @reporte = MonthlyReport.find(params[:id])
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