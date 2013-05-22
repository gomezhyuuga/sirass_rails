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
end
