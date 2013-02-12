# -*- encoding : utf-8 -*-
class PrestadorPagesController < ApplicationController
	before_filter :require_login
	layout 'prestador'
	def index
		require_role(:prestador)
		check_status
	end


	def check_status
		if current_user.prestador.inscripcions.empty? || !current_user.prestador.inscripcion_actual
			render 'prestador_pages/messages/no_inscrito'
		elsif current_user.prestador.inscripcion_actual
			id = current_user.prestador.inscripcion_actual
			inscripcion = Inscripcion.find_by_id(id)
			if inscripcion.estado_inscripcion_id == EstadoInscripcion::VALIDANDO
				render 'prestador_pages/messages/validando'
			end
		end
	end
end
