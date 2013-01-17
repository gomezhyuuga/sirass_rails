# encoding: UTF-8
require "csv"
namespace :db do
	namespace :uacm do
		desc "User de admin"
		task user: :environment do
			Admin.create!(nombre: "Martha",aPaterno: "Terca",aMaterno: "Ponce",nacimiento: "24/04/1988",cargo: "Responsable de Servicio Social",user_attributes: {username: "marthag",email: "marthag@hotmail.com",password: "martha_2615",password_confirmation: "martha_2615"})
		end
		desc "Llenar base de datos con información de la UACM"
		task all: [:environment, :user, :instituciones, :planteles, :tipo_programa, :alcance_programa, :estado_programa, :horario_programa, :poblacion_programa, :dias]

		desc "Catálogo de Instituciones"
		task :instituciones => :environment do
			puts "Importando catálogo de Instituciones"
			# Catálogo de instituciones
			csv_text = File.read('db/csv/institucions.csv')
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				Institucion.create!(row.to_hash.symbolize_keys)
			end

			# Asignar la institución de la UACM
			Institucion.find_by_nombre("UACM").update_attribute(:uacm, true)
		end

		desc "Catálogo de Planteles"
		task :planteles => :environment do
			puts "Importando catálogo de Planteles"
			# Catálogo de planteles
			csv_text = File.read("db/csv/plantels.csv")
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				Plantel.create!(row.to_hash.symbolize_keys)
			end
		end

		desc "Catalogo de TipoPrograma"
		task :tipo_programa => :environment do
			puts "Importando catálogo de TipoPrograma"
			#Catalogo de tipo_Programa
			csv_text = File.read("db/csv/tipo.csv")
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				TipoPrograma.create!(row.to_hash.symbolize_keys)
			end
		end

		desc "Catálogo de AlcancePrograma"
		task :alcance_programa => :environment do
			#Catalogo alcances_programa
			csv_text = File.read("db/csv/alcance_programa.csv")
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				AlcancePrograma.create!(row.to_hash.symbolize_keys)
			end
		end

		desc "Catálogo de EstadoPrograma"
		task :estado_programa => :environment do
			#Catalogo estado_programa
			csv_text = File.read("db/csv/estado_programa.csv")
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				EstadoPrograma.create!(row.to_hash.symbolize_keys)
			end
		end

		desc "Catálogo de HorarioPrograma"
		task :horario_programa => :environment do
			puts 'Importando catálogo de HorarioPrograma'
			#Catalogo horario_programa
			csv_text = File.read("db/csv/horario_programa.csv")
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				HorarioPrograma.create!(row.to_hash.symbolize_keys)
			end
		end

		desc "Catálogo de PoblacionPrograma"
		task :poblacion_programa => :environment do
			puts "Importando catálogo de PoblacionPrograma"
			#Catalogo poblacion_programa
			csv_text = File.read("db/csv/poblacion_programa.csv")
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				PoblacionPrograma.create!(row.to_hash.symbolize_keys)
			end
		end

		desc "Catálogo de días"
		task dias: :environment do
			puts "Importando catálogo de días"
			#Catalogo días
			csv_text = File.read("db/csv/catalogo_dias.csv")
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				Dia.create!(row.to_hash.symbolize_keys)
			end
		end
	end
end
