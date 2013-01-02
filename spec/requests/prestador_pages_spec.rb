# encoding: UTF-8
require 'spec_helper'

describe "PrestadorPages" do
  
  subject { page }

  describe "show" do
    
  end

  describe "signup" do
  	before { visit registro_path }
  	let(:submit) { "Registrarse" }

  	it { should have_selector('title', text: full_title('Registro de prestador')) }
  	it { should have_selector('h1', text: 'Registro de prestador') }

  	describe "with valid data" do
  		before do
        u = buildModel(:user)
        p = buildModel(:prestador)
				fill_in "Nombre",								with: p.nombre
				fill_in	"Apellido Paterno",			with: p.aPaterno
				fill_in	"Apellido Materno",			with: p.aMaterno
        fill_in "Fecha de nacimiento",  with: p.nacimiento
        choose "Masculino"

        fill_in "Calle",                with: p.dCalle
        fill_in "prestador_dNumExt",    with: p.dNumExt
        fill_in "prestador_dNumInt",    with: p.dNumInt
        fill_in "Código postal",        with: p.dCP
        fill_in "Delegación/Municipio", with: p.dDelegacion
        fill_in "Colonia",              with: p.dColonia
        fill_in "Teléfono",             with: p.telCasa
        fill_in "Celular",              with: p.telCel

  		  fill_in	"Nombre de usuario",		with: u.username
  		  fill_in	"Email",								with: u.email
  		  fill_in	"Contraseña",						with: "foobar"
  		  fill_in	"Confirmar contraseña",	with: "foobar"
  		end

  		it "should create a prestador" do
  			expect { click_button submit }.to change(Prestador, :count).by(1)
  		end

  		it "should create a user" do
  			expect { click_button submit }.to change(Prestador, :count).by(1)
  		end

  		describe "after creating user" do
        before { click_button submit }
  			it { should have_selector('div.alert.alert-success', text: "Bienvenido a SiRASS!") }
  		end
  	end

  	describe "with invalid data" do
  		it "should not create user" do
  			expect { click_button submit }.not_to change(User, :count)
  		end
  		it "should not create prestador" do
  			expect { click_button submit }.not_to change(Prestador, :count)
  		end

  		describe "after submitting" do
        before { click_button submit }

  			it { should have_selector('title', text: "Registro de prestador") }
  			it { should have_content('error') }
  		end
  	end
  end
end