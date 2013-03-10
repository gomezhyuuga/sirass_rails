# encoding: utf-8
namespace :db do
	desc "Elimina la base de datos y vuelve a cargar la info"
	task reset_all: [:environment, 'db:reset', 'db:migrate', 'db:uacm:all'] do
		
	end
end