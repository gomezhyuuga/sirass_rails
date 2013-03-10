# -*- encoding : utf-8 -*-
class AdminsController < ApplicationController
	before_filter :require_login
	layout 'admin'

	def new
		
	end

	def create
		
	end

	def destroy
		@admin = Admin.find(params[:id])
		if @admin.destroy
			flash[:success] = "Usuario eliminado correctamente!"
			redirect_to admin_home_path
		else
			flash[:error] = "Ocurrió un problema al eliminar el usuario!"
			redirect_to admins_path
		end
	end

	def show
		@admin = Admin.find(params[:id])
	end

	def index
		authorize! :manage, Admin
		@admins = Admin.all
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
