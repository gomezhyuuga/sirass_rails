# -*- encoding : utf-8 -*-
class TestPagesController < ApplicationController
  def visual
  	@prestador = Prestador.new
  	@instituciones = Institucion.all
  end
end
