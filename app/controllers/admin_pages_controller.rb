# -*- encoding : utf-8 -*-
class AdminPagesController < ApplicationController
	before_filter :require_login
	layout 'admin'

	def index
		require_role(:admin)
	end

	def show
		
	end

	def reportes_mensuales
		conditions = {}
		if params[:estado]
			conditions[:estado_reporte_id] = params[:estado].to_i
		end
		@reportes = MonthlyReport.paginate(page: params[:page]).where(conditions)
	end

	def reportes_bimensuales
		conditions = {}
		if params[:estado]
			conditions[:estado_reporte_id] = params[:estado].to_i
		end
		@reportes = BiMonthlyReport.paginate(page: params[:page]).where(conditions)
	end

	def reportes_finales
		conditions = {}
		if params[:estado]
			conditions[:estado_reporte_id] = params[:estado].to_i
		end
		@reportes = FinalReport.paginate(page: params[:page]).where(conditions)
	end
	def update_convocatoria
		param = "Desactivar"
		@c = Configuracion.find_by_nombre('convocatoria')
		if @c.valor == "Desactivar"
			param = "Activar"
		else
			param = "Desactivar"
		end
		@c.valor = param
		if @c.save
			flash[:success] = "Convocatoria cambiada correctamente :-)"
				redirect_to current_user.user_page
		else
			flash.now[:error] = "Ocurrió un error actualizando la convocatoria."
			render 'admin'
		end
	end
end
