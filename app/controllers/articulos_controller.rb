# encoding: UTF-8
class ArticulosController < ApplicationController
  before_filter :require_login
  layout 'prestador'
  def index
    authorize! :manage, Articulo
    conditions = {}
    conditions[:estado_inscripcion_id] = params[:estado] unless params[:estado].blank?
    @articulos = Articulo.page(params[:page]).where(conditions)
    render layout: 'admin'
  end

  def destroy
    authorize! :manage, Articulo
    @articulo = Articulo.find(params[:id])
    if @articulo.destroy
      flash[:success] = "Registro eliminado correctamente"
      redirect_to current_user.user_page
    else
      flash.now[:error] = "No eliminado"
      redirect_to articulos_path
    end
  end

  def show
    authorize! :manage, Articulo
    @articulo = Articulo.find(params[:id])
    render layout: 'admin'
  end

  def new
    require_role(:prestador)
    if current_user.prestador && !current_user.prestador.articulo_id or can? :manage, Articulo
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
    if logged_as? :prestador
      @articulo.estado_inscripcion_id = EstadoInscripcion::ACTUALIZADA
    end
    if @articulo.update_attributes(params[:articulo])
      flash[:success] = "Inscripción actualizada correctamente"
      if logged_as? :admin
        redirect_to articulos_path
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

  def update_stat
    authorize! :manage , Articulo
    if Articulo.update(params[:articulo_id], estado_inscripcion_id: params[:status])
      flash[:success] = "Estado actualizado correctamente!"
      ArticuloMailer.estado_actualizado(Articulo.find_by_id(params[:articulo_id])).deliver
    else
      flash[:error] = "Ocurrió un error actualizando el estado"
    end
    redirect_to articulos_path
  end

  def update_observaciones
    observaciones = params[:articulo][:observaciones]
    if Articulo.update(params[:articulo_id], observaciones: observaciones, estado_inscripcion_id: EstadoInscripcion::ERRORES)
      flash[:success] = "Observaciones actualizadas con éxito"
      ArticuloMailer.observaciones_actualizadas(Articulo.find_by_id(params[:articulo_id])).deliver
      redirect_to articulos_path(params[:articulo_id])
    else
      flash[:error] = "Ocurrió un error actualizando las observaciones"
      redirect_to articulos_path(params[:articulo_id])
    end
  end
end
