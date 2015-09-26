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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150926202813) do

  create_table "operaciones", force: :cascade do |t|
    t.date     "fecha"
    t.integer  "operaciontipo_id"
    t.text     "desc"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.decimal  "total",            precision: 8, scale: 2
  end

  add_index "operaciones", ["operaciontipo_id"], name: "index_operaciones_on_operaciontipo_id"

  create_table "operacionitems", force: :cascade do |t|
    t.integer  "producto_id"
    t.integer  "cantidad"
    t.decimal  "precio",       precision: 10, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "operacion_id"
  end

  add_index "operacionitems", ["producto_id"], name: "index_operacionitems_on_producto_id"

  create_table "operaciontipos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizaciones", force: :cascade do |t|
    t.string   "nombre"
    t.string   "id_fiscal"
    t.string   "email"
    t.string   "telefono"
    t.text     "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "productos", force: :cascade do |t|
    t.string   "nombre"
    t.text     "desc"
    t.integer  "organizacion_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "image"
  end

  add_index "productos", ["organizacion_id"], name: "index_productos_on_organizacion_id"

end
