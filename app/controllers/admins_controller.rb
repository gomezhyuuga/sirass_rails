# -*- encoding : utf-8 -*-
class AdminsController < ApplicationController
	before_filter :require_login
	layout 'admin'

	def new
		
	end

	def create
		
	end

	def show
		
	end

	def index
		require_role(:admin)
	end

	def edit
		require_role(:admin)
		@admin = Admin.find(params[:id])
	end

	def update
		require_role(:admin)
		@admin = Admin.find(params[:id])
		# Si el password está en blanco quiere decir que no se desea actualizar
		check_password_update(params, :admin)

		if @admin.update_attributes(params[:admin])
			flash[:success] = "Datos actualizados correctamente!"
			redirect_to edit_admin_path(@admin)
		else
			flash.now[:error] = "Ocurrió un error actuaizando los datos!"
			render 'edit'
		end
	end

	def home
		
	end
end
