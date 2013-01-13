# -*- encoding : utf-8 -*-
module UsersHelper
	def check_password_update(params, model)
		if params[model][:user_attributes][:password].blank?
			# Borrar de los parámetros para que se trate como nil y no haya problemas al validar
			params[model][:user_attributes].delete(:password)
			params[model][:user_attributes].delete(:password_confirmation)
		end
	end

	def logged_as?(user_type)
		return false if !current_user
		if user_type == :admin
			current_user.admin_id != nil
		elsif user_type == :prestador
			current_user.prestador_id != nil
		elsif user_type == :institucion
			current_user.institucion_user_id != nil
		end
	end

	def layout_for_current_user
		return "application" if !current_user
		return "prestador" if current_user.prestador_id != nil
		return "admin" if current_user.admin_id != nil
		return "institucion" if current_user.institucion_user_id != nil
	end
end
