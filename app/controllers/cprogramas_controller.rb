# encoding: UTF-8
class CprogramasController < ApplicationController
	layout 'institucion'
	def index

	end

	def show
		
	end

	def new
		@cprograma = Cprograma.new
<<<<<<< HEAD
		@cprograma.licenciaturas.build
		@cprograma.responsables.build
=======
		3.times { @cprograma.licenciaturas.build }
>>>>>>> 5f35baffb11a696ecf4065ae75396dc7cfb9af2d
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
