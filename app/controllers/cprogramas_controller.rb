# encoding: UTF-8
class CprogramasController < ApplicationController
	before_filter :require_login, except: [:show, :index]
	layout 'institucion'
	def index
		# Se está accediendo a lista de programas por categoria /cprogramas/internos-externos
		# Detectar si se listan los programas por categoria internos o externos
		if params[:internos] != nil
			categoria = params[:internos]
			# Solo programas activos
			@cprogramas = Cprograma.where(categoria_interno: categoria, estado_programa_id: EstadoPrograma::ACTIVO).paginate(page: params[:page], per_page: 15)
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
			render layout: 'application'
		elsif @programa.estado_programa_id == EstadoPrograma::ACTIVO
			render layout: 'application'
		else
			flash[:error] = "No puedes ver este programa"
			redirect_to root_path
		end
	end

	def new
		require_role(:institucion)
		@cprograma = Cprograma.new
		@cprograma.licenciaturas.build
		@cprograma.responsables.build
	end

	def create
		@cprograma = Cprograma.new(params[:cprograma])
		# Asignar ID del usuario logueado
		@cprograma.institucion_user_id = current_user.institucion_user.id
		# Asignar categoría
		@cprograma.categoria_interno = current_user.institucion_user.institucion.uacm? ? true : false
		# Estado
		@cprograma.estado_programa_id = EstadoPrograma::ESPERANDO
		if @cprograma.save
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
		if current_user.institucion_user && current_user.institucion_user.cprogramas.include?(@cprograma)
			render 'edit'
		else 
			authorize! :manage, Cprograma
		end
	end

	def update
		@cprograma = Cprograma.find(params[:id])
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
		redirect_to cprograma_path(params[:id])
	end
	# Actualizar solo las observaciones de un programa
	def update_observaciones
		observaciones = params[:cprograma][:observaciones]
		if Cprograma.update(params[:id], observaciones: observaciones)
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
		if Cprograma.update(params[:id], cveprograma: nueva_clave)
			flash[:success] = "Clave del programa actualizada correctamente!"
		else
			flash.now[:error] = "Ocurrió un error actualizando la clave del programa!"
		end
		redirect_to cprograma_path(params[:id])
	end

	# Generar clave de programa
	def generar_nueva_clave
		@id 							= params[:id]
		consecutivo 			= 1 + Cprograma.where('estado_programa_id != 4 AND estado_programa_id != 6').count
		current_year 			= Date.today.year.to_s[2..3]
		last_update_year 	= Cprograma.find(@id).updated_at.year.to_s[2..3]
		@clave = "UACM/SS/#{current_year}-#{last_update_year}/#{consecutivo}"
		respond_to do |format|
			format.js
		end
	end

	# Eliminar licenciaturas
	def eliminar_licenciaturas(params)
		params.each { |l| Licenciatura.delete(l[1][:id]) if l[1]['_destroy'] == 'true' }
	end

	# Eliminar responsables
	def eliminar_responsables(params)
		params.each { |r| Responsable.delete(r[1][:id]) if r[1]['_destroy'] == 'true' }
	end
end
