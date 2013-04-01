# -*- encoding : utf-8 -*-
class PlantelsController < ApplicationController
	layout 'admin'

	def new
		authorize! :manage, Plantel
		@plantel = Plantel.new
	end

	def create
		@plantel = Plantel.new(params[:plantel])
		if @plantel.save
			flash[:success] = "Plantel registrado correctamente!"
			redirect_to plantels_path
		else
			flash.now[:error] = "Ocurrió un error registrando el plantel"
			render 'new'
		end
	end

	def destroy
		@plantel = Plantel.find_by_id(params[:id])
		@plantel.destroy
		flash[:success] = "Plantel eliminado correctamente."
		redirect_to plantels_path
	end

	def edit
		@plantel = Plantel.find_by_id(params[:id])
		if !@plantel
			flash[:error] = "Plantel no encontrado."
			redirect_to current_user.user_page
		end
	end

	def update
		@plantel = Plantel.find_by_id(params[:id])
		if @plantel.update_attributes(params[:plantel])
			flash[:success] = "Datos del plantel actualizados correctamente"
			redirect_to current_user.user_page
		else
			render 'edit'
		end
	end

	def index
		@plantels = Plantel.paginate(page: params[:page], order: :institucion_id)
	end
end
