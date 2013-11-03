# encoding: UTF-8
class CprogramasController < ApplicationController
	before_filter :require_login, except: [:show, :index]
	layout 'institucion'
	def index
		# Se está accediendo a lista de programas por categoria /cprogramas/internos-externos
		# Detectar si se listan los programas por categoria internos o externos
		conditions = {}
		conditions[:categoria_interno] = params[:internos] if params[:internos] != nil
		conditions[:estado_programa_id] = params[:estado].to_i if params[:estado] != nil
		# Solo listar programas activos para usuarios normales
		unless can? :manage, Cprograma
			conditions[:estado_programa_id] = EstadoPrograma::ACTIVO
		end

		@cprogramas = Cprograma.page(params[:page]).where(conditions)
		render layout: 'application'
	end

	def search
		like = "LIKE"
		if ActiveRecord::Base.connection.adapter_name.downcase == "postgresql"
			like = "ILIKE"
		end
		if can? :manage, Cprograma
			@cprogramas = Cprograma.page(params[:page]).where("nombre #{like} ?", "%#{params[:programa]}%")
			flash.now[:error] = "Búsqueda sin resultados" unless @cprogramas
			render :index, layout: 'application'
		end
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
		c = Configuracion.find_by_nombre("convocatoria")
		require_role(:institucion)
		if c.valor == "Activar" or can? :manage, Cprograma
			@cprograma = Cprograma.new
			@cprograma.licenciaturas.build
			@cprograma.responsables.build
		else
			flash[:error] = "La convocatoria no esta vigente; así que no puedes enviar o actualizar tus programas"
			redirect_to current_user.user_page
		end
	end

	def create
		c = Configuracion.find_by_nombre("convocatoria")
		if c.valor == "Activar" or can? :manage, Cprograma
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
      			if @cprograma.save
					flash[:success] = "Programa creado correctamente"
					redirect_to current_user.user_page
				else
					flash.now[:error] = "Programa con errores"
					render 'new'
				end
			else
				flash.now[:error] = "Programa con errores"
				render 'new'
			end
		else
			flash[:error] = "La convocatoria no esta vigente; así que no puedes enviar o actualizar tus programas"
			redirect_to current_user.user_page
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
		c = Configuracion.find_by_nombre("convocatoria")
		if c.valor == "Activar" or can? :manage, Cprograma
			#require_role(:institucion)
			@cprograma = Cprograma.find_by_id(params[:id])
			if current_user.institucion_user &&
				current_user.institucion_user.cprogramas.include?(@cprograma) &&
				@cprograma.estado_programa_id != EstadoPrograma::ACTIVO
				render 'edit'
			else 
				authorize! :manage, Cprograma
				render 'edit', layout: 'admin'
			end
		else
			flash[:error] = "La convocatoria no esta vigente; así que no puedes enviar o actualizar tus programas"
			redirect_to current_user.user_page
		end
	end

	def update
		c = Configuracion.find_by_nombre("convocatoria")
		if c.valor == "Activar" or can? :manage, Cprograma
			@cprograma = Cprograma.find(params[:id])
			# Volver a calcular plazas y vacantes
			plazas_ocupadas = @cprograma.plazas_ocupadas
			solicitados = 0
			@cprograma.licenciaturas.each { |l| solicitados += l.solicitados }
			@cprograma.plazas = solicitados
			@cprograma.vacantes = solicitados - plazas_ocupadas
			
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
		else
			flash[:error] = "La convocatoria no esta vigente; así que no puedes enviar o actualizar tus programas"
			redirect_to current_user.user_page
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
		@id 							= params[:id]
		programa 					= Cprograma.find(@id)
		# Obtiene los programas que ya tienen alguna clave asignada. Esta cantidad nos provee el número consecutivo
		consecutivo 			= 1 + Cprograma.where("cveprograma IS NOT NULL AND cveprograma != ''").count
		# year 							= Date.today.year.to_s[2..3]
		# Solo usar últimos dos dígitos del año (2013 -> 13)
		year 							= programa.created_at.year.to_s[2..3]
		last_update_year 	= programa.updated_at.year.to_s[2..3]
		sufijo = programa.categoria_interno == true ? "INT" : "EXT"
		@clave = "UACM/SS/#{year}-#{last_update_year}/#{consecutivo}/#{sufijo}"
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
