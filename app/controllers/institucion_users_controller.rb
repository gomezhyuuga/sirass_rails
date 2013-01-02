class InstitucionUsersController < ApplicationController
	before_filter :require_login, except: [:create, :new]
	layout 'institucion'

	def index
		
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
		
	end

	def new
		@institucion = InstitucionUser.new
		@institucion.build_user

		render layout: 'application'
	end
end
