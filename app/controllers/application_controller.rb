# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  include UsersHelper

  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "No tienes los permisos suficientes para ver esta página"
  	redirect_to root_url
    # render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
  	flash[:error] = "Registro no encontrado!"
    if current_user
      redirect_to current_user.user_page
    else
      redirect_to root_path
    end
  	
  end
end
