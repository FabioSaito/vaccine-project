class AddSlugToVaccines < ActiveRecord::Migration[7.1]
  def change
    add_column :vaccines, :slug, :string
    add_index :vaccines, [:slug, :dose], unique: true
  end
end
