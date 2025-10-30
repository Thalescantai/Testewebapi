class AddStatusToConsultas < ActiveRecord::Migration[7.2]
  def change
    add_column :consultas, :status, :integer, default: 0, null: false
  end
end
