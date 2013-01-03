# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = login(params[:session][:username], params[:session][:password], params[:session][:remember_me])

		if @user
			redirect_back_or_to @user.user_page, success: "Sesion iniciada correctamente. Bienvenido!"
		else
			flash.now[:error] = "Error! Tu contraseña y/o nombre de usuario son incorrectos."
			render 'new'
		end
	end

	def destroy
		logout
		redirect_to root_url, success: "La sesión se ha cerrado correctamente."
	end
end
