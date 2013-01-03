# -*- encoding : utf-8 -*-
require 'spec_helper'
require "pp"

describe "PublicPages" do
  
  subject { page }

  shared_examples_for "all static pages" do
  		it { should have_selector('h1', 			text: heading) }
			it { should have_selector('title', 		text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) 		{ "SiRASS, Servicio Social" }
		let(:page_title) 	{ "Sistema de Registro y Administración de Servicio Social" }
		it_should_behave_like "all static pages"

		# Links
		it "should have the right links on the layout" do
	    visit root_path
	    click_link "ayuda"
	    page.should have_selector 'title', text: full_title('Ayuda')
	    click_link "Programas"
	    page.should have_selector 'title', text: full_title('Programas')
	    click_link "Proceso"
	    page.should have_selector 'title', text: full_title('Proceso')
  	end

  	# describe "when user is logged in" do
  	#   it { should_not have_link('Iniciar sesión') }
  	#   it { should_not have_link('Regístrate') }
  	#   it { should have_link('Cerrar sesión') }
  	# end

  	# describe "when user is not logged in" do
  	#   it { should have_link('Iniciar sesión') }
  	#   it { should have_link('Regístrate') }
  	# end
  end

  describe "header" do
    before { visit ayuda_path }

    it { should have_link('Ayuda', href: ayuda_path) }
    it { should have_link('Programas', href: programas_path) }
    it { should have_link('Proceso', href: proceso_path) }
  end
end
