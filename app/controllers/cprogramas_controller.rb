# encoding: UTF-8
class CprogramasController < ApplicationController
	layout 'institucion'
	def index
		# Detectar si se listan los programas por categoria internos o externos
		if params[:internos] != nil
			categoria = params[:internos]
			@cprogramas = Cprograma.where(categoria_interno: categoria).paginate(page: params[:page], per_page: 15)
		else
			# Se listan todos los programas
			@cprogramas = Cprograma.paginate(page: params[:page], per_page: 15)
		end
		render layout: 'application'
	end

	def show
		@programa = Cprograma.find(params[:id])
		render layout: 'application'
	end

	def new
		@cprograma = Cprograma.new
		3.times {@cprograma.licenciaturas.build}
		@cprograma.responsables.build
	end

	def create
		@cprograma = Cprograma.new(params[:cprograma])
		if @cprograma.save
			flash[:success] = "Programa creado correctamente"
			redirect_to current_user.user_page
		else
			flash.now[:error] = "Programa con errores"
			render 'new'
		end
	end

	def destroy
		
	end

	def edit
		@cprograma = Cprograma.find_by_id(params[:id])
		
		render 'edit'
	end

	def update
		@cprograma = Cprograma.find(params[:id])
		if @cprograma.update_attributes(params[:cprograma])
			redirect_to current_user.user_page
		else
			flash.now[:error] = "Ocurrió un error actualizando el programa."
			render 'edit'
		end
	end

	# Actualizar solo el estado de un programa
	def update_status
		if Cprograma.update(params[:id], estado_programa_id: params[:status])
			flash[:success] = "Estado actualizado correctamente!"
		else
			flash[:error] = "Ocurrió un error actualizando el estado"
		end
		redirect_to cprograma_path(params[:id])
	end
	# Actualizar solo las observaciones de un programa
	def update_observaciones
		observaciones = params[:cprograma][:observaciones]
		if Cprograma.update(params[:id], observaciones: observaciones)
			flash[:success] = "Observaciones actualizadas correctamente!"
		else
			flash[:error] = "Ocurrió un error actualizando las observaciones"
		end
		redirect_to cprograma_path(params[:id])
	end
	# Actualizar solo la clave de un programa
	def cambiar_clave
		@programa = Cprograma.find(params[:id])
		render layout: 'admin'
	end
	def update_clave
		nueva_clave = params[:cprograma][:cveprograma]
		if Cprograma.update(params[:id], cveprograma: nueva_clave)
			flash[:success] = "Clave del programa actualizada correctamente!"
		else
			flash.now[:error] = "Ocurrió un error actualizando la clave del programa!"
		end
		redirect_to cprograma_path(params[:id])
	end

	# Generar clave de programa
	def generar_nueva_clave
		@id 							= params[:id]
		consecutivo 			= 1 + Cprograma.where('estado_programa_id != 4 AND estado_programa_id != 6').count
		current_year 			= Date.today.year.to_s[2..3]
		last_update_year 	= Cprograma.find(@id).updated_at.year.to_s[2..3]
		@clave = "UACM/SS/#{current_year}-#{last_update_year}/#{consecutivo}"
		respond_to do |format|
			format.js
		end
	end
end
