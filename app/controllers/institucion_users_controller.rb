# -*- encoding : utf-8 -*-
class InstitucionUsersController < ApplicationController
	before_filter :require_login, except: [:create, :new]
	layout 'institucion'

	def index
		@institucion_users = InstitucionUser.paginate(page: params[:page])
		render layout: 'admin'
	end

	def create
		@institucion = InstitucionUser.new(params[:institucion_user])
		if @institucion.save
			flash[:success] = "Institucion registrada. Bienvenido a SiRASS!"
			auto_login(@institucion.user)
			redirect_back_or_to @institucion.user.user_page
		else
			render 'new', layout: 'application'
		end
	end

	def destroy
		
	end

	def show
		@institucion = InstitucionUser.find(params[:id])
		render layout: 'admin' if current_user.admin
	end

	def new(obj = nil)
		@institucion = InstitucionUser.new
		@institucion.build_user
		render layout: 'application'
	end

	def edit
		@institucion = InstitucionUser.find(params[:id])
		if @institucion != current_user.institucion_user
			authorize! :update, InstitucionUser
		end
		render layout: 'admin' if current_user.admin
	end

	def update
		@institucion = InstitucionUser.find(params[:id])
		# Si el password está en blanco quiere decir que no se desea actualizar
		check_password_update(params, :institucion_user)

		if @institucion.update_attributes(params[:institucion_user])
			flash[:success] = "Datos actualizados correctamente!"
			redirect_to current_user.user_page
		else
			flash.now[:error] = "Ocurrió un error actualizando los datos."
			render 'edit'
		end
	end
end
