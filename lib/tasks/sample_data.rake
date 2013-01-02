# encoding: UTF-8
namespace :db do
	desc "Llenar base de datos con información de ejemplo"
	task populate: :environment do
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
		44.times do |n|
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
		44.times do |n|
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

		# Crear instituciones
		InstitucionUser.create!(institucion_id: 2,
	  	plantel_id: 2,
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
		44.times do |n|
			username = "institucion#{n+2}"
			password = "foobar"
			email = "mail#{n+2}@icloud.com"

			domicilio		=	Faker::Address.street_address
			area				=	Faker::Company.bs
			responsable	=	Faker::Name.name
			cargo				=	Faker::Lorem.sentence(4)
			tel					=	Faker::PhoneNumber.phone_number

			InstitucionUser.create!(institucion_id: 2,
		  	plantel_id: 2,
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
end