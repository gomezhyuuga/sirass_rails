# encoding: UTF-8
module ArticulosHelper
	def links_to_estado_articulo
		links_to_estado_art(EstadoInscripcion, controller: controller_name, action: action_name)
	end
end
