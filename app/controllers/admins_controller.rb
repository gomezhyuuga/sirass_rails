# encoding: UTF-8
class AdminsController < ApplicationController
	before_filter :require_login
	layout 'admin'

	def new
		
	end

	def create
		
	end

	def show
		
	end

	def index
		require_role(:admin)
	end

	def home
		
	end
end
