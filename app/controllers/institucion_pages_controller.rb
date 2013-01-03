# -*- encoding : utf-8 -*-
class InstitucionPagesController < ApplicationController
	before_filter :require_login
	layout 'institucion'

	def index
		require_role(:institucion)
	end
end
