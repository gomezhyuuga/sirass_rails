# encoding: UTF-8
namespace :db do
	desc "Llenar base de datos con información de ejemplo"
	task :populate => [:prestadores, :admins, :institucion_users, :programas]

	desc "Información de prueba. Usuarios prestadores"
	task prestadores: :environment do
		puts "Creando prestadores..."
		Prestador.create!(nombre: "Fernando",
			aPaterno: "Gómez",
			aMaterno: "Herrera",
			nacimiento: "04/02/1994",
			sexo: "Masculino",
			dCalle: 		"Victor Hernández",
			dNumExt: 		"S/N",
			dNumInt: 		"A3 Dpto. 101",
			dCP: 				"02430",
			dDelegacion: "Azcapotzalco",
			dColonia: 	"Presidente Madero",
			telCasa: 		"46229731",
			telCel: 		"5510697423",
			user_attributes: {
					username: "prestador1",
					email: "example@me.com",
					password: "foobar",
					password_confirmation: "foobar"
			}
		)

		# Crear prestadores
		24.times do |n|
			username = "prestador#{n+2}"
			
			password = "foobar"
			email = "mail#{n+2}@icloud.com"

			name = Faker::Name.first_name
			aPaterno = Faker::Name.last_name
			aMaterno = Faker::Name.last_name

			Prestador.create!(nombre: name,
				aPaterno: aPaterno,
				aMaterno: aMaterno,
				nacimiento: "04/04/1994",
				sexo: 			"Masculino",
				dCalle: 		Faker::Address.street_name,
				dNumExt: 		Faker::Address.building_number,
				dNumInt: 		Faker::Address.secondary_address,
				dCP: 				Faker::Address.zip,
				dDelegacion: Faker::Address.state,
				dColonia: 	Faker::Address.state,
				telCasa: 		Faker::PhoneNumber.phone_number,
				telCel: 		Faker::PhoneNumber.cell_phone,
				user_attributes: {
						username: username,
						email: email,
						password: password,
						password_confirmation: password
				}
			)
		end
	end

	desc "Información de prueba. Usuarios admin."
	task admins: :environment do
		puts "Creando admins..."
		# Crear administradores
		Admin.create!(nombre: "Martha",
			aPaterno: "Terca",
			aMaterno: "Ponce",
			nacimiento: "24/04/1988",
			cargo: "Responsable de Servicio Social",
			user_attributes: {
					username: "admin1",
					email: "example@me.com",
					password: "foobar",
					password_confirmation: "foobar"
			}
		)
		24.times do |n|
			username = "admin#{n+2}"
			password = "foobar"
			email = "mail#{n+2}@icloud.com"

			name = Faker::Name.first_name
			aPaterno = Faker::Name.last_name
			aMaterno = Faker::Name.last_name
			cargo = Faker::Lorem.sentence(4)
			nacimiento = "04/04/1960"

			Admin.create!(nombre: name,
				aPaterno: aPaterno,
				aMaterno: aMaterno,
				nacimiento: nacimiento,
				cargo: cargo,
				user_attributes: {
						username: username,
						email: email,
						password: password,
						password_confirmation: password
				}
			)
		end
	end

	desc "Información de prueba. Usuarios Institución"
	task institucion_users: :environment do
		puts "Creando usuarios de instituciones..."
		# Crear instituciones
		institucion = Institucion.create!(nombre: Faker::Company.name)
		plantel = Plantel.new(nombre: Faker::Company.name, institucion: institucion)
		plantel.save!
		i = InstitucionUser.new(
	  	domicilio: "Eugenia",
	  	area: "Oficina de Servicio Social",
	  	responsable: "Martha G. Tera Ponce",
	  	cargo: "Responsable de Servicio Social",
	  	tel: "11084536", telExt: "36630",
	  	user_attributes: {
	  		username: 'institucion1',
	  		email: 'marthag@uacm.edu.mx',
	  		password: 'foobar',
	  		password_confirmation: 'foobar'
  		}
		)
		i.institucion = institucion
		i.plantel = plantel
		i.save!
		24.times do |n|
			username = "institucion#{n+2}"
			password = "foobar"
			email = "mail#{n+2}@icloud.com"

			domicilio		=	Faker::Address.street_address
			area				=	Faker::Company.bs
			responsable	=	Faker::Name.name
			cargo				=	Faker::Lorem.sentence(4)
			tel					=	Faker::PhoneNumber.phone_number

			InstitucionUser.create!(institucion_id: Random.rand(1..63),
		  	plantel_id: Random.rand(1..12),
		  	domicilio: domicilio,
		  	area: area,
		  	responsable: responsable,
		  	cargo: cargo,
		  	tel: tel, telExt: "12345",
		  	user_attributes: {
		  		username: username,
		  		email: email,
		  		password: 'foobar',
		  		password_confirmation: 'foobar'
	  		})
		end
	end

	desc "Información de prueba. Programas de SS"
	task programas: [:environment] do
		puts "Creando programas de prueba..."
		# Crear programas
		24.times do |n|
			lorem = Faker::Lorem.paragraph(3)
			dias_ids = 5.times.map { Random.rand(1..7) }
			p_ids = 5.times.map { Random.rand(1..9) }
			a_ids = 5.times.map { Random.rand(1..9) }

			Cprograma.create!(
				tipo_programa_id: Random.rand(1..8),
				estado_programa_id: Random.rand(1..5),
				categoria_interno: [true, false].sample,
				nombre: "Programa #{n}",
				cveprograma: "UACM-SS-#{n}",
				institucion_id: Random.rand(1..40),
				dia_ids: dias_ids,
				poblacion_programa_ids: p_ids,
				alcance_programa_ids: a_ids,
				lugar: "Oficina",
				desarrollo: lorem,
				evaluacion: lorem,
				justificacion: lorem,
				objGeneral: lorem,
  			observaciones: lorem,
  			recursos: lorem,
  			resultados: lorem)
		end
	end
end