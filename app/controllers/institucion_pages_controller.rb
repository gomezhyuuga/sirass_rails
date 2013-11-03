# -*- encoding : utf-8 -*-
class InstitucionPagesController < ApplicationController
	before_filter :require_login
	layout 'institucion'

	def index
		require_role(:institucion)
		if current_user.institucion_user
			@institucion = InstitucionUser.find(current_user.institucion_user.id)
		end
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

	def paseo
		require_role(:institucion)
		@institucion = InstitucionUser.find(current_user.institucion_user.id)
		if @institucion.paseo == false
			@institucion.paseo = true
		else
			@institucion.paseo = false
		end
		if @institucion.save
			flash[:success] = "Si necesitas ayuda sobre algo que no recuerdes da click en \"Ayuda\""
			redirect_to current_user.user_page
		else
			redirect_to current_user.user_page
		end
	end
	def ayuda
		flash[:success] = "Si necesitas ayuda sobre algo que no recuerdes da click en \"Ayuda\""
			redirect_to current_user.user_page
	end
end
