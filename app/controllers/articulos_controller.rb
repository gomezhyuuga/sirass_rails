# encoding: UTF-8
class ArticulosController < ApplicationController
  before_filter :require_login
  layout 'prestador'
  def index
  end

  def show
  end

  def new
    require_role(:prestador)
    if current_user.prestador && !current_user.prestador.articulo_id
      @articulo = Articulo.new
    else
      redirect_to prestador_home_path
    end
  end

  def create
    @articulo = Articulo.new(params[:articulo])
    @articulo.estado_inscripcion_id = EstadoInscripcion::VALIDANDO
    @articulo.prestador_id = current_user.prestador.id
    if @articulo.save && Prestador.update(@articulo.prestador.id, articulo_id: @articulo.id)
      flash[:success] = "Inscripción registrada correctamente"
        redirect_to current_user.user_page
    else
        flash.now[:error] = "Inscripción con errores"
        render 'new'
    end
  end

  def edit
    @articulo = Articulo.find(params[:id])
    if current_user.prestador
      render 'edit'
    else
      authorize! :manage, Articulo
        render 'edit', layout: 'admin'
    end
  end

  def update
    @articulo = Articulo.find(params[:id])
    if @articulo.update_attributes(params[:articulo])
      flash[:success] = "Inscripción actualizada correctamente"
      if logged_as? :admin
        redirect_to inscripcions_path
      else
        redirect_to prestador_home_path
      end
    else
      flash.now[:error] = "Ocurrió un error actualizando la inscripción"
      if logged_as? :admin
        render 'edit', layout: 'admin'
      else
        redirect_to articulo_edit_path
      end
    end
  end

  def delete
    @articulo = Articulo.find_by_prestador_id(current_user.prestador.id)
    @articulo.destroy
    redirect_to current_user.user_page
  end
end
