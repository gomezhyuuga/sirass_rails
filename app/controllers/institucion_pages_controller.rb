# -*- encoding : utf-8 -*-
class InstitucionPagesController < ApplicationController
	before_filter :require_login
	layout 'institucion'

	def index
		require_role(:institucion)
	end

	def actualizar
		require_role(:institucion)
		@programas = Cprograma.where(institucion_user_id: current_user.institucion_user.id).where('estado_programa_id <> ?', EstadoPrograma::ACTIVO)
	end

	def avisos
		require_role(:institucion)
		@observados = Cprograma.where(institucion_user_id: current_user.institucion_user.id, estado_programa_id: EstadoPrograma::OBSERVACION)
		@suspendidos = Cprograma.where(institucion_user_id: current_user.institucion_user.id, estado_programa_id: EstadoPrograma::SUSPENDIDO)
	end
end
