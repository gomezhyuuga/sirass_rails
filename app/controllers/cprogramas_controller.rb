# encoding: UTF-8
class CprogramasController < ApplicationController
	layout 'institucion'
	def index
		@cprogramas = Cprograma.paginate(page: params[:page], per_page: 15)
		
		# render layout: layout_for_current_user
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

end
