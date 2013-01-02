class AdminPagesController < ApplicationController
	before_filter :require_login
	layout 'admin'

	def index
		require_role(:admin)
	end

	def show
		
	end
end
