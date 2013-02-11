# -*- encoding : utf-8 -*-
class InstitucionPagesController < ApplicationController
	before_filter :require_login
	layout 'institucion'

	def index
		require_role(:institucion)
	end

	def actualizar
		require_role(:institucion)
		@programas = Cprograma.where(institucion_user_id: current_user.institucion_user.id)
	end
end
