# encoding: UTF-8
namespace :deploy do
	desc "Configuración para deploy"
	task :init => [:environment] do
		puts "Ejecutando tareas de configuración para deploy..."
		system "RAILS_ENV=production"
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:reset"].invoke
		Rake::Task["db:uacm:all"].invoke
		Rake::Task["assets:precompile"].invoke
	end
end