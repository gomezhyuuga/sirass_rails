# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'pp'

describe "AuthenticationPages" do
  
  subject { page }

  describe "authorization" do
    describe "for signed users" do
      describe "when attemping to visit a page that is not for them" do
        describe "as prestador" do
          before do
            visit login_path
            aUser = buildModel(:user)
            fill_in 'Nombre de usuario', with: aUser.username
            fill_in 'Contraseña', with: aUser.password
            prestador_user = buildModel(:prestador)
            prestador_user.user = aUser
            prestador_user.save!
            click_button 'Iniciar sesión'
          end

          describe "visiting admin pages" do
            before { visit admin_home_path }

            it { should have_selector('.alert-error') }
            it { should have_content('No eres un administrador') }
          end
          describe "visiting institucion pages" do
            before { visit institucion_home_path }

            it { should have_selector('.alert-error') }
            it { should have_content('No eres una institucion') }
          end
        end
        describe "as admin" do
          before do
            visit login_path
            aUser = buildModel(:user)
            fill_in 'Nombre de usuario', with: aUser.username
            fill_in 'Contraseña', with: aUser.password
            admin = buildModel(:admin)
            admin.user = aUser
            admin.save!
            click_button 'Iniciar sesión'
          end

          describe "visiting prestador pages" do
            before { visit prestador_home_path }

            it { should have_selector('.alert-error') }
            it { should have_content('No eres un prestador') }
          end
          describe "visiting institucion pages" do
            before { visit institucion_home_path }

            it { should have_selector('.alert-error') }
            it { should have_content('No eres una institucion') }
          end
        end
      end
    end
  end

  describe "Login page" do
    before { visit login_path }

    it { should have_selector('title', text: full_title('Iniciar sesión')) }
    it { should have_selector('h1', text: 'Iniciar sesión') }	

    describe "login" do
    	describe "with invalid data" do
    		before do
	    	  fill_in 'Nombre de usuario', with: 'userNotExists'
	    	  fill_in 'Contraseña', with: 'mypass'
	    	  click_button 'Iniciar sesión'
	    	end

	    	it { should have_content('Error') }
    	end

      describe "with valid data as a prestador" do
        user = buildModel(:user)
        password = user.password
        prestador = buildModel(:prestador)
        prestador.user = user
        prestador.save!

        before do
          fill_in 'Nombre de usuario', with: user.username
          fill_in 'Contraseña', with: password
          click_button 'Iniciar sesión'
        end
        it { should have_content('Sesion iniciada correctamente') }

        it "should be the right page for the role" do
          current_path.should == user.user_page
        end
      end
      describe "with valid data as an institucion" do
        user = buildModel(:user)
        password = user.password
        institucion = buildModel(:institucion_user)
        institucion.institucion = Institucion.find_or_create_by_nombre("Institucion prueba")
        institucion.user = user
        institucion.save!

        before do
          fill_in 'Nombre de usuario', with: user.username
          fill_in 'Contraseña', with: password
          click_button 'Iniciar sesión'
        end
        it { should have_content('Sesion iniciada correctamente') }

        it "should be the right page for the role" do
          current_path.should == user.user_page
        end
      end
      describe "with valid data as an admin" do
        user = buildModel(:user)
        password = user.password
        admin = buildModel(:admin)
        admin.user = user
        admin.save!

        before do
          fill_in 'Nombre de usuario', with: user.username
          fill_in 'Contraseña', with: password
          click_button 'Iniciar sesión'
        end
        it { should have_content('Sesion iniciada correctamente') }

        it "should be the right page for the role" do
          current_path.should == user.user_page
        end
      end
    end
  end
end
