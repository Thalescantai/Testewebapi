class CreateMaterials < ActiveRecord::Migration[7.2]
  def change
    create_table :materials do |t|
      t.references :consulta, null: false, foreign_key: true
      t.string :nome_material, null: false
      t.integer :quantidade, null: false, default: 1
      t.date :data_pedido, null: false
      t.boolean :verificar_estoque, null: false, default: false

      t.timestamps
    end
  end
end
