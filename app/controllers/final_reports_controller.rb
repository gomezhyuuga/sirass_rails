# encoding: utf-8
class FinalReportsController < ApplicationController

  before_filter :require_login
  layout :layout_for_report

  def index
  end

  def cambiar_estado
    authorize! :manage, FinalReport
    reporte = FinalReport.find( params[:id] )
    if reporte.update_attributes( estado_reporte_id: params[:estado_id] )
      flash[:success] = "Estado del reporte cambiado correctamente."
    else
      flash[:error] = "Ocurrió un error cambiando el estado del reporte"
    end
    redirect_to admin_reportes_finales_path
  end

  def update
    @reporte = FinalReport.find params[:id]
    params[:final_report][:estado_reporte_id] = EstadoReporte::CON_ERRORES
    
    if @reporte.update_attributes( params[:final_report] )
      flash[:success] = "Reporte actualizado correctamente."
    else
      flash[:error] = "Ocurrió un error actualizando los datos. Intenta nuevamente."
    end
    redirect_to final_report_path(@reporte)
  end

  def show
    @reporte = FinalReport.find(params[:id])
  end

  def edit
    @reporte = FinalReport.find(params[:id])
  end

  def destroy
    @reporte = FinalReport.find params[:id]
    if @reporte.destroy
      flash[:success] = "Reporte eliminado correctamente."
    else 
      flash[:error] = "No se pudo eliminar el reporte. Intenta nuevamente."
    end
    redirect_to informes_finales_path
  end

  def print
    @reporte = FinalReport.find params[:id]
    render layout: "print"
  end

  private 

    def layout_for_report

      if current_user.prestador
        "prestador"
      elsif current_user.admin
        "admin"
      else
        flash[:error] = "No puedes ver esta página"
        redirect_to current_user.user_page
      end
    end
end
