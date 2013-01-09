# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130109004253) do
  create_table "admins", :force => true do |t|
    t.string   "nombre",     :null => false
    t.string   "aPaterno",   :null => false
    t.string   "aMaterno",   :null => false
    t.date     "nacimiento", :null => false
    t.string   "cargo",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "alcance_programas", :force => true do |t|
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cprogramas", :force => true do |t|
    t.integer  "institucion_id"
    t.string   "cveprograma"
    t.integer  "estado_programa_id"
    t.string   "nombre"
    t.text     "objGeneral"
    t.text     "justificacion"
    t.text     "desarrollo"
    t.text     "recursos"
    t.text     "evaluacion"
    t.text     "resultados"
    t.string   "lugar"
    t.integer  "horario_programa_id"
    t.integer  "plazas"
    t.integer  "vacantes"
    t.text     "observaciones"
    t.text     "notas"
    t.date     "ftiempo"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "tipo_programa_id"
    t.boolean  "categoria_interno",    :default => true
    t.boolean  "tiempo_indeterminado", :default => true
  end

  add_index "cprogramas", ["cveprograma"], :name => "index_cprogramas_on_cveprograma"

  create_table "cprogramas_poblacion_programas", :id => false, :force => true do |t|
    t.integer "cprograma_id"
    t.integer "poblacion_programa_id"
  end

  create_table "estado_programas", :force => true do |t|
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "horario_programas", :force => true do |t|
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "inscripcions", :force => true do |t|
    t.boolean  "practicas"
    t.integer  "estado_inscripcion_id"
    t.integer  "prestador_id"
    t.integer  "institucion_id"
    t.integer  "plantel_id"
    t.string   "carrera"
    t.string   "matricula"
    t.integer  "ano_ingreso"
    t.integer  "semestre"
    t.float    "avance_cursos"
    t.float    "promedio"
    t.integer  "nCursos_basicos"
    t.integer  "nCursos_superio"
    t.integer  "creditos"
    t.string   "programa_institucional"
    t.string   "cve_programa_institucional"
    t.integer  "cprograma_id"
    t.string   "area"
    t.date     "fecha_inicio"
    t.date     "fecha_fin"
    t.time     "hora_entrada"
    t.time     "hora_salida"
    t.boolean  "difundir"
    t.string   "responsable"
    t.string   "cargoResponsable"
    t.string   "observaciones"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "institucion_users", :force => true do |t|
    t.integer  "institucion_id", :null => false
    t.integer  "plantel_id"
    t.string   "domicilio",      :null => false
    t.string   "area",           :null => false
    t.string   "responsable",    :null => false
    t.string   "cargo",          :null => false
    t.string   "tel",            :null => false
    t.string   "telExt",         :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "institucions", :force => true do |t|
    t.string   "nombre",                        :null => false
    t.boolean  "educativa",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "uacm",       :default => false
  end

  create_table "licenciaturas", :force => true do |t|
    t.integer  "cprograma_id"
    t.string   "carrera"
    t.string   "actividad"
    t.integer  "solicitados"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "plantels", :force => true do |t|
    t.integer  "institucion_id", :null => false
    t.string   "nombre",         :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "poblacion_programas", :force => true do |t|
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "prestadors", :force => true do |t|
    t.string   "nombre",      :null => false
    t.string   "aPaterno",    :null => false
    t.string   "aMaterno",    :null => false
    t.date     "nacimiento",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "sexo"
    t.string   "dCalle"
    t.string   "dNumExt"
    t.string   "dNumInt"
    t.string   "dCP"
    t.string   "dDelegacion"
    t.string   "dColonia"
    t.string   "telCasa"
    t.string   "telCel"
  end

  create_table "responsables", :force => true do |t|
    t.integer  "cprograma_id"
    t.string   "encargado"
    t.string   "cargo"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "tipo_programas", :force => true do |t|
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                     :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "prestador_id"
    t.integer  "admin_id"
    t.integer  "institucion_user_id"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
