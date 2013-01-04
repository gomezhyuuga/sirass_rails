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

ActiveRecord::Schema.define(:version => 20130104032754) do

  create_table "admins", :force => true do |t|
    t.string   "nombre",     :null => false
    t.string   "aPaterno",   :null => false
    t.string   "aMaterno",   :null => false
    t.date     "nacimiento", :null => false
    t.string   "cargo",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cprogramas", :force => true do |t|
    t.integer  "institucion_id"
    t.string   "cveprograma"
    t.integer  "categoria_id"
    t.integer  "status_id"
    t.string   "nombre"
    t.text     "objGeneral"
    t.text     "justificacion"
    t.text     "desarrollo"
    t.text     "recursos"
    t.text     "evaluacion"
    t.text     "resultados"
    t.string   "lugar"
    t.integer  "horario_id"
    t.integer  "plazas"
    t.integer  "vacantes"
    t.text     "observaciones"
    t.text     "notas"
    t.integer  "tiempo_id"
    t.date     "ftiempo"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "cprogramas", ["cveprograma"], :name => "index_cprogramas_on_cveprograma"

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
    t.boolean  "uacm"
  end

  create_table "myTabla", :force => true do |t|
    t.string  "micolumna1",                    :null => false
    t.boolean "micolumna2", :default => false
  end

  create_table "plantels", :force => true do |t|
    t.integer  "institucion_id", :null => false
    t.string   "nombre",         :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
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

  create_table "programas", :force => true do |t|
    t.string   "cvePrograma"
    t.string   "nombre"
    t.text     "objetivoGeneral"
    t.text     "justificacion"
    t.text     "desarrollo"
    t.text     "recursos"
    t.text     "evaluacion"
    t.text     "resultados"
    t.string   "lugar"
    t.integer  "plazas"
    t.integer  "ocupadas"
    t.text     "observaciones"
    t.text     "notas"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "programas", ["cvePrograma"], :name => "index_programas_on_cvePrograma", :unique => true

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
