# -*- encoding : utf-8 -*-
FactoryGirl.define do
	factory :user do
		sequence(:username) { |n| "test_user#{n}" }
		sequence(:email) { |n| "email#{n}@example.com" }
		password							"foobar"
		password_confirmation	"foobar"
	end

	factory :prestador do
		nombre			"John"
		aPaterno 		"Doe"
		aMaterno		"Smith"
		nacimiento	"01/01/1991"

		user
	end

	factory :institucion_user do
		institucion_id 	2
		plantel_id			1
		domicilio				Faker::Address.street_address
		area						Faker::Company.bs
		responsable			Faker::Name.name
		cargo						Faker::Lorem.sentence(4)
		tel							Faker::PhoneNumber.phone_number
		telExt					12345

		user
	end

	factory :admin do
		nombre			"John"
		aPaterno 		"Doe"
		aMaterno		"Smith"
		nacimiento	"01/01/1991"
		cargo				"Responsable de Servicio Social"

		user
	end
end
