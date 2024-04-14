class CreateVaccineCards < ActiveRecord::Migration[7.1]
  def change
    create_table :vaccine_cards do |t|
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
