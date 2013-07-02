# encoding: utf-8
namespace :db do
	desc "Elimina la base de datos y vuelve a cargar la info"
	task reset_all: [:environment, 'db:reset', 'db:migrate', 'db:uacm:all'] do
		
	end

	desc "Configuraciones iniciales"
	task :configs => [:environment] do
		puts "Importando configuraciones iniciales"
		csv_text = File.read('db/csv/configs.csv')
		csv = CSV.parse(csv_text, :headers => true)
		csv.each do |row|
			row = row.to_hash.with_indifferent_access
			Configuracion.create!(row.to_hash.symbolize_keys)
		end
	end 
end

namespace :utils do
	desc "Inscribir a un prestador"
	task :inscribir => :environment do
		id = ENV["ID"]
		estado = ENV["ESTADO"] || EstadoInscripcion::EN_SERVICIO
		i = Inscripcion.create({
			prestador_id: id,
			practicas: false,
			estado_inscripcion_id: estado,
			institucion_id: Institucion.first.id,
			plantel_id: Plantel.first.id,
			carrera: "Técnico en programación",
			matricula: "201090251",
			ano_ingreso: 2009,
			semestre: 6,
			avance_cursos: 100,
			promedio: 8.5,
			programa_institucional: "Apoyo Académico",
			cve_programa_institucional: "223123edead2",
			cprograma_id: Cprograma.first.id,
			area: "Oficina de Servicio Social",
			fecha_inicio: "02/02/2010",
			fecha_fin: "02/08/2010",
			hora_entrada: "08:00",
			hora_salida: "12:00",
			difundir: true,
			responsable: "Martha G. Tera",
			cargoResponsable: "Responsable de servicio"
		})
		p = Prestador.find(id)
		p.inscripcion_actual = i.id
		p.save
	end

	desc "Recalcular horas de servicio de todas las inscripciones"
	task :calcular_horas => [:environment] do
		Inscripcion.calcular_horas_all_inscripciones()
	end
end