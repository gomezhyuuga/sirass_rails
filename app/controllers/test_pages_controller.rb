# -*- encoding : utf-8 -*-
class TestPagesController < ApplicationController
  def visual
  	@prestador = Prestador.new
  	@instituciones = Institucion.all
  end

  def info
  	@admin = Admin.first
  end

  def mail
  	@inscripcion = Inscripcion.first
    # InscripcionMailer.observaciones_actualizadas(@inscripcion).deliver
    InscripcionMailer.estado_actualizado(@inscripcion).deliver
  	render layout: 'application'
  end
end
