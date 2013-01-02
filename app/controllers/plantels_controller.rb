class PlantelsController < ApplicationController
	layout 'admin'

	def destroy
		@plantel = Plantel.find_by_id(params[:id])
		@plantel.destroy
		flash[:success] = "Plantel eliminado correctamente."
		redirect_to current_user.user_page
	end

	def edit
		@plantel = Plantel.find_by_id(params[:id])
		unless @plantel
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
		@plantels = Plantel.paginate(page: params[:page])
	end
end
