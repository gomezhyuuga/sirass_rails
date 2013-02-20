# encoding: utf-8
module InscripcionsHelper
	def print_dias(inscripcion)
		inscripcion.dias.each.map { |d| d.dia_semana }.join(', ')
	end

	def nombre_plantel(inscripcion)
		if inscripcion.plantel
			inscripcion.plantel.nombre
		else
			"Sin plantel"
		end
	end
end
