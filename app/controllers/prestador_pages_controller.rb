class PrestadorPagesController < ApplicationController
	before_filter :require_login
	layout 'prestador'
	def index
		require_role(:prestador)
	end
end
