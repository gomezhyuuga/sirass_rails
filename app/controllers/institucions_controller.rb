# -*- encoding : utf-8 -*-
class InstitucionsController < ApplicationController
	layout 'admin'
	def index
		@institucions = Institucion.paginate(page: params[:page], order: 'educativa DESC')
	end

	def show
		@institucion = Institucion.find_by_id(params[:id])
		if !@institucion
			flash[:error] = "Institución no encontrada!"
			redirect_to current_user.user_page
		end
	end

	def destroy
		@institucion = Institucion.find_by_id(params[:id])
		@institucion.destroy
		flash[:success] = "Institución eliminada correctamente."
		redirect_to institucions_path
	end

	def edit
		@institucion = Institucion.find_by_id(params[:id])
		if !@institucion
			flash[:error] = "Institución no encontrada!"
			redirect_to current_user.user_page
		end
	end

	def update
		@institucion = Institucion.find_by_id(params[:id])
		if @institucion.update_attributes(params[:institucion])
			flash[:success] = "Datos actualizados correctamente."
			redirect_to institucions_path
		else
			flash.now[:error] = "Ha ocurrido un error actualizando los datos."
			render 'edit'
		end
	end
end
