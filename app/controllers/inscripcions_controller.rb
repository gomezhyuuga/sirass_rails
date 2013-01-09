# encoding: UTF-8

class InscripcionsController < ApplicationController
	layout 'prestador'

	def new
		@inscripcion = Inscripcion.new()
	end

	def create
		@inscripcion = Inscripcion.new(params[:inscripcion])
		if @inscripcion.save
			flash[:success] = "Solicitud de inscripción enviada correctamente!"
			redirect_to current_user.user_page
		else
			flash[:error] = "Hubo un error registrando tu solicitud."
			render 'new'
		end
	end
end
