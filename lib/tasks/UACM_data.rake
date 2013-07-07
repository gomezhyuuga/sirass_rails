# encoding: UTF-8
require "csv"
namespace :db do
	namespace :uacm do
		desc "Llenar base de datos con información de la UACM"
		task all: [:environment, :dev_users, :cuentas_admin, :instituciones, :planteles, :tipo_programa, :alcance_programa, :estado_programa, :estado_inscripcion, :estado_reporte, :horario_programa, :poblacion_programa, :dias]

		desc "Users de admin"
		task dev_users: :environment do
			Admin.create!(nombre: "Fernando",apaterno: "Gómez",amaterno: "Herrera",nacimiento: "04/02/1994",
				cargo: "Desarrollador de Sistema",user_attributes: {
					username: "a_gomezhyuuga",
					email: "gomezhyuuga@gmail.com",
					password: "a_ghyuuga852456",
					password_confirmation: "a_ghyuuga852456"})
		end

		desc "Datos de configuración de la app"
		task :configs => [:environment] do
			puts "Estableciendo configuración inicial..."
			Configuracion.create!(nombre: "responsable_ss", valor: "Martha G. Tera Ponce")
			Configuracion.create!(nombre: "convocatoria", valor: "on")
		end

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
		desc "Catálogo de EstadoInscripcion"
		task estado_inscripcion: :environment do
			puts "Importando catálogo de estado_inscripcion"
			csv_text = File.read("db/csv/estado_inscripcion.csv")
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				EstadoInscripcion.create!(row.to_hash.symbolize_keys)
			end
		end

		desc "Catálogo de EstadoReporte"
		task estado_reporte: :environment do
			puts "Importando catálogo de estado_reporte"
			csv_text = File.read("db/csv/estado_reporte.csv")
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				EstadoReporte.create!(row.to_hash.symbolize_keys)
			end
		end

		desc "Usuarios admin"
		task cuentas_admin: :environment do
			puts "Importando cuentas para administradores"
			csv_text = File.read("db/csv/cuentas_admins.csv")
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				row = row.to_hash.with_indifferent_access
				row = row.to_hash.symbolize_keys
				# Admin.create!(row.to_hash.symbolize_keys)
				a = Admin.new(nombre: row[:nombre], apaterno: row[:apaterno], amaterno: row[:amaterno],
					nacimiento: row[:nacimiento], cargo: row[:cargo],
					user_attributes: { username: row[:username], email: row[:email], password: row[:password],
						password_confirmation: row[:password_confirmation] })
				a.save!
			end
		end
	end
end
