# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_11_01_025643) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "consultas", force: :cascade do |t|
    t.integer "medico_id"
    t.datetime "data_hora"
    t.string "tipo"
    t.text "diagnostico"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "paciente_id"
    t.boolean "checkin", default: false, null: false
    t.integer "status", default: 0, null: false
    t.index ["medico_id"], name: "index_consultas_on_medico_id"
    t.index ["paciente_id"], name: "index_consultas_on_paciente_id"
  end

  create_table "enderecos", force: :cascade do |t|
    t.string "rua"
    t.string "numero"
    t.string "bairro"
    t.string "cep"
    t.string "cidade"
    t.string "complemento"
    t.string "logradouro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "paciente_id", null: false
    t.index ["paciente_id"], name: "index_enderecos_on_paciente_id"
  end

  create_table "exames", force: :cascade do |t|
    t.integer "consulta_id", null: false
    t.string "nome_exame"
    t.date "data_exame"
    t.string "status", default: "pendente"
    t.text "observacao_exame"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "data_realizacao"
    t.string "profissional_realizou_exame"
    t.index ["consulta_id"], name: "index_exames_on_consulta_id"
  end

  create_table "materials", force: :cascade do |t|
    t.integer "consulta_id", null: false
    t.string "nome_material", null: false
    t.integer "quantidade", default: 1, null: false
    t.date "data_pedido", null: false
    t.boolean "verificar_estoque", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consulta_id"], name: "index_materials_on_consulta_id"
  end

  create_table "pacientes", force: :cascade do |t|
    t.string "nome"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sexo"
    t.date "data_nascimento"
    t.string "celular"
    t.string "email"
    t.string "nome_social"
    t.string "horario"
    t.text "observacao"
    t.string "cartao_sus"
    t.string "profissao"
    t.string "rg"
    t.string "org_exp"
    t.string "escolaridade"
    t.string "raca"
    t.string "nacionalidade"
    t.string "estado_civil"
    t.string "naturalidade"
    t.string "nome_mae"
  end

  create_table "profissionais", force: :cascade do |t|
    t.string "nome", null: false
    t.string "email"
    t.string "telefone"
    t.string "cpf"
    t.string "cargo", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crm"
    t.index ["cpf"], name: "index_profissionais_on_cpf", unique: true
    t.index ["email"], name: "index_profissionais_on_email", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "cpf", null: false
    t.string "password_digest", null: false
    t.string "remember_token_digest"
    t.datetime "last_login_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "consultas", "pacientes"
  add_foreign_key "consultas", "profissionais", column: "medico_id"
  add_foreign_key "enderecos", "pacientes"
  add_foreign_key "exames", "consultas"
  add_foreign_key "materials", "consultas"
end
