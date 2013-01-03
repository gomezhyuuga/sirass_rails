# -*- encoding : utf-8 -*-
module UsersHelper
	def check_password_update(params, model)
		if params[model][:user_attributes][:password].blank?
			# Borrar de los parámetros para que se trate como nil y no haya problemas al validar
			params[model][:user_attributes].delete(:password)
			params[model][:user_attributes].delete(:password_confirmation)
		end
	end
end
