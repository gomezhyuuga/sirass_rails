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

		# Detectar si se está registrando una nueva institución
		if !params[:nueva_institucion][:nombre].blank?
			nueva_institucion = Institucion.new(params[:nueva_institucion])
			if nueva_institucion.save
				@institucion.institucion_id = nueva_institucion.id
				@institucion.institucion = nueva_institucion
				params[:institucion_user][:institucion_id] = nueva_institucion.id
				if params[:nuevo_plantel][:nombre].blank?
					@institucion.plantel = nil
					@institucion.plantel_id = nil
					params[:institucion_user][:plantel_id] = nil
				end
			else
				flash.now[:error] = "No se pudo registrar tu nueva institución"
			end
		end
		# Detectar si se está registrando un nuevo plantel
		if !params[:nuevo_plantel][:nombre].blank?
			@institucion.plantel_id = nil
			plantel = @institucion.build_plantel
			plantel.nombre = params[:nuevo_plantel][:nombre]
			plantel.institucion_id = @institucion.institucion_id
		end
		
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

		# Detectar si se está registrando una nueva institución
		if !params[:nueva_institucion][:nombre].blank?
			nueva_institucion = Institucion.new(params[:nueva_institucion])
			if nueva_institucion.save
				@institucion.institucion_id = nueva_institucion.id
				@institucion.institucion = nueva_institucion
				params[:institucion_user][:institucion_id] = nueva_institucion.id
				if params[:nuevo_plantel][:nombre].blank?
					@institucion.plantel = nil
					@institucion.plantel_id = nil
					params[:institucion_user][:plantel_id] = nil
				end
			else
				flash.now[:error] = "No se pudo registrar tu nueva institución"
			end
		end

		if @institucion.save and @institucion.update_attributes(params[:institucion_user])
			# Detectar si se está registrando un nuevo plantel
			if !params[:nuevo_plantel][:nombre].blank?
				@institucion.plantel_id = nil
				plantel = @institucion.build_plantel
				plantel.nombre = params[:nuevo_plantel][:nombre]
				plantel.institucion_id = @institucion.institucion_id
			end
			if @institucion.save
				flash[:success] = "Datos actualizados correctamente!"
				redirect_to current_user.user_page
			else
				flash.now[:error] = "Ocurrió un error actualizando los datos."
				render 'edit'
			end
		else
			flash.now[:error] = "Ocurrió un error actualizando los datos."
			render 'edit'
		end
	end
end
