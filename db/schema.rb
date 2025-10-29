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

ActiveRecord::Schema[7.2].define(version: 2025_10_29_163005) do
  create_table "consultas", force: :cascade do |t|
    t.integer "medico_id"
    t.datetime "data_hora"
    t.string "tipo"
    t.text "anamnese"
    t.text "diagnostico"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medico_id"], name: "index_consultas_on_medico_id"
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
    t.string "tipo_exame"
    t.date "data_solicitacao"
    t.date "data_marcada"
    t.date "data_realizada"
    t.string "status", default: "pendente"
    t.text "observacoes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consulta_id"], name: "index_exames_on_consulta_id"
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

  add_foreign_key "consultas", "profissionais", column: "medico_id"
  add_foreign_key "enderecos", "pacientes"
  add_foreign_key "exames", "consultas"
end
