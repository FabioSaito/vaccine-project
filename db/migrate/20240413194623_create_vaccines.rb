class CreateVaccines < ActiveRecord::Migration[7.1]
  def change
    create_table :vaccines do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
