# encoding: utf-8
class InscripcionMailer < ActionMailer::Base
  default from: "SiRASS <sirassapp@gmail.com>"

  def observaciones_actualizadas(inscripcion)
  	subject = "Observaciones en tu solicitud de inscripción"
  	@inscripcion = inscripcion
  	@prestador = @inscripcion.prestador
  	@programa = @inscripcion.cprograma
  	@user = @inscripcion.prestador.user

  	mail( to: inscripcion.prestador.user.email,
      subject: subject )
  end

  def estado_actualizado(inscripcion)
    subject = "El estado de tu inscripción ha cambiado"
    @inscripcion = inscripcion
    @prestador = @inscripcion.prestador
    @programa = @inscripcion.cprograma
    @user = @inscripcion.prestador.user

    mail( to: inscripcion.prestador.user.email,
      subject: subject )
  end
end
