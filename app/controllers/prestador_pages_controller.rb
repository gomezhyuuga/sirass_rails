# -*- encoding : utf-8 -*-
class PrestadorPagesController < ApplicationController
	before_filter :require_login
	layout 'prestador'
	def index
		require_role(:prestador)
	end

	def inscripcion
		@inscripcion_actual = Inscripcion.find(current_user.prestador.inscripcion_actual)
	end
end
