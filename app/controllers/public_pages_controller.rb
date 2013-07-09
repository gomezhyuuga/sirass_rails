# -*- encoding : utf-8 -*-
class PublicPagesController < ApplicationController

  def index
  	@c = Configuracion.find_by_nombre("convocatoria")
  	if @c.valor == "Desactivar"
  		@span1 = "span12"
  		@osv = "offset3"
  	else
  		@span1 = "span6"
  		@osv = " "
  	end
  	render layout: false
  end

  def programas
  end

  def ayuda
  end

  def proceso
  end
end
