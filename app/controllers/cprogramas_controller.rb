class CprogramasController < ApplicationController
	layout 'institucion'
	def index

	end

	def show
		
	end

	def new
		@cprograma = Cprograma.new()
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
	def update
		
	end

end
