class AddCrmToProfissionais < ActiveRecord::Migration[7.2]
  def change
    add_column :profissionais, :crm, :string
  end
end
