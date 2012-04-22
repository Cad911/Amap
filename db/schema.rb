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

ActiveRecord::Schema.define(:version => 20120413092925) do

  create_table "abonnements", :force => true do |t|
    t.integer  "client_id"
    t.integer  "panier_id"
    t.date     "date_debut"
    t.date     "date_fin"
    t.date     "duree"
    t.integer  "deleted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "session_id"
    t.string   "etat"
  end

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "cageots", :force => true do |t|
    t.integer  "client_id"
    t.string   "etat"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "is_connected"
    t.string   "session_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "nom"
    t.string   "abbreviation"
    t.integer  "deleted"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "genre"
    t.string   "nom"
    t.string   "prenom"
    t.string   "adresse"
    t.string   "ville"
    t.integer  "code_postal"
    t.string   "pays"
    t.integer  "telephone"
    t.date     "naissance"
    t.integer  "newsletter"
    t.integer  "point_relai_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "clients", ["email"], :name => "index_clients_on_email", :unique => true
  add_index "clients", ["reset_password_token"], :name => "index_clients_on_reset_password_token", :unique => true

  create_table "droits", :force => true do |t|
    t.integer  "has_revendeur"
    t.integer  "autorisation_produit"
    t.integer  "can_stock_sr"
    t.integer  "can_stock_ar"
    t.integer  "deleted"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "nom"
  end

  create_table "entites", :force => true do |t|
    t.integer  "droit_id"
    t.string   "nom"
    t.integer  "deleted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "panier_autorises", :force => true do |t|
    t.integer  "user_id"
    t.integer  "categorie_id"
    t.string   "titre"
    t.text     "description"
    t.float    "prix_panier_ht"
    t.float    "prix_panier_ttc"
    t.integer  "deleted"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "paniers", :force => true do |t|
    t.integer  "revendeur_id"
    t.string   "titre"
    t.text     "description"
    t.integer  "nb_pack"
    t.float    "prix_unite_ht"
    t.float    "prix_unite_ttc"
    t.integer  "alaune"
    t.integer  "deleted"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "categorie_id"
    t.integer  "panier_autorise_id"
  end

  create_table "point_relais", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ville_id"
    t.string   "adresse"
    t.integer  "deleted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "produit_autorises", :force => true do |t|
    t.integer  "user_id"
    t.integer  "categorie_id"
    t.string   "titre"
    t.text     "description"
    t.integer  "deleted"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "produit_paniers", :force => true do |t|
    t.integer  "panier_id"
    t.integer  "stock_id"
    t.string   "titre"
    t.text     "description"
    t.integer  "quantite"
    t.integer  "deleted"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "produit_vente_libres", :force => true do |t|
    t.integer  "stock_id"
    t.string   "titre"
    t.text     "description"
    t.float    "quantite"
    t.integer  "nombre_pack"
    t.float    "prix_unite_ht"
    t.float    "prix_unite_ttc"
    t.integer  "alaune"
    t.integer  "deleted"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "user_id"
  end

  create_table "regions", :force => true do |t|
    t.string   "nom"
    t.integer  "cp"
    t.integer  "deleted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rel_cageot_produits", :force => true do |t|
    t.integer  "produit_vente_libre_id"
    t.integer  "cageot_id"
    t.integer  "nombre_pack"
    t.integer  "deleted"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "stocks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "categorie_id"
    t.integer  "unite_mesure_id"
    t.float    "quantite"
    t.string   "titre"
    t.text     "description"
    t.integer  "deleted"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "produit_autorise_id"
  end

  create_table "unite_mesures", :force => true do |t|
    t.string   "nom"
    t.string   "abbreviation"
    t.integer  "deleted"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "entite_id"
    t.integer  "direction_id"
    t.integer  "ville_id"
    t.integer  "mode_denvoi_id"
    t.string   "genre"
    t.string   "nom"
    t.string   "prenom"
    t.string   "nom_societe"
    t.text     "description"
    t.string   "adresse"
    t.integer  "telephone"
    t.date     "naissance"
    t.integer  "alaune"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "villes", :force => true do |t|
    t.integer  "region_id"
    t.string   "nom"
    t.integer  "cp"
    t.integer  "deleted"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
