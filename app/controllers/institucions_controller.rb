# encoding: UTF-8
class InstitucionsController < ApplicationController
	layout 'admin'
	def index
		@institucions = Institucion.paginate(page: params[:page])
	end

	def show
		@institucion = Institucion.find_by_id(params[:id])
	end

	def destroy
		@institucion = Institucion.find_by_id(params[:id])
		@institucion.destroy
		flash[:success] = "Institución eliminada correctamente."
		redirect_to current_user.user_page
	end
end