class AddTypeToVaccines < ActiveRecord::Migration[7.1]
  def change
    add_column :vaccines, :type, :string
  end
end
