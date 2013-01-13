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
		redirect_to cprogramas_path
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
end
