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

		# Asignar la institución de la UACM
		Institucion.find_by_nombre("UACM").update_attribute(:uacm, true)
	end
end