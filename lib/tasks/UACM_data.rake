# encoding: UTF-8
require "csv"
namespace :db do
	desc "Llenar base de datos con información de la UACM"
	task uacm: :environment do
		# Catálogo de instituciones
		csv_text = File.read('db/institucions.csv')
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
		  row = row.to_hash.with_indifferent_access
		  Institucion.create!(row.to_hash.symbolize_keys)
		end

		# Catálogo de planteles
		csv_text = File.read("db/plantels.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
		  row = row.to_hash.with_indifferent_access
		  Plantel.create!(row.to_hash.symbolize_keys)
		end

		#Catalogo de tipo_Programa
		csv_text = File.read("db/tipo.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
		  	row = row.to_hash.with_indifferent_access
			TipoPrograma.create!(row.to_hash.symbolize_keys)
		end

		#Catalogo alcances_programa
		csv_text = File.read("db/csv/alcance_programa.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
		  	row = row.to_hash.with_indifferent_access
			AlcancePrograma.create!(row.to_hash.symbolize_keys)
		end

		#Catalogo estado_programa
		csv_text = File.read("db/csv/estado_programa.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
		  	row = row.to_hash.with_indifferent_access
			EstadoPrograma.create!(row.to_hash.symbolize_keys)
		end

		#Catalogo horario_programa
		csv_text = File.read("db/csv/horario_programa.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
		  	row = row.to_hash.with_indifferent_access
			HorarioPrograma.create!(row.to_hash.symbolize_keys)
		end

		#Catalogo poblacion_programa
		csv_text = File.read("db/csv/poblacion_programa.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
		  	row = row.to_hash.with_indifferent_access
			PoblacionPrograma.create!(row.to_hash.symbolize_keys)
		end

		#Catalogo dias
		csv_text = File.read("db/csv/dia.csv")
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
		  	row = row.to_hash.with_indifferent_access
			Dia.create!(row.to_hash.symbolize_keys)
		end

		# Asignar la institución de la UACM
		Institucion.find_by_nombre("UACM").update_attribute(:uacm, true)
	end
end