# encoding: utf-8
class ArticuloMailer < ActionMailer::Base
  default from: "SiRASS <sirassapp@gmail.com>"

  def observaciones_actualizadas(articulo)
  	subject = "Observaciones en tu solicitud de inscripción"
  	@articulo = articulo
  	@prestador = @articulo.prestador
  	@user = @articulo.prestador.user

  	mail( to: articulo.prestador.user.email,
      subject: subject )
  end

  def estado_actualizado(articulo)
    subject = "El estado de tu inscripción ha cambiado"
    @articulo = articulo
    @prestador = @articulo.prestador
    @user = @articulo.prestador.user

    mail( to: articulo.prestador.user.email,
      subject: subject )
  end
end
