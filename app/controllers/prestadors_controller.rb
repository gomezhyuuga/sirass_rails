# -*- encoding : utf-8 -*-
class PrestadorsController < ApplicationController
	before_filter :require_login, except: [:create, :new]
	
	layout 'admin'

	def search
		authorize! :read, Prestador
		like = "LIKE"
		if ActiveRecord::Base.connection.adapter_name.downcase == "postgresql"
			like = "ILIKE"
		end
		query = "nombre #{like} ? OR apaterno LIKE ? OR amaterno LIKE ?"
		nombre = "%#{params[:nombre]}%"
		@prestadors = Prestador.where(query, nombre, nombre, nombre).paginate(page: params[:page])
		flash.now[:error] = "Búsqueda sin resultados" unless @prestadors
		render :index
	end

	def index
		authorize! :read, Prestador
		@prestadors = Prestador.paginate(page: params[:page])
		flash.now[:error] = "Búsqueda sin resultados" unless @prestadors
	end

	def new
		@prestador = Prestador.new
		@prestador.build_user

		render layout: 'application'
	end

	def create
		@prestador = Prestador.new(params[:prestador])
		if @prestador.save
			flash[:success] = "Bienvenido a SiRASS!"
			auto_login(@prestador.user)
			redirect_back_or_to @prestador.user.user_page
		else
			flash.now[:error] = "Ha ocurrido un error registrando al prestador"
			render 'new', layout: 'application'
		end
	end

	def edit
		@prestador = Prestador.find_by_id(params[:id])
		if @prestador
			# Permitir que el usuario actualice su misma información
			if current_user == @prestador.user
				render layout: 'prestador'
			else
				# El usuario actual intenta actualizar la información de otro usuario
				# que no es él. Checar permisos
				authorize! :update, Prestador
			end
		else
			no_encontrado
		end
	end

	def update
		@prestador = Prestador.find(params[:id])
		# Si el password está en blanco quiere decir que no se desea actualizar
		check_password_update(params, :prestador)
		
		# Actualización de datos
		if @prestador.update_attributes(params[:prestador])
			flash[:success] = "Datos actualizados correctamente"
			redirect_to current_user.user_page
		else
			render 'edit'
		end
	end

	def show
		@prestador = Prestador.find_by_id(params[:id])
		if @prestador
			@inscripcion = Inscripcion.find(@prestador.inscripcion_actual) if @prestador.inscripcion_actual
			# Autorizar acceso
			if current_user.prestador != @prestador
				authorize! :read, Prestador, message: 'No tienes permisos suficientes para ver esta página'
			else
				render	layout: 'prestador'
			end			
		else
			no_encontrado
		end
	end

	def destroy
		Prestador.find(params[:id]).destroy
		flash[:success] = "Prestador borrado correctamente"
		redirect_to current_user.user_page
	end

	private
		def no_encontrado(msg = nil, page = nil)
			msg ||= "Prestador no encontrado"
			flash[:error] = msg
			page ||= current_user.user_page
			redirect_to page
		end
end
