# encoding: UTF-8
class CprogramasController < ApplicationController
	before_filter :require_login, except: [:show, :index]
	layout 'institucion'
	def index
		# Se está accediendo a lista de programas por categoria /cprogramas/internos-externos
		# Detectar si se listan los programas por categoria internos o externos
		if params[:internos] != nil
			categoria = params[:internos]
			if can? :manage, Cprograma
				# Se listan todos los programas ignorando si están activos o no
				@cprogramas = Cprograma.where(categoria_interno: categoria).paginate(page: params[:page], per_page: 15)
			else
				# Solo programas activos para usuarios normales
				@cprogramas = Cprograma.where(categoria_interno: categoria, estado_programa_id: EstadoPrograma::ACTIVO).paginate(page: params[:page], per_page: 15)
			end
		else
			# Se está accediendo a lista de todos los programas /cprogramas/
			if can? :manage, Cprograma
				# Se listan todos los programas ignorando si están activos o no
				@cprogramas = Cprograma.paginate(page: params[:page], per_page: 15)
			else
				# Se listan los programas únicamente activos
				@cprogramas = Cprograma.where(estado_programa_id: EstadoPrograma::ACTIVO).paginate(page: params[:page], per_page: 15)
			end
		end
		render layout: 'application'
	end

	def show
		@programa = Cprograma.find(params[:id])
		if can? :manage, Cprograma
			# Si es admin lo deja ver el programa aunque éste no se encuentre en estado activo
			render layout: 'application'
		elsif current_user && current_user.institucion_user && @programa.institucion_user == current_user.institucion_user
			# Si es el usuario de institución quien está viendo su programa
			render layout: 'application'
		elsif @programa.estado_programa_id == EstadoPrograma::ACTIVO
			# Solo mostrar programas que estén en estado activo para usuarios normales
			render layout: 'application'
		else
			flash[:error] = "No puedes ver este programa"
			redirect_to root_path
		end
	end

	def print
		@programa = Cprograma.find(params[:id])
		render layout: 'application'
	end

	def new
		require_role(:institucion)
		@cprograma = Cprograma.new
		@cprograma.licenciaturas.build
		@cprograma.responsables.build
	end

	def create
		@cprograma = Cprograma.new(params[:cprograma])
		#Asignar fecha en caso de ser indeterminado
		d = Time.new()
		anio = d.strftime("%Y").to_i + 1
		if @cprograma.tiempo_indeterminado == true
			@cprograma.ftiempo = d.strftime("%d")+"/"+d.strftime("%m")+"/"+anio.to_s
		end
		#Agregar el nuevo TipoPrograma en caso de existir
		if params[:otroTipo] == 'false' 
			ot = TipoPrograma.new(:descripcion => params[:nombreOtroTipo])
			ot.save
			@cprograma.tipo_programa_id = ot.id
		end
		# Asignar ID del usuario logueado
		@cprograma.institucion_user_id = current_user.institucion_user.id
		# Asignar categoría
		@cprograma.categoria_interno = current_user.institucion_user.institucion.uacm? ? true : false
		# Estado
		@cprograma.estado_programa_id = EstadoPrograma::ESPERANDO
		if @cprograma.save
			#Obtener la suma de licenciaturas solicitadas
			sumLicen = Licenciatura.sum(:solicitados, :group => :cprograma)
			@cprograma.plazas = sumLicen[@cprograma]
			@cprograma.vacantes = sumLicen[@cprograma]
			@cprograma.save
			flash[:success] = "Programa creado correctamente"
			redirect_to current_user.user_page
		else
			flash.now[:error] = "Programa con errores"
			render 'new'
		end
	end


	def destroy
		authorize! :manage, Cprograma
		@cprograma = Cprograma.find(params[:id])
		if @cprograma.destroy
			flash[:success] = "Programa eliminado correctamente."
			redirect_to cprogramas_path
		else
			flash[:error] = "Ocurrió un error eliminando el programa."
			redirect_to cprogramas_path
		end
	end

	def edit
		#require_role(:institucion)
		@cprograma = Cprograma.find_by_id(params[:id])
		if current_user.institucion_user &&
			current_user.institucion_user.cprogramas.include?(@cprograma) &&
			@cprograma.estado_programa_id != EstadoPrograma::ACTIVO
			render 'edit'
		else 
			authorize! :manage, Cprograma
		end
	end

	def update
		@cprograma = Cprograma.find(params[:id])
		@cprograma.estado_programa_id = EstadoPrograma::ACTUALIZADO
		if @cprograma.update_attributes(params[:cprograma]) &&
			eliminar_licenciaturas(params[:cprograma][:licenciaturas_attributes]) &&
			eliminar_responsables(params[:cprograma][:responsables_attributes])
				flash[:success] = "Programa actualizado correctamente :-)"
				redirect_to current_user.user_page
		else
			flash.now[:error] = "Ocurrió un error actualizando el programa."
			render 'edit'
		end
	end

	# Actualizar solo el estado de un programa
	def update_status
		if Cprograma.update(params[:id], estado_programa_id: params[:status])
			flash[:success] = "Estado actualizado correctamente!"
		else
			flash[:error] = "Ocurrió un error actualizando el estado"
		end
		if logged_as? :institucion
			redirect_to updlist_cprogramas_path
		else
			redirect_to cprograma_path(params[:id])
		end
	end
	# Actualizar solo las observaciones de un programa
	def update_observaciones
		observaciones = params[:cprograma][:observaciones]
		if Cprograma.update(params[:id], observaciones: observaciones, estado_programa_id: EstadoPrograma::OBSERVACION)
			flash[:success] = "Observaciones actualizadas correctamente!"
		else
			flash[:error] = "Ocurrió un error actualizando las observaciones"
		end
		redirect_to cprograma_path(params[:id])
	end
	# Actualizar solo la clave de un programa
	def cambiar_clave
		@programa = Cprograma.find(params[:id])
		render layout: 'admin'
	end
	def update_clave
		nueva_clave = params[:cprograma][:cveprograma]
		if Cprograma.update(params[:id], {cveprograma: nueva_clave, estado_programa_id: EstadoPrograma::ACTIVO})
			flash[:success] = "Clave del programa actualizada correctamente!"
		else
			flash.now[:error] = "Ocurrió un error actualizando la clave del programa!"
		end
		redirect_to cprograma_path(params[:id])
	end

	# Generar clave de programa
	def generar_nueva_clave
		@id 					= params[:id]
		consecutivo 			= 1 + Cprograma.where('estado_programa_id != 4 AND estado_programa_id != 6').count
		programa = Cprograma.find(@id)
		current_year 			= Date.today.year.to_s[2..3]
		last_update_year 	= programa.updated_at.year.to_s[2..3]
		sufijo = programa.categoria_interno == true ? "INT" : "EXT"
		@clave = "UACM/SS/#{current_year}-#{last_update_year}/#{consecutivo}/#{sufjo}"
		respond_to do |format|
			format.js
		end
	end

	# Eliminar licenciaturas
	def eliminar_licenciaturas(params)
		if params && !params.empty?
			params.each { |l| Licenciatura.delete(l[1][:id]) if l[1]['_destroy'] == 'true' }
		else
			return true
		end
	end

	# Eliminar responsables
	def eliminar_responsables(params)
		if params && !params.empty?
			params.each { |r| Responsable.delete(r[1][:id]) if r[1]['_destroy'] == 'true' }
		else
			return true
		end
	end
end
