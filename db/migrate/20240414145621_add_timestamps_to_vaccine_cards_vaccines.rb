class AddTimestampsToVaccineCardsVaccines < ActiveRecord::Migration[7.1]
  def change
    change_table :vaccine_cards_vaccines do |t|
      t.timestamps
    end
  end
end
