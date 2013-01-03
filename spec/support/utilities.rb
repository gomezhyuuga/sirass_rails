# -*- encoding : utf-8 -*-

include ApplicationHelper

def full_title(page_title)
  base_title = "SiRASS"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def buildModel(model)
	o = [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
	randomUser = (0...10).map{ o[rand(o.length)] }.join

	username = randomUser
	email = Faker::Internet.free_email
	password = 'foobar'

	# Definir qué modelo crear
	if model == :user
		User.new(username: username, password: password, password_confirmation: password, email: email)
	elsif model == :prestador
		Prestador.new(nombre: "John",
		aPaterno: 	"Doe",
		aMaterno:		"Smith",
		nacimiento:	"01/01/1991",
		sexo: 			"Masculino",
		dCalle: 		Faker::Address.street_name,
		dNumExt: 		Faker::Address.building_number,
		dNumInt: 		Faker::Address.secondary_address,
		dCP: 				Faker::Address.zip,
		dDelegacion: Faker::Address.state,
		dColonia: 	Faker::Address.state,
		telCasa: 		Faker::PhoneNumber.phone_number,
		telCel: 		Faker::PhoneNumber.cell_phone)
	elsif model == :institucion_user
		domicilio		=	Faker::Address.street_address
		area				=	Faker::Company.bs
		responsable	=	Faker::Name.name
		cargo				=	Faker::Lorem.sentence(4)
		tel					=	Faker::PhoneNumber.phone_number
		telExt 			= "12345"

		InstitucionUser.new(
	  	domicilio: domicilio,
	  	area: area,
	  	responsable: responsable,
	  	cargo: cargo,
	  	tel: tel, telExt: telExt)
	elsif model == :admin
		Admin.new(nombre: "John",
		aPaterno: 	"Doe",
		aMaterno:		"Smith",
		nacimiento:	"01/01/1991",
		cargo: 'Responsable de SS')
	elsif model == :institucion
		Institucion.new(nombre: 'Institución X', educativa: false)
	elsif model == :plantel
			Plantel.new(nombre: 'Plantel X')
	end
end
