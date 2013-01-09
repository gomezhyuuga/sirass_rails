class InscripcionsController < ApplicationController
	layout 'prestador'

	def new
		@inscripcion = Inscripcion.new()
	end
end
