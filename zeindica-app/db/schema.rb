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

ActiveRecord::Schema.define(:version => 20121208113734) do

  create_table "authentications", :force => true do |t|
    t.integer  "usuario_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cupons", :force => true do |t|
    t.integer  "usuario_id",                    :null => false
    t.integer  "premio_id",                     :null => false
    t.boolean  "premiado",   :default => false, :null => false
    t.boolean  "depositado", :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "cupons", ["premio_id"], :name => "index_cupons_on_premio_id"
  add_index "cupons", ["usuario_id"], :name => "index_cupons_on_usuario_id"

  create_table "empresas", :force => true do |t|
    t.string   "nome",                      :null => false
    t.string   "telefone",                  :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "imagem_topo_file_name"
    t.string   "imagem_meio_file_name"
    t.string   "imagem_inferior_file_name"
    t.string   "link_to_imagem_topo"
    t.string   "link_to_imagem_meio"
    t.string   "link_to_imagem_inferior"
  end

  create_table "premios", :force => true do |t|
    t.string   "nome",                   :null => false
    t.text     "descricao",              :null => false
    t.date     "sorteio",                :null => false
    t.integer  "empresa_id",             :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "imagem_nuvem_file_name"
    t.string   "imagem_info_file_name"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "email",              :default => "",    :null => false
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "nome"
    t.string   "facebook_link"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "admin",              :default => false, :null => false
  end

  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["facebook_link"], :name => "index_usuarios_on_facebook_link", :unique => true

end
