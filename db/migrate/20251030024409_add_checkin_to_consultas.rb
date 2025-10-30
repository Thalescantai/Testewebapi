class AddCheckinToConsultas < ActiveRecord::Migration[7.2]
  def change
    add_column :consultas, :checkin, :boolean, default: false, null: false
  end
end
